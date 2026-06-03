import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../game/game_state.dart';
import '../models/level_model.dart';
import '../models/star_model.dart';
import '../theme/app_theme.dart';
import '../widgets/star_grid_widget.dart';

/// Універсальний екран рівня — працює для всіх 7 рівнів Ursa Major
/// (і будь-яких майбутніх розділів).
///
/// Повертає [true] через Navigator.pop, якщо рівень пройдено.
class LevelScreen extends StatefulWidget {
  final LevelData level;

  const LevelScreen({super.key, required this.level});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen>
    with SingleTickerProviderStateMixin {

  late GameState _gameState;
  late AnimationController _bannerCtrl;
  late Animation<double> _bannerAnim;
  LevelState _prevState = LevelState.playing;

  @override
  void initState() {
    super.initState();
    _gameState = GameState(level: widget.level);
    _gameState.addListener(_onStateChange);

    _bannerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();

    _bannerAnim = CurvedAnimation(
      parent: _bannerCtrl,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _gameState.removeListener(_onStateChange);
    _gameState.dispose();
    _bannerCtrl.dispose();
    super.dispose();
  }

  void _onStateChange() {
    final newState = _gameState.state;
    // Анімуємо банер лише коли стан змінився — не при кожному кроці
    if (newState != _prevState) {
      _bannerCtrl
        ..reset()
        ..forward();
      _prevState = newState;
    }
    setState(() {});
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _gameState,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildBanner(),
              const SizedBox(height: 12),
              Expanded(child: _buildGrid()),
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Шапка ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    final lvl = widget.level;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Кнопка назад
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: const Icon(Icons.chevron_left,
                color: AppTheme.textSecondary, size: 24),
          ),

          const Spacer(),

          // Інформація про рівень
          Column(
            children: [
              // "РІВЕНЬ 1 · ЛЕГКО"
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'РІВЕНЬ ${lvl.levelNumber}',
                    style: AppTheme.labelStyle.copyWith(
                        fontSize: 10, color: AppTheme.textSecondary),
                  ),
                  Text(
                    '  ·  ',
                    style: AppTheme.labelStyle.copyWith(
                        fontSize: 10,
                        color: AppTheme.textSecondary.withOpacity(0.4)),
                  ),
                  Text(
                    lvl.difficulty,
                    style: AppTheme.labelStyle.copyWith(
                        fontSize: 10, color: _difficultyColor(lvl.difficulty)),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              // "δ · MEGREZ"
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    lvl.greekLetter,
                    style: AppTheme.titleStyle.copyWith(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.accent),
                  ),
                  Text(
                    '  ·  ',
                    style: AppTheme.titleStyle.copyWith(
                        fontSize: 14,
                        color: AppTheme.textSecondary.withOpacity(0.4)),
                  ),
                  Text(
                    lvl.starNameLatin.toUpperCase(),
                    style: AppTheme.titleStyle.copyWith(
                        fontSize: 18, letterSpacing: 3),
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),

          // Кнопка скидання + DEV skip
          Column(
            children: [
              GestureDetector(
                onTap: _gameState.resetPath,
                child: const Icon(Icons.refresh,
                    color: AppTheme.textSecondary, size: 20),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  'skip',
                  style: AppTheme.labelStyle.copyWith(
                    fontSize: 9,
                    color: AppTheme.textSecondary.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Банер стану ───────────────────────────────────────────────────────────

  Widget _buildBanner() {
    final (borderColor, labelColor, labelText, bodyText) =
        switch (_gameState.state) {
      LevelState.success => (
          AppTheme.accent,
          AppTheme.accent,
          'ШЛЯХ ЗАВЕРШЕНО',
          '${widget.level.greekLetter} ${widget.level.starNameLatin} — знайдено.',
        ),
      LevelState.wrongStart => (
          const Color(0xFF8B3030),
          const Color(0xFFCC5555),
          'НЕ ТА ЗІРКА',
          'Шлях починається з точки А.\nЗнайди її і торкнись звідти.',
        ),
      LevelState.spectrumError => (
          const Color(0xFF8B3030),
          const Color(0xFFCC5555),
          'СПЕКТР ЗЛАМАНО',
          'Лише сусідні класи ±1.\nСпробуйте ще раз.',
        ),
      LevelState.pathTooLong => (
          const Color(0xFF8B3030),
          const Color(0xFFCC5555),
          'ШЛЯХ ЗАВЕЛИКИЙ',
          'Вичерпано всі кроки, але В не досягнуто.\nСпробуй коротший маршрут від А до В.',
        ),
      _ => (
          AppTheme.skyColor,
          AppTheme.accent,
          'ПІДКАЗКА',
          widget.level.hint,
        ),
    };

    return AnimatedBuilder(
      animation: _bannerAnim,
      builder: (_, child) => Opacity(opacity: _bannerAnim.value, child: child),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.background,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(labelText,
                      style: AppTheme.labelStyle
                          .copyWith(fontSize: 10, color: labelColor)),
                  const SizedBox(height: 4),
                  Text(bodyText,
                      style: AppTheme.bodyStyle
                          .copyWith(fontSize: 13, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Сітка ─────────────────────────────────────────────────────────────────

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: AspectRatio(
          aspectRatio: _gameState.level.cols / _gameState.level.rows,
          child: StarGridWidget(
            level: _gameState.level,
            gameState: _gameState,
            highlightCells: const [], // без туторіальних підказок
            showHints: false,
          ),
        ),
      ),
    );
  }

  // ── Нижня панель ──────────────────────────────────────────────────────────

  Widget _buildBottom() {
    if (_gameState.state == LevelState.success) {
      return _buildSuccessPanel();
    }
    return _buildPlayingPanel();
  }

  Widget _buildPlayingPanel() {
    final steps    = _gameState.stepCount;
    final total    = _gameState.level.pathLength;
    const tSec     = AppTheme.textSecondary;
    final emptyDot = AppTheme.textSecondary.withOpacity(0.30);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Лічильник кроків: ● ● ● ○ ○ ○ ○
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(total, (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i < steps ? AppTheme.accent : emptyDot,
                  shape: BoxShape.circle,
                ),
              ),
            )),
          ),
          const SizedBox(height: 4),
          Text(
            '$steps / $total',
            style: AppTheme.labelStyle.copyWith(fontSize: 10, color: tSec),
          ),
          const SizedBox(height: 10),
          // Легенда спектрів
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: StarSpectrum.values.map((s) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                children: [
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      color: SpectrumColors.of(s),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${s.index + 1}m',
                    style: AppTheme.labelStyle
                        .copyWith(fontSize: 10, color: tSec),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessPanel() {
    final lvl    = widget.level;
    final isLast = lvl.levelNumber == lvl.totalLevels;
    const tPrim  = AppTheme.textPrimary;
    const tSec   = AppTheme.textSecondary;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Назва зірки
          Text(
            '${lvl.greekLetter} ${lvl.starNameLatin.toUpperCase()} · ПРОЙДЕНО',
            style: AppTheme.labelStyle.copyWith(fontSize: 10, color: tSec),
          ),
          const SizedBox(height: 14),

          // Кнопка "Наступний рівень" або "Розділ пройдено"
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
                isLast ? 'СУЗІР\'Я ВІДКРИТО →' : 'НАСТУПНИЙ РІВЕНЬ →',
                style: AppTheme.buttonStyle
                    .copyWith(color: AppTheme.accent, letterSpacing: 2),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Кнопка "Сузір'я" (назад)
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'СУЗІР\'Я',
              style: AppTheme.buttonStyle.copyWith(
                  color: tPrim.withOpacity(0.65), letterSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  Color _difficultyColor(String difficulty) {
    return switch (difficulty) {
      'СКЛАДНО' => const Color(0xFFCC5555),
      'СЕРЕДНЬО+' || 'СЕРЕДНЬО' => AppTheme.accent,
      _ => AppTheme.textSecondary,
    };
  }
}
