import 'package:flutter/material.dart';
import '../models/level_model.dart';
import '../models/star_model.dart';
import '../theme/app_theme.dart';
import '../widgets/star_grid_widget.dart';
import 'tutorial_screen.dart';

/// Вступний екран перед туторіалом спектрального шляху.
/// Пояснює правило переходів і пропонує «Почати навчання».
class SpectrumIntroScreen extends StatelessWidget {
  /// Рівень, на який перейдемо після успішного туторіалу.
  final LevelData? firstLevel;

  const SpectrumIntroScreen({super.key, this.firstLevel});

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Мітка «НОВА МЕХАНІКА» ────────────────────────
                    Text(
                      'НОВА МЕХАНІКА',
                      style: AppTheme.labelStyle.copyWith(
                        fontSize: 10,
                        letterSpacing: 5,
                        color: AppTheme.accent.withOpacity(0.80),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // ── Заголовок ─────────────────────────────────────
                    Text(
                      'СПЕКТРАЛЬНИЙ\nШЛЯХ',
                      style: AppTheme.titleStyle.copyWith(
                        fontSize: 28,
                        letterSpacing: 4,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Правило переходів ─────────────────────────────
                    Text(
                      'Щоб побудувати спектральний шлях, ви мусите виконувати переходи між зірками в певній послідовності:',
                      style: AppTheme.bodyStyle.copyWith(
                        fontSize: 14,
                        height: 1.6,
                        color: AppTheme.textPrimary.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Візуалізація переходів ─────────────────────────
                    _buildSpectrumChain(),

                    const SizedBox(height: 28),

                    Text(
                      'Якщо ви перейдете на неправильну зірку — спектральний шлях буде зламано.',
                      style: AppTheme.bodyStyle.copyWith(
                        fontSize: 14,
                        height: 1.6,
                        color: AppTheme.textPrimary.withOpacity(0.85),
                      ),
                    ),

                    const SizedBox(height: 48),

                    // ── Кнопка «Почати навчання» ──────────────────────
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _startTutorial(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.accent),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          'ПОЧАТИ НАВЧАННЯ →',
                          style: AppTheme.buttonStyle.copyWith(
                            color: AppTheme.accent, letterSpacing: 2),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 20, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left,
                color: AppTheme.textSecondary, size: 28),
            onPressed: () => Navigator.of(context).pop(TutorialResult.menu),
          ),
          const Spacer(),
          Text(
            'ТУТОРІАЛ',
            style: AppTheme.labelStyle.copyWith(
              fontSize: 10,
              letterSpacing: 5,
              color: AppTheme.textSecondary,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 44), // баланс під кнопку «назад»
        ],
      ),
    );
  }

  /// Горизонтальний ланцюжок кольорів зі стрілками ↔
  Widget _buildSpectrumChain() {
    final spectra = StarSpectrum.values;
    final labels = ['синій', 'білий', 'жовтий', 'червоний'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.constellationLine.withOpacity(0.20),
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(6),
        color: AppTheme.skyColor.withOpacity(0.40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < spectra.length; i++) ...[
            _SpectrumNode(
              color: SpectrumColors.of(spectra[i]),
              label: labels[i],
            ),
            if (i < spectra.length - 1)
              Text(
                '↔',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 16,
                  color: AppTheme.textSecondary.withOpacity(0.50),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Future<void> _startTutorial(BuildContext context) async {
    final result = await Navigator.of(context).push<TutorialResult>(
      MaterialPageRoute(
        builder: (_) => TutorialScreen(firstLevel: firstLevel),
      ),
    );
    if (!context.mounted) return;
    // Propagate result back to ConstellationScreen
    Navigator.of(context).pop(result ?? TutorialResult.menu);
  }
}

// ── Вузол спектру (кружечок + підпис) ────────────────────────────────────────

class _SpectrumNode extends StatelessWidget {
  final Color color;
  final String label;

  const _SpectrumNode({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.45),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTheme.labelStyle.copyWith(
            fontSize: 9,
            letterSpacing: 1,
            color: AppTheme.textSecondary.withOpacity(0.70),
          ),
        ),
      ],
    );
  }
}
