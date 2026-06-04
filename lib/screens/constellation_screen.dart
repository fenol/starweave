import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/constellation_model.dart';
import '../models/level_model.dart';
import 'level_screen.dart';
import 'spectrum_intro_screen.dart';
import 'tutorial_screen.dart';
import 'tutorial_jump_screen.dart';
import 'tutorial_binary_screen.dart';
import '../widgets/story_popup.dart';
import '../data/mechanics_state.dart';

class ConstellationScreen extends StatefulWidget {
  final ConstellationChapter chapter;

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
    final rotation = widget.chapter.rotationDegrees;

    for (int i = 0; i < widget.chapter.stars.length; i++) {
      final star = widget.chapter.stars[i];
      if (star.isDecoration) continue;
      final pos = _rotatedPos(star, size, pad, rotation);
      if ((details.localPosition - pos).distance < 28) {
        _onStarTapped(i, star);
        return;
      }
    }
    setState(() => _tappedIndex = null);
  }

  // Обчислює екранну позицію з урахуванням повороту
  static Offset _rotatedPos(
    ConstellationStar star,
    Size size,
    double pad,
    double degrees,
  ) {
    if (degrees == 0.0) {
      return Offset(
        pad + star.x * (size.width - 2 * pad),
        pad + star.y * (size.height - 2 * pad),
      );
    }
    final angle = degrees * math.pi / 180.0;
    final dx = star.x - 0.5;
    final dy = star.y - 0.5;
    final rx = dx * math.cos(angle) - dy * math.sin(angle) + 0.5;
    final ry = dx * math.sin(angle) + dy * math.cos(angle) + 0.5;
    return Offset(
      pad + rx * (size.width - 2 * pad),
      pad + ry * (size.height - 2 * pad),
    );
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

    // Попап механіки — для першого рівня коли визначена механіка
    if (star.levelIndex == 0 &&
        widget.chapter.firstLevelMechanic != null) {
      _showMechanicPopup(star);
      return;
    }

    _openLevel(star);
  }

  // ── Механіка-попап ───────────────────────────────────────────────────────

  Future<void> _showMechanicPopup(ConstellationStar star) async {
    final mechanic = widget.chapter.firstLevelMechanic!;

    final (dialogTitle, dialogDesc) = switch (mechanic) {
      'jumps'  => ('СТРИБКИ', 'Якщо між двома зірками порожньо — можна перестрибнути через пустоту, дотримуючись правил спектру.'),
      'binary' => ('БІНАРНА ЗІРКА', 'Особлива зірка з двома станами спектру. Торкнись її ще раз — і вона зміниться на інший клас.'),
      _        => ('СПЕКТРАЛЬНИЙ ШЛЯХ', 'Зірки пов\'язані спектральним рядом. Кожен крок шляху — це перехід між сусідніми спектральними класами.'),
    };

    final startTutorial = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.72),
      builder: (_) => _NewMechanicDialog(
        title: dialogTitle,
        description: dialogDesc,
      ),
    );

    if (!mounted) return;

    final firstLevel = widget.levelLoader(0);

    if (startTutorial == true) {
      final result = await Navigator.of(context).push<TutorialResult>(
        MaterialPageRoute(builder: (_) => switch (mechanic) {
          'jumps'  => TutorialJumpScreen(firstLevel: firstLevel),
          'binary' => TutorialBinaryScreen(firstLevel: firstLevel),
          _        => SpectrumIntroScreen(firstLevel: firstLevel),
        }),
      );
      if (!mounted) return;
      if (result == TutorialResult.goToLevel) {
        _openLevel(star);
        return;
      }
    } else {
      // Закрили попап — відкриваємо рівень напряму
      _openLevel(star);
    }

    setState(() => _tappedIndex = null);
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

      // Розблоковуємо механіку при проходженні першого рівня розділу
      if (star.levelIndex == 0 &&
          widget.chapter.firstLevelMechanic != null) {
        MechanicsState.unlock(widget.chapter.firstLevelMechanic!);
      }

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
      padding: const EdgeInsets.fromLTRB(4, 18, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Кнопка назад
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: AppTheme.textSecondary, size: 20),
            onPressed: () => Navigator.of(context).pop(),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 4),
          // Заголовок — займає весь простір між кнопкою і прогресом
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
                        letterSpacing: 4,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.chapter.name.toUpperCase(),
                      style: AppTheme.titleStyle.copyWith(
                        fontSize: 18,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          // Прогрес — вирівняний по центру
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$done / $total',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 18,
                  color: done == total
                      ? AppTheme.accent
                      : AppTheme.textSecondary,
                ),
              ),
              Text(
                'РІВНІВ',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 9,
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
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: AppTheme.constellationLine.withOpacity(0.15),
            height: 1,
          ),
          const SizedBox(height: 10),

          // Цитата — шрифт підібрано щоб повністю поміститись без обрізання
          Text(
            widget.chapter.mythQuote,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: AppTheme.textSecondary.withOpacity(0.85),
              height: 1.45,
            ),
            textAlign: TextAlign.center,
          ),

          if (hasStory &&
              (!widget.chapter.storyOnCompletion ||
               widget.chapter.isFullyCompleted)) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => StoryPopup.show(context, widget.chapter),
              child: Text(
                'ЛЕГЕНДА  →',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 12,
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
// Попап «Нова механіка»
// ─────────────────────────────────────────────────────────────────────────────

class _NewMechanicDialog extends StatelessWidget {
  final String title;
  final String description;

  const _NewMechanicDialog({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
      child: Container(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
        decoration: BoxDecoration(
          color: AppTheme.skyColor,
          border: Border.all(
            color: AppTheme.accent.withOpacity(0.35),
            width: 0.9,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'НОВА МЕХАНІКА',
                        style: AppTheme.labelStyle.copyWith(
                          fontSize: 10,
                          letterSpacing: 5,
                          color: AppTheme.accent.withOpacity(0.80),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        title,
                        style: AppTheme.titleStyle.copyWith(
                          fontSize: 20,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.close,
                      color: AppTheme.textSecondary.withOpacity(0.55),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: AppTheme.bodyStyle.copyWith(
                fontSize: 13,
                height: 1.6,
                color: AppTheme.textSecondary.withOpacity(0.85),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.accent),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: Text(
                  'ПРОЙТИ ТУТОРІАЛ →',
                  style: AppTheme.buttonStyle.copyWith(
                      color: AppTheme.accent, letterSpacing: 2, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
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

  /// Позиція зірки на екрані з урахуванням повороту розділу
  Offset _pos(ConstellationStar star, Size size) {
    const pad = mapPadding;
    final degrees = chapter.rotationDegrees;
    if (degrees == 0.0) {
      return Offset(
        pad + star.x * (size.width - 2 * pad),
        pad + star.y * (size.height - 2 * pad),
      );
    }
    final angle = degrees * math.pi / 180.0;
    final dx = star.x - 0.5;
    final dy = star.y - 0.5;
    // Поворот за годинниковою стрілкою в системі координат екрану (y вниз)
    final rx = dx * math.cos(angle) - dy * math.sin(angle) + 0.5;
    final ry = dx * math.sin(angle) + dy * math.cos(angle) + 0.5;
    return Offset(
      pad + rx * (size.width - 2 * pad),
      pad + ry * (size.height - 2 * pad),
    );
  }

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
        _paintDecorationStar(canvas, pos, star, size);
      } else if (star.isCompleted) {
        _paintCompleted(canvas, pos, tapped);
        _paintLabel(canvas, size, star, pos, active: true);
      } else if (star.isUnlocked) {
        _paintUnlocked(canvas, pos, tapped, pulse);
        _paintLabel(canvas, size, star, pos, active: true);
      } else {
        _paintLocked(canvas, pos);
        _paintLabel(canvas, size, star, pos, active: false);
      }
    }
  }

  void _paintDecorationStar(Canvas canvas, Offset pos, ConstellationStar star, Size size) {
    canvas.drawCircle(pos, 2.2,
        Paint()..color = AppTheme.starInactive.withOpacity(0.28));
    final toRight = pos.dx <= size.width * 0.5;
    _drawText(canvas, star.greekLetter,
      Offset(pos.dx, pos.dy),
      fontSize: 9,
      italic: true,
      color: AppTheme.textSecondary.withOpacity(0.22),
      hOffset: toRight ? 10.0 : -10.0,
      rightAlign: !toRight,
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

  /// Мітки збоку від зірки:
  /// зірки в лівій половині екрана → текст праворуч, у правій → ліворуч.
  void _paintLabel(
    Canvas canvas,
    Size size,
    ConstellationStar star,
    Offset pos, {
    required bool active,
  }) {
    final opacity   = active ? 0.85 : 0.28;
    final completed = star.isCompleted;

    // Зірка в правій половині → текст ліворуч від неї, і навпаки
    final toRight  = pos.dx <= size.width * 0.5;
    const gap      = 12.0; // px від центру зірки до ближнього краю тексту
    final anchorX  = toRight ? pos.dx + gap : pos.dx - gap;
    final rightAln = !toRight; // right-align коли текст ліворуч від зірки

    // Три рядки вертикально відцентровані відносно зірки
    _drawText(canvas, completed ? '✓' : '${star.levelIndex + 1}',
      Offset(anchorX, pos.dy - 13), fontSize: 9,
      hOffset: 0,
      rightAlign: rightAln,
      color: completed
          ? AppTheme.accent.withOpacity(0.9)
          : AppTheme.textSecondary.withOpacity(opacity * 0.45));

    _drawText(canvas, star.greekLetter,
      Offset(anchorX, pos.dy), fontSize: 12, italic: true,
      hOffset: 0,
      rightAlign: rightAln,
      color: completed
          ? AppTheme.accent.withOpacity(0.9)
          : AppTheme.textSecondary.withOpacity(opacity));

    _drawText(canvas, star.nameLatin,
      Offset(anchorX, pos.dy + 13), fontSize: 9,
      hOffset: 0,
      rightAlign: rightAln,
      letterSpacing: 0.8,
      color: AppTheme.textSecondary.withOpacity(opacity * 0.60));
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset anchor, {
    double fontSize = 12,
    bool italic = false,
    double opacity = 1.0,
    double letterSpacing = 0,
    Color? color,
    // hOffset: горизонтальний зсув від anchor.dx (після виміру ширини тексту)
    double hOffset = 0,
    // rightAlign: текст «причеплений» правим краєм до anchor.dx
    bool rightAlign = false,
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

    final dx = rightAlign
        ? anchor.dx - tp.width + hOffset   // правий край = anchor.dx
        : anchor.dx + hOffset;             // лівий край = anchor.dx
    tp.paint(canvas, Offset(dx, anchor.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _ConstellationPainter old) =>
      old.pulse != pulse || old.tappedIndex != tappedIndex;
}
