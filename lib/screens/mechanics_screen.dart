import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'tutorial_screen.dart';
import 'tutorial_binary_screen.dart';

class MechanicsScreen extends StatelessWidget {
  const MechanicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.35,
                  children: [
                    _MechanicTile(
                      name: 'СПЕКТР',
                      description: 'Ланцюжок\nспектральних класів',
                      unlocked: true,
                      onTutorial: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const TutorialScreen()),
                      ),
                    ),
                    _MechanicTile(
                      name: 'БІНАРНА ЗІРКА',
                      description: 'Зірка з двома\nстанами спектру',
                      unlocked: true,
                      onTutorial: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const TutorialBinaryScreen()),
                      ),
                    ),
                    for (int i = 0; i < 6; i++) const _LockedMechanicTile(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 12, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: AppTheme.textSecondary, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Center(
              child: Text(
                'МЕХАНІКИ',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 11,
                  letterSpacing: 6,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

// ── Unlocked tile ─────────────────────────────────────────────────────────────

class _MechanicTile extends StatelessWidget {
  final String name;
  final String description;
  final bool unlocked;
  final VoidCallback? onTutorial;

  const _MechanicTile({
    required this.name,
    required this.description,
    required this.unlocked,
    this.onTutorial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.constellationLine.withValues(alpha: 0.45),
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(4),
        color: AppTheme.skyColor.withValues(alpha: 0.35),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTheme.labelStyle.copyWith(
              fontSize: 11,
              letterSpacing: 3,
              color: AppTheme.accent,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              description,
              style: AppTheme.bodyStyle.copyWith(
                fontSize: 11,
                height: 1.5,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTutorial,
            child: Text(
              'ТУТОРІАЛ  →',
              style: AppTheme.labelStyle.copyWith(
                fontSize: 9,
                letterSpacing: 3,
                color: AppTheme.accent.withValues(alpha: 0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Locked tile ───────────────────────────────────────────────────────────────

class _LockedMechanicTile extends StatelessWidget {
  const _LockedMechanicTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.textSecondary.withValues(alpha: 0.15),
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          '?',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 28,
            color: AppTheme.textSecondary.withValues(alpha: 0.20),
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
