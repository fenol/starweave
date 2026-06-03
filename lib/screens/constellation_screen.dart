import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/constellation_model.dart';
import '../models/level_model.dart';
import 'level_screen.dart';
import '../widgets/story_popup.dart';

class ConstellationScreen extends StatefulWidget {
  final ConstellationChapter chapter;

  /// Повертає дані рівня за індексом зірки (0–N).
  /// Різні розділи передають свою функцію.
  final LevelData? Function(int index) levelLoader;

  const ConstellationScreen({
    super.key,
    required this.chapter,
    required this.levelLoader,
  });

  @override
  State<ConstellationScreen> createState() => _ConstellationScreenState();
}

class _ConstellationScreenState extends State<ConstellationScreen>
    with TickerProviderStateMixin {

  // Показуємо легенду лише один раз за сесію (per chapter)
  static final Set<String> _shownStories = {};

  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseAnim;

  Size? _mapSize;
  int? _tappedIndex;
  late final List<_BgStar> _bgStars;

  // ── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _pulseAnim = CurvedAnimation(
      parent: _pulseCtrl,
      curve: Curves.easeInOut,
    );

    final rng = math.Random(42);
    _bgStars = List.generate(110, (_) => _BgStar(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      radius: rng.nextDouble() * 1.3 + 0.3,
      opacity: rng.nextDouble() * 0.45 + 0.08,
    ));

    // storyOnCompletion=false (Orion): показуємо при першому вході
    final chapterKey = widget.chapter.nameLatin;
    if (widget.chapter.story != null &&
        !widget.chapter.storyOnCompletion &&
        !_shownStories.contains(chapterKey)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _shownStories.add(chapterKey);
        StoryPopup.show(context, widget.chapter);
      });
    }
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  // ── Tap logic ────────────────────────────────────────────────────────────

  void _onTapUp(TapUpDetails details) {
    final size = _mapSize;
    if (size == null) return;
    const pad = _ConstellationPainter.mapPadding;

    for (int i = 0; i < widget.chapter.stars.length; i++) {
      final star = widget.chapter.stars[i];
      if (star.isDecoration) continue; // декоративні зірки не інтерактивні
      final pos = Offset(
        pad + star.x * (size.width  - 2 * pad),
        pad + star.y * (size.height - 2 * pad),
      );
      if ((details.localPosition - pos).distance < 28) {
        _onStarTapped(i, star);
        return;
      }
    }
    setState(() => _tappedIndex = null);
  }

  void _onStarTapped(int index, ConstellationStar star) {
    setState(() => _tappedIndex = index);

    if (!star.isUnlocked && !star.isCompleted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppTheme.skyColor,
        content: Text(
          'Пройди попередні рівні щоб відкрити цю зірку',
          style: AppTheme.bodyStyle.copyWith(fontSize: 13),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ));
      return;
    }
    _openLevel(star);
  }

  Future<void> _openLevel(ConstellationStar star) async {
    final levelData = widget.levelLoader(star.levelIndex);

    if (levelData == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppTheme.skyColor,
        content: Text('Рівень ${star.levelIndex + 1} — незабаром',
            style: AppTheme.bodyStyle.copyWith(fontSize: 13)),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ));
      if (mounted) setState(() => _tappedIndex = null);
      return;
    }

    final completed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => LevelScreen(level: levelData)),
    );

    if (!mounted) return;
    if (completed == true) {
      widget.chapter.unlockNext(star.levelIndex);

      // storyOnCompletion=true (Perseus, Ursa Major): показуємо після
      // останнього рівня, рівно один раз
      final doneKey = '${widget.chapter.nameLatin}_done';
      if (widget.chapter.story != null &&
          widget.chapter.storyOnCompletion &&
          widget.chapter.isFullyCompleted &&
          !_shownStories.contains(doneKey)) {
        _shownStories.add(doneKey);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          StoryPopup.show(context, widget.chapter);
        });
      }
    }
    setState(() => _tappedIndex = null);
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildMap()),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final done  = widget.chapter.completedCount;
    final total = widget.chapter.totalLevels;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 12, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: AppTheme.textSecondary, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.chapter.nameLatin.toUpperCase(),
                      style: AppTheme.labelStyle.copyWith(
                        fontSize: 10,
                        letterSpacing: 5,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.chapter.name.toUpperCase(),
                      style: AppTheme.titleStyle.copyWith(
                        fontSize: 20,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$done / $total',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 16,
                  color: done == total
                      ? AppTheme.accent
                      : AppTheme.textSecondary,
                ),
              ),
              Text(
                'РІВНІВ',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 8,
                  letterSpacing: 2,
                  color: AppTheme.textSecondary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return ClipRect(
      child: GestureDetector(
        onTapUp: _onTapUp,
        child: AnimatedBuilder(
          animation: _pulseAnim,
          builder: (_, __) {
            return LayoutBuilder(builder: (ctx, constraints) {
              _mapSize = Size(constraints.maxWidth, constraints.maxHeight);
              return SizedBox.expand(
                child: CustomPaint(
                  painter: _ConstellationPainter(
                    chapter: widget.chapter,
                    bgStars: _bgStars,
                    pulse: _pulseAnim.value,
                    tappedIndex: _tappedIndex,
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildBottom() {
    final hasStory = widget.chapter.story != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(28, 8, 28, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: AppTheme.constellationLine.withOpacity(0.15),
            height: 1,
          ),
          const SizedBox(height: 12),

          // Цитата (скорочена до 2 рядків якщо є кнопка легенди)
          Text(
            widget.chapter.mythQuote,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: AppTheme.textSecondary.withOpacity(0.6),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
            maxLines: hasStory ? 2 : 3,
            overflow: TextOverflow.ellipsis,
          ),

          // Посилання «ЛЕГЕНДА» — для on-entry завжди; для on-completion лише після фінішу
          if (hasStory &&
              (!widget.chapter.storyOnCompletion ||
               widget.chapter.isFullyCompleted)) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => StoryPopup.show(context, widget.chapter),
              child: Text(
                'ЛЕГЕНДА  →',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 10,
                  letterSpacing: 3,
                  color: AppTheme.accent.withOpacity(0.75),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Допоміжні класи
// ─────────────────────────────────────────────────────────────────────────────

class _BgStar {
  final double x, y, radius, opacity;
  const _BgStar({
    required this.x,
    required this.y,
    required this.radius,
    required this.opacity,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// CustomPainter
// ─────────────────────────────────────────────────────────────────────────────

class _ConstellationPainter extends CustomPainter {
  final ConstellationChapter chapter;
  final List<_BgStar> bgStars;
  final double pulse;
  final int? tappedIndex;

  static const double mapPadding = 32.0;

  _ConstellationPainter({
    required this.chapter,
    required this.bgStars,
    required this.pulse,
    this.tappedIndex,
  });

  Offset _pos(ConstellationStar star, Size size) => Offset(
    mapPadding + star.x * (size.width  - 2 * mapPadding),
    mapPadding + star.y * (size.height - 2 * mapPadding),
  );

  @override
  void paint(Canvas canvas, Size size) {
    _paintBg(canvas, size);
    _paintLines(canvas, size);
    _paintStars(canvas, size);
  }

  void _paintBg(Canvas canvas, Size size) {
    final p = Paint();
    for (final s in bgStars) {
      p.color = AppTheme.starInactive.withOpacity(s.opacity);
      canvas.drawCircle(Offset(s.x * size.width, s.y * size.height), s.radius, p);
    }
  }

  void _paintLines(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.stroke;
    for (final line in chapter.lines) {
      final a = chapter.stars[line.fromIndex];
      final b = chapter.stars[line.toIndex];
      final aPos = _pos(a, size);
      final bPos = _pos(b, size);
      final bothDone  = a.isCompleted && b.isCompleted;
      final anyActive = (a.isUnlocked || a.isCompleted) &&
                        (b.isUnlocked || b.isCompleted);
      p.color = AppTheme.constellationLine.withOpacity(
        bothDone ? 0.65 : anyActive ? 0.30 : 0.10,
      );
      p.strokeWidth = bothDone ? 1.5 : 1.0;
      canvas.drawLine(aPos, bPos, p);
    }
  }

  void _paintStars(Canvas canvas, Size size) {
    for (int i = 0; i < chapter.stars.length; i++) {
      final star   = chapter.stars[i];
      final pos    = _pos(star, size);
      final tapped = tappedIndex == i;
      if (star.isDecoration) {
        _paintDecorationStar(canvas, pos, star);
      } else if (star.isCompleted) {
        _paintCompleted(canvas, pos, tapped);
        _paintLabel(canvas, star, pos, active: true);
      } else if (star.isUnlocked) {
        _paintUnlocked(canvas, pos, tapped, pulse);
        _paintLabel(canvas, star, pos, active: true);
      } else {
        _paintLocked(canvas, pos);
        _paintLabel(canvas, star, pos, active: false);
      }
    }
  }

  // Декоративна зірка: маленька крапка + тільки грецька літера
  void _paintDecorationStar(Canvas canvas, Offset pos, ConstellationStar star) {
    canvas.drawCircle(pos, 2.2,
        Paint()..color = AppTheme.starInactive.withOpacity(0.28));

    final labelY = pos.dy < mapPadding + 20 ? pos.dy + 14 : pos.dy - 18;
    _drawText(canvas, star.greekLetter,
      Offset(pos.dx, labelY),
      fontSize: 9,
      italic: true,
      color: AppTheme.textSecondary.withOpacity(0.22),
    );
  }

  void _paintCompleted(Canvas canvas, Offset pos, bool tapped) {
    canvas.drawCircle(pos, 20, Paint()
      ..color = AppTheme.accent.withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14));
    canvas.drawCircle(pos, 6, Paint()..color = AppTheme.starActive);
    canvas.drawCircle(pos - const Offset(1.5, 1.5), 2.2,
        Paint()..color = Colors.white.withOpacity(0.75));
    if (tapped) {
      canvas.drawCircle(pos, 13, Paint()
        ..color = AppTheme.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5);
    }
  }

  void _paintUnlocked(Canvas canvas, Offset pos, bool tapped, double p) {
    canvas.drawCircle(pos, 14 + 6 * p, Paint()
      ..color = AppTheme.constellationLine.withOpacity(0.22 * p)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8 + 6 * p));
    canvas.drawCircle(pos, 5, Paint()
      ..color = Color.lerp(AppTheme.starInactive, AppTheme.starActive, p * 0.6)!);
    canvas.drawCircle(pos, 2, Paint()..color = Colors.white.withOpacity(0.55 * p));
    if (tapped) {
      canvas.drawCircle(pos, 11, Paint()
        ..color = AppTheme.constellationLine
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5);
    }
  }

  void _paintLocked(Canvas canvas, Offset pos) {
    canvas.drawCircle(pos, 3.5,
        Paint()..color = AppTheme.starInactive.withOpacity(0.22));
    _paintLock(canvas, pos);
  }

  void _paintLock(Canvas canvas, Offset starPos) {
    final center = starPos.translate(0, 12);
    final p = Paint()
      ..color = AppTheme.textSecondary.withOpacity(0.32)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 8, height: 6),
        const Radius.circular(1.5),
      ),
      p,
    );
    canvas.drawArc(
      Rect.fromCenter(center: center.translate(0, -3), width: 6, height: 5),
      math.pi, math.pi, false, p,
    );
  }

  void _paintLabel(
    Canvas canvas,
    ConstellationStar star,
    Offset pos, {
    required bool active,
  }) {
    final opacity   = active ? 0.85 : 0.28;
    final completed = star.isCompleted;
    final labelY    = pos.dy < mapPadding + 20 ? pos.dy + 26 : pos.dy - 30;

    _drawText(canvas, completed ? '✓' : '${star.levelIndex + 1}',
      Offset(pos.dx, labelY), fontSize: 9,
      color: completed
          ? AppTheme.accent.withOpacity(0.9)
          : AppTheme.textSecondary.withOpacity(opacity * 0.45));

    _drawText(canvas, star.greekLetter,
      Offset(pos.dx, labelY + 13), fontSize: 12, italic: true,
      color: completed
          ? AppTheme.accent.withOpacity(0.9)
          : AppTheme.textSecondary.withOpacity(opacity));

    _drawText(canvas, star.nameLatin,
      Offset(pos.dx, labelY + 25), fontSize: 9,
      color: AppTheme.textSecondary.withOpacity(opacity * 0.60),
      letterSpacing: 0.8);
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center, {
    double fontSize = 12,
    bool italic = false,
    double opacity = 1.0,
    double letterSpacing = 0,
    Color? color,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: italic ? 'Georgia' : null,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          fontSize: fontSize,
          color: color ?? AppTheme.textSecondary.withOpacity(opacity),
          letterSpacing: letterSpacing,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _ConstellationPainter old) =>
      old.pulse != pulse || old.tappedIndex != tappedIndex;
}
