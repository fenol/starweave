import 'package:flutter/material.dart';
import '../models/star_model.dart';
import '../models/level_model.dart';
import '../game/game_state.dart';

// ── Кольори спектрів (пастельна палітра) ─────────────────────────────────────
class SpectrumColors {
  static Color of(StarSpectrum s) => switch (s) {
    StarSpectrum.blue  => const Color(0xFF8FBBCC), // пильний небесний
    StarSpectrum.white => const Color(0xFFD8D4C8), // тепла крем
    StarSpectrum.gold  => const Color(0xFFC4AB78), // пильне золото
    StarSpectrum.red   => const Color(0xFFBE7870), // терракота-рожевий
  };

  static Color glowOf(StarSpectrum s) => switch (s) {
    StarSpectrum.blue  => const Color(0xFF9CCAD8),
    StarSpectrum.white => const Color(0xFFE8E4DA),
    StarSpectrum.gold  => const Color(0xFFD4BD8C),
    StarSpectrum.red   => const Color(0xFFCC8C84),
  };
}

// ── StarGridWidget ────────────────────────────────────────────────────────────
class StarGridWidget extends StatefulWidget {
  final LevelData level;
  final GameState gameState;
  final List<(int, int)> highlightCells;
  final bool showHints;

  const StarGridWidget({
    super.key,
    required this.level,
    required this.gameState,
    this.highlightCells = const [],
    this.showHints = false,
  });

  @override
  State<StarGridWidget> createState() => _StarGridWidgetState();
}

