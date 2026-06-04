import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/ursa_major_data.dart';
import '../data/ursa_major_levels.dart';
import 'constellation_screen.dart';
import 'sky_map_screen.dart';
import 'mechanics_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {

  bool get _ursaCompleted => UrsaMajorData.chapter.isFullyCompleted;

  Future<void> _openUrsaMajor() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ConstellationScreen(
        chapter: UrsaMajorData.chapter,
        levelLoader: UrsaMajorLevels.getByIndex,
      ),
    ));
    if (mounted) setState(() {});
  }

  void _skipUrsaMajor() {
    UrsaMajorData.chapter.skipAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 36),

            // ── Логотип ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'STARWEAVE',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 18,
                  letterSpacing: 5,
                  color: AppTheme.textSecondary.withValues(alpha: 0.72),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ── Заголовок розділу Ведмедиця ────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'РОЗДІЛ',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 11,
                  letterSpacing: 5,
                  color: AppTheme.textSecondary.withValues(alpha: 0.59),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Тайл Велика Ведмедиця з кнопкою SKIP ──────────────────
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _UrsaMajorTile(
                        completed: _ursaCompleted,
                        onTap: _openUrsaMajor,
                      ),
                    ),
                    if (!_ursaCompleted)
                      _SkipButton(onTap: _skipUrsaMajor),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ── Заголовок Колекції ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'КОЛЕКЦІЇ',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 14,
                  letterSpacing: 5,
                  color: AppTheme.textSecondary.withValues(alpha: 0.59),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Прокручуваний список колекцій ──────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: _ursaCompleted
                          ? _CollectionTile(
                              label: 'ПІВНІЧ ВЗИМКУ',
                              title: 'ПІВНІЧНЕ\nЗИМОВЕ НЕБО',
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const SkyMapScreen(),
                                ),
                              ),
                            )
                          : const _LockedCollectionTile(
                              reason: 'Пройди Велику Ведмедицю'),
                    ),
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: _LockedCollectionTile(),
                    ),
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: _LockedCollectionTile(),
                    ),
                  ],
                ),
              ),
            ),

            // ── Механіки — завжди внизу ────────────────────────────────
            const Divider(
              color: Color(0x1A7EB8D4),
              height: 1,
              indent: 30,
              endIndent: 30,
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 36),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MechanicsScreen()),
                ),
                child: Row(
                  children: [
                    Text(
                      'МЕХАНІКИ',
                      style: AppTheme.labelStyle.copyWith(
                        fontSize: 15,
                        letterSpacing: 4,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '→',
                      style: AppTheme.labelStyle.copyWith(
                        fontSize: 18,
                        color: AppTheme.textSecondary.withValues(alpha: 0.72),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.accent.withValues(alpha: 0.4),
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        '1 / 8',
                        style: AppTheme.labelStyle.copyWith(
                          fontSize: 14,
                          letterSpacing: 2,
                          color: AppTheme.accent.withValues(alpha: 0.91),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Тайл Великої Ведмедиці ────────────────────────────────────────────────────

class _UrsaMajorTile extends StatelessWidget {
  final bool completed;
  final VoidCallback onTap;

  const _UrsaMajorTile({required this.completed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderColor = completed
        ? AppTheme.accent.withValues(alpha: 0.40)
        : AppTheme.constellationLine.withValues(alpha: 0.55);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 159,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top:    BorderSide(color: borderColor, width: 0.9),
            left:   BorderSide(color: borderColor, width: 0.9),
            bottom: BorderSide(color: borderColor, width: 0.9),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(6),
          ),
          color: AppTheme.skyColor.withValues(alpha: 0.55),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(6),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _StarsPainter())),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 30, 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'СУЗІР\'Я',
                                style: AppTheme.labelStyle.copyWith(
                                  fontSize: 11,
                                  letterSpacing: 5,
                                  color: AppTheme.textSecondary
                                      .withValues(alpha: 0.65),
                                ),
                              ),
                              if (completed) ...[
                                const SizedBox(width: 10),
                                Text(
                                  '✓',
                                  style: AppTheme.labelStyle.copyWith(
                                    fontSize: 11,
                                    color: AppTheme.accent.withValues(alpha: 1.0),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'ВЕЛИКА ВЕДМЕДИЦЯ',
                                  style: AppTheme.titleStyle.copyWith(
                                    fontSize: 24,
                                    letterSpacing: 3,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Ursa Major',
                                style: AppTheme.labelStyle.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 3,
                                  color: AppTheme.textSecondary
                                      .withValues(alpha: 0.65),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          completed ? '↻' : '→',
                          style: AppTheme.labelStyle.copyWith(
                            fontSize: 22,
                            color: AppTheme.accent
                                .withValues(alpha: completed ? 0.59 : 0.85),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Skip-кнопка ────────────────────────────────────────────────────────────────

class _SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SkipButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: AppTheme.textSecondary.withValues(alpha: 0.12),
                width: 0.8),
            right: BorderSide(
                color: AppTheme.textSecondary.withValues(alpha: 0.12),
                width: 0.8),
            bottom: BorderSide(
                color: AppTheme.textSecondary.withValues(alpha: 0.12),
                width: 0.8),
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
        child: Center(
          child: RotatedBox(
            quarterTurns: 1,
            child: Text(
              'SKIP',
              style: AppTheme.labelStyle.copyWith(
                fontSize: 11,
                letterSpacing: 2.5,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Активна плитка колекції ───────────────────────────────────────────────────

class _CollectionTile extends StatelessWidget {
  final String label;
  final String title;
  final VoidCallback onTap;

  const _CollectionTile({
    required this.label,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 159,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top:    BorderSide(color: AppTheme.constellationLine.withValues(alpha: 0.50), width: 0.9),
            left:   BorderSide(color: AppTheme.constellationLine.withValues(alpha: 0.50), width: 0.9),
            bottom: BorderSide(color: AppTheme.constellationLine.withValues(alpha: 0.50), width: 0.9),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(6),
          ),
          color: AppTheme.skyColor.withValues(alpha: 0.55),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(6),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _StarsPainter())),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 30, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: AppTheme.labelStyle.copyWith(
                        fontSize: 14,
                        letterSpacing: 5,
                        color: AppTheme.textSecondary.withValues(alpha: 0.65),
                      ),
                    ),
                    Text(
                      title,
                      style: AppTheme.titleStyle.copyWith(
                        fontSize: 30,
                        letterSpacing: 4,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 24,
                bottom: 21,
                child: Text(
                  '→',
                  style: AppTheme.labelStyle.copyWith(
                    fontSize: 24,
                    color: AppTheme.accent.withValues(alpha: 0.78),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Заблокована плитка колекції ───────────────────────────────────────────────

class _LockedCollectionTile extends StatelessWidget {
  final String? reason;
  const _LockedCollectionTile({this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 159,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top:    BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.12), width: 0.8),
          left:   BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.12), width: 0.8),
          bottom: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.12), width: 0.8),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          bottomLeft: Radius.circular(6),
        ),
      ),
      child: Center(
        child: reason != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_outline,
                      color: AppTheme.textSecondary.withValues(alpha: 0.22),
                      size: 26),
                  const SizedBox(height: 8),
                  Text(
                    reason!,
                    style: AppTheme.labelStyle.copyWith(
                      fontSize: 10,
                      letterSpacing: 2,
                      color: AppTheme.textSecondary.withValues(alpha: 0.36),
                    ),
                  ),
                ],
              )
            : Text(
                '?',
                style: AppTheme.titleStyle.copyWith(
                  fontSize: 39,
                  letterSpacing: 0,
                  color: AppTheme.textSecondary.withValues(alpha: 0.21),
                ),
              ),
      ),
    );
  }
}

// ── Зоряне тло ────────────────────────────────────────────────────────────────

class _StarsPainter extends CustomPainter {
  static final _stars = List.generate(30, (i) {
    final r = math.Random(i * 41 + 7);
    return (r.nextDouble(), r.nextDouble(), r.nextDouble() * 1.0 + 0.3,
        r.nextDouble() * 0.38 + 0.07);
  });

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint();
    for (final (x, y, radius, alpha) in _stars) {
      p.color = Colors.white.withValues(alpha: alpha);
      canvas.drawCircle(Offset(x * size.width, y * size.height), radius, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
