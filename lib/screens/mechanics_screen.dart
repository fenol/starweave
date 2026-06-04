import 'package:flutter/material.dart';
import '../data/mechanics_state.dart';
import '../theme/app_theme.dart';
import 'tutorial_screen.dart';
import 'tutorial_jump_screen.dart';
import 'tutorial_binary_screen.dart';

class MechanicsScreen extends StatefulWidget {
  const MechanicsScreen({super.key});

  @override
  State<MechanicsScreen> createState() => _MechanicsScreenState();
}

class _MechanicsScreenState extends State<MechanicsScreen> {

  Future<void> _openTutorial(Widget screen) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
    // Перебудовуємо після повернення — стан міг змінитись
    if (mounted) setState(() {});
  }

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
                    // ── Спектральний шлях ──────────────────────────────
                    MechanicsState.spectrumUnlocked
                        ? _MechanicTile(
                            name: 'СПЕКТР',
                            description: 'Ланцюжок\nспектральних класів',
                            onTutorial: () => _openTutorial(const TutorialScreen()),
                          )
                        : const _LockedMechanicTile(),

                    // ── Стрибки ────────────────────────────────────────
                    MechanicsState.jumpsUnlocked
                        ? _MechanicTile(
                            name: 'СТРИБКИ',
                            description: 'Перехід через\nпорожні клітинки',
                            onTutorial: () => _openTutorial(const TutorialJumpScreen()),
                          )
                        : const _LockedMechanicTile(),

                    // ── Бінарна зірка ──────────────────────────────────
                    MechanicsState.binaryUnlocked
                        ? _MechanicTile(
                            name: 'БІНАРНА ЗІРКА',
                            description: 'Зірка з двома\nстанами спектру',
                            onTutorial: () => _openTutorial(const TutorialBinaryScreen()),
                          )
                        : const _LockedMechanicTile(),

                    for (int i = 0; i < 5; i++) const _LockedMechanicTile(),
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
  final VoidCallback? onTutorial;

  const _MechanicTile({
    required this.name,
    required this.description,
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