class _StarGridWidgetState extends State<StarGridWidget>
    with TickerProviderStateMixin {

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _successController;
  double _cellSize = 0;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );

    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void didUpdateWidget(StarGridWidget old) {
    super.didUpdateWidget(old);
    if (widget.gameState.state == LevelState.success &&
        old.gameState.state != LevelState.success) {
      _successController.forward();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _successController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxCellW = constraints.maxWidth  / widget.level.cols;
        final maxCellH = constraints.maxHeight / widget.level.rows;
        _cellSize = maxCellW < maxCellH ? maxCellW : maxCellH;

        return GestureDetector(
          onTapDown: (details) => _onTap(details.localPosition),
          child: AnimatedBuilder(
            animation: Listenable.merge([_pulseAnimation, _successController]),
            builder: (context, _) {
              return CustomPaint(
                size: Size(
                  _cellSize * widget.level.cols,
                  _cellSize * widget.level.rows,
                ),
                painter: _GridPainter(
                  level: widget.level,
                  gameState: widget.gameState,
                  cellSize: _cellSize,
                  pulseValue: _pulseAnimation.value,
                  successValue: _successController.value,
                  highlightCells: widget.highlightCells,
                  errorStar: widget.gameState.errorStar,
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onTap(Offset localPos) {
    final col = (localPos.dx / _cellSize).floor();
    final row = (localPos.dy / _cellSize).floor();
    if (row < 0 || row >= widget.level.rows) return;
    if (col < 0 || col >= widget.level.cols) return;
    final star = widget.level.starAt(row, col);
    if (star == null) return;
    widget.gameState.onStarTapped(star);
  }
}

// ── CustomPainter ─────────────────────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  final LevelData level;
  final GameState gameState;
  final double cellSize;
  final double pulseValue;
  final double successValue;
  final List<(int, int)> highlightCells;
  final GridStar? errorStar;

  // Яскравий червоний для помилки — виділяється на фоні пастельних кольорів
  static const Color _errorColor = Color(0xFFE04848);

  _GridPainter({
    required this.level,
    required this.gameState,
    required this.cellSize,
    required this.pulseValue,
    required this.successValue,
    required this.highlightCells,
    this.errorStar,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawCells(canvas);      // 1. Тайли-клітинки (фон)
    _drawPath(canvas);       // 2. Шлях з halo
    _drawStars(canvas);      // 3. Зірки-ромби
    _drawHighlights(canvas); // 4. Підсвітка туторіалу (поверх зірок, outline)
    _drawMarkers(canvas);    // 5. A / B маркери
  }

  Offset _center(int row, int col) => Offset(
    col * cellSize + cellSize / 2,
    row * cellSize + cellSize / 2,
  );

  // ── 1. Тайли-клітинки ────────────────────────────────────────────────────

  void _drawCells(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final half = cellSize * 0.44;

    for (int row = 0; row < level.rows; row++) {
      for (int col = 0; col < level.cols; col++) {
        if (level.starAt(row, col) == null) continue;

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: _center(row, col),
              width:  half * 2,
              height: half * 2,
            ),
            const Radius.circular(2),
          ),
          paint,
        );
      }
    }
  }

  // ── 2. Шлях ───────────────────────────────────────────────────────────────

  void _drawPath(Canvas canvas) {
    final path = gameState.path;
    if (path.isEmpty) return;

    final isTooLong = gameState.state == LevelState.pathTooLong;

    // Нормальні сегменти — при pathTooLong пропускаємо останній (він буде червоним)
    final normalEnd = isTooLong ? path.length - 2 : path.length - 1;
    for (int i = 0; i < normalEnd; i++) {
      final from  = path[i];
      final to    = path[i + 1];
      _drawSegment(
        canvas,
        _center(from.star.row, from.star.col),
        _center(to.star.row,   to.star.col),
        SpectrumColors.glowOf(from.usedSpectrum),
      );
    }

    // Останній сегмент червоним при pathTooLong
    if (isTooLong && path.length >= 2) {
      final from = path[path.length - 2];
      final to   = path[path.length - 1];
      _drawErrorSegment(
        canvas,
        _center(from.star.row, from.star.col),
        _center(to.star.row,   to.star.col),
      );
    }

    // Червона лінія до відхиленої зірки (spectrumError)
    if (errorStar != null) {
      _drawErrorSegment(
        canvas,
        _center(path.last.star.row, path.last.star.col),
        _center(errorStar!.row, errorStar!.col),
      );
    }
  }

  void _drawSegment(Canvas canvas, Offset a, Offset b, Color color) {
    canvas.drawLine(a, b, Paint()
      ..color = color.withOpacity(0.16)
      ..strokeWidth = cellSize * 0.38
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke);
    canvas.drawLine(a, b, Paint()
      ..color = color.withOpacity(0.82)
      ..strokeWidth = cellSize * 0.06
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke);
  }

  void _drawErrorSegment(Canvas canvas, Offset a, Offset b) {
    canvas.drawLine(a, b, Paint()
      ..color = _errorColor.withOpacity(0.20)
      ..strokeWidth = cellSize * 0.38
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke);
    canvas.drawLine(a, b, Paint()
      ..color = _errorColor.withOpacity(0.88)
      ..strokeWidth = cellSize * 0.06
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke);
  }

  // ── 3. Зірки ──────────────────────────────────────────────────────────────

  void _drawStars(Canvas canvas) {
    final pathMap = {
      for (final n in gameState.path) (n.star.row, n.star.col): n,
    };

    for (int row = 0; row < level.rows; row++) {
      for (int col = 0; col < level.cols; col++) {
        final star = level.starAt(row, col);
        if (star == null) continue;

        final center = _center(row, col);
        final pathNode = pathMap[(row, col)];

        if (star.isBinary) {
          _drawBinaryStar(canvas, center, star, pathNode);
        } else {
          _drawNormalStar(canvas, center, star, pathNode != null);
        }
      }
    }
  }

  void _drawNormalStar(
    Canvas canvas, Offset center, GridStar star, bool onPath,
  ) {
    // Хибна зірка спектру (відхилена, не в шляху)
    final isSpectrumError = errorStar != null &&
        errorStar!.row == star.row &&
        errorStar!.col == star.col;

    // Остання зірка шляху при pathTooLong (вже в шляху, але В не досягнуто)
    final isTooLongStar = gameState.state == LevelState.pathTooLong &&
        gameState.path.isNotEmpty &&
        gameState.path.last.star.row == star.row &&
        gameState.path.last.star.col == star.col;

    final Color color;
    final double radius;

    if (isSpectrumError || isTooLongStar) {
      color  = _errorColor.withOpacity(0.82);
      radius = cellSize * 0.22;
    } else if (onPath) {
      color  = SpectrumColors.glowOf(star.spectrum);
      radius = cellSize * 0.24;
    } else {
      color  = SpectrumColors.of(star.spectrum).withOpacity(0.68);
      radius = cellSize * 0.17;
    }

    _drawDiamond(canvas, center, radius, color);
  }

  void _drawBinaryStar(
    Canvas canvas, Offset center, GridStar star, PathNode? pathNode,
  ) {
    final radius = cellSize * 0.21;
    final onPath = pathNode != null;

    // Стан помилки: бінарна зірка сама є джерелом помилки
    final isError = errorStar != null &&
        errorStar!.row == star.row &&
        errorStar!.col == star.col;

    // Остання зірка при pathTooLong
    final isTooLong = gameState.state == LevelState.pathTooLong &&
        gameState.path.isNotEmpty &&
        gameState.path.last.star.row == star.row &&
        gameState.path.last.star.col == star.col;

    if (isError || isTooLong) {
      _drawDiamond(canvas, center, radius, _errorColor.withOpacity(0.82));
      _drawDiamondOutline(canvas, center, radius * 1.35, _errorColor.withOpacity(0.22));
      return;
    }

    if (onPath) {
      // Повний ромб кольором поточного активного спектру
      final spec = pathNode.usedSpectrum;
      _drawDiamond(canvas, center, radius, SpectrumColors.glowOf(spec));
      // Тонкий контур — візуальний маркер "це бінарна"
      _drawDiamondOutline(canvas, center, radius * 1.38,
          SpectrumColors.glowOf(spec).withOpacity(0.25));
      return;
    }

    // Не в шляху: ромб наполовину зафарбований (лівий трикутник = primary)
    // Контур усього ромба
    _drawDiamondOutline(canvas, center, radius,
        SpectrumColors.of(star.spectrum).withOpacity(0.35));

    // Ліва половина = primary color
    final leftHalf = Path()
      ..moveTo(center.dx, center.dy - radius)   // верхній кут
      ..lineTo(center.dx - radius, center.dy)    // лівий кут
      ..lineTo(center.dx, center.dy + radius)    // нижній кут
      ..close();
    canvas.drawPath(leftHalf, Paint()
      ..color = SpectrumColors.of(star.spectrum).withOpacity(0.72)
      ..style = PaintingStyle.fill);

    // Центральна лінія-поділ
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      Paint()
        ..color = Colors.white.withOpacity(0.15)
        ..strokeWidth = 0.6
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawDiamondOutline(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path()
      ..moveTo(center.dx, center.dy - radius)
      ..lineTo(center.dx + radius, center.dy)
      ..lineTo(center.dx, center.dy + radius)
      ..lineTo(center.dx - radius, center.dy)
      ..close();
    canvas.drawPath(path, Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8);
  }

  /// Ромб (rotated square) — основна форма зірки
  void _drawDiamond(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path()
      ..moveTo(center.dx,          center.dy - radius)
      ..lineTo(center.dx + radius, center.dy)
      ..lineTo(center.dx,          center.dy + radius)
      ..lineTo(center.dx - radius, center.dy)
      ..close();

    canvas.drawPath(path, Paint()
      ..color = color
      ..style = PaintingStyle.fill);
  }

  // ── 4. Підсвітка туторіалу ────────────────────────────────────────────────

  void _drawHighlights(Canvas canvas) {
    if (highlightCells.isEmpty) return;

    final half = cellSize * 0.44;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (final (row, col) in highlightCells) {
      paint.color = Colors.white.withOpacity(0.20 + pulseValue * 0.18);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: _center(row, col),
            width:  half * 2,
            height: half * 2,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  // ── 5. A / B маркери ──────────────────────────────────────────────────────

  void _drawMarkers(Canvas canvas) {
    _drawMarker(canvas, level.startPos.$1, level.startPos.$2, 'A');
    _drawMarker(canvas, level.endPos.$1,   level.endPos.$2,   'B');
  }

  void _drawMarker(Canvas canvas, int row, int col, String label) {
    final center = _center(row, col);
    final star   = level.starAt(row, col);
    if (star == null) return;

    final color    = SpectrumColors.glowOf(star.spectrum);
    final ringSize = cellSize * 0.36 + pulseValue * cellSize * 0.05;

    // Пульсуючий квадрат-outline навколо клітинки
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center,
          width:  ringSize * 2,
          height: ringSize * 2,
        ),
        const Radius.circular(2),
      ),
      Paint()
        ..color = color.withOpacity(0.28 + pulseValue * 0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Мітка A / B над маркером
    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: color.withOpacity(0.72),
          fontSize: cellSize * 0.18,
          fontWeight: FontWeight.w300,
          letterSpacing: 1.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(canvas,
      center - Offset(tp.width / 2, ringSize + tp.height + 2));
  }

  @override
  bool shouldRepaint(_GridPainter old) => true;
}
