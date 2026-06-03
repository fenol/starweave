import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'sky_map_screen.dart';
import 'mechanics_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // ── Маленький логотип ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'STARWEAVE',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 12,
                  letterSpacing: 5,
                  color: AppTheme.textSecondary.withValues(alpha: 0.55),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ── Заголовок секції ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'КОЛЕКЦІЇ',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 9,
                  letterSpacing: 5,
                  color: AppTheme.textSecondary.withValues(alpha: 0.45),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ── Плитка «Північне зимове небо» — ліво відступ, до краю ──
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _CollectionTile(
                label: 'ПІВНІЧ ВЗИМКУ',
                title: 'ПІВНІЧНЕ\nЗИМОВЕ НЕБО',
                unlocked: true,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SkyMapScreen()),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ── Заблоковані плитки (такого ж розміру) ─────────────────
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: const _LockedCollectionTile(),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: const _LockedCollectionTile(),
            ),

            const Spacer(),

            // ── Механіки ──────────────────────────────────────────────
            const Divider(
              color: Color(0x1A7EB8D4),
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MechanicsScreen()),
                ),
                child: Row(
                  children: [
                    Text(
                      'МЕХАНІКИ',
                      style: AppTheme.labelStyle.copyWith(
                        fontSize: 10,
                        letterSpacing: 4,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '→',
                      style: AppTheme.labelStyle.copyWith(
                        fontSize: 12,
                        color: AppTheme.textSecondary.withValues(alpha: 0.55),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
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
                          fontSize: 9,
                          letterSpacing: 2,
                          color: AppTheme.accent.withValues(alpha: 0.7),
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

// ── Плитка колекції (активна) ─────────────────────────────────────────────────

class _CollectionTile extends StatelessWidget {
  final String label;
  final String title;
  final bool unlocked;
  final VoidCallback? onTap;

  const _CollectionTile({
    required this.label,
    required this.title,
    required this.unlocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 106,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top:    BorderSide(color: AppTheme.constellationLine.withValues(alpha: 0.50), width: 0.9),
            left:   BorderSide(color: AppTheme.constellationLine.withValues(alpha: 0.50), width: 0.9),
            bottom: BorderSide(color: AppTheme.constellationLine.withValues(alpha: 0.50), width: 0.9),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
          color: AppTheme.skyColor.withValues(alpha: 0.55),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _StarsPainter())),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: AppTheme.labelStyle.copyWith(
                        fontSize: 9,
                        letterSpacing: 5,
                        color: AppTheme.textSecondary.withValues(alpha: 0.50),
                      ),
                    ),
                    Text(
                      title,
                      style: AppTheme.titleStyle.copyWith(
                        fontSize: 20,
                        letterSpacing: 4,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16,
                bottom: 14,
                child: Text(
                  '→',
                  style: AppTheme.labelStyle.copyWith(
                    fontSize: 16,
                    color: AppTheme.accent.withValues(alpha: 0.60),
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

// ── Заблокована плитка (той самий розмір) ─────────────────────────────────────

class _LockedCollectionTile extends StatelessWidget {
  const _LockedCollectionTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      decoration: BoxDecoration(
        border: Border(
          top:    BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.12), width: 0.8),
          left:   BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.12), width: 0.8),
          bottom: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.12), width: 0.8),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          bottomLeft: Radius.circular(4),
        ),
      ),
      child: Center(
        child: Text(
          '?',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 26,
            letterSpacing: 0,
            color: AppTheme.textSecondary.withValues(alpha: 0.16),
          ),
        ),
      ),
    );
  }
}

// ── Мінімальне зоряне тло плитки ─────────────────────────────────────────────

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
