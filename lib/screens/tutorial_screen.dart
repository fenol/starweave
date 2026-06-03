import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/tutorial_spectrum_data.dart';
import '../game/game_state.dart';
import '../models/star_model.dart';
import '../theme/app_theme.dart';
import '../widgets/star_grid_widget.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen>
    with SingleTickerProviderStateMixin {

  late GameState _gameState;
  late AnimationController _bannerController;
  late Animation<double> _bannerAnimation;
  LevelState _prevState    = LevelState.playing;
  int        _prevHintStep = -1;

  @override
  void initState() {
    super.initState();
    _gameState = GameState(level: TutorialSpectrumData.level);
    _gameState.addListener(_onGameStateChanged);

    _bannerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();

    _bannerAnimation = CurvedAnimation(
      parent: _bannerController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _gameState.removeListener(_onGameStateChanged);
    _gameState.dispose();
    _bannerController.dispose();
    super.dispose();
  }

  void _onGameStateChanged() {
    final newState    = _gameState.state;
    final newHintStep = _currentHint.afterStep;
    // Анімуємо лише коли змінився стан або з'явилась нова підказка
    if (newState != _prevState || newHintStep != _prevHintStep) {
      _bannerController
        ..reset()
        ..forward();
      _prevState    = newState;
      _prevHintStep = newHintStep;
    }
    setState(() {});
  }

  // Поточна підказка туторіалу
  TutorialHint get _currentHint {
    final step = _gameState.stepCount;
    // Знаходимо останню підказку що підходить до поточного кроку
    return TutorialSpectrumData.hints.lastWhere(
      (h) => h.afterStep <= step,
      orElse: () => TutorialSpectrumData.hints.first,
    );
  }

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
              const SizedBox(height: 16),
              Expanded(child: _buildGrid()),
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  // Шапка
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.chevron_left,
              color: AppTheme.textSecondary, size: 24),
          ),
          const Spacer(),
          Column(
            children: [
              Text('ТУТОРІАЛ', style: AppTheme.labelStyle.copyWith(
                fontSize: 10, color: AppTheme.textSecondary)),
              Text('СПЕКТРАЛЬНИЙ РЯД', style: AppTheme.labelStyle.copyWith(
                fontSize: 12, color: AppTheme.textPrimary)),
            ],
          ),
          const Spacer(),
          // Кнопка скидання
          GestureDetector(
            onTap: _gameState.resetPath,
            child: const Icon(Icons.refresh,
              color: AppTheme.textSecondary, size: 20),
          ),
        ],
      ),
    );
  }

  // Банер з підказкою або статусом
  Widget _buildBanner() {
    final isSuccess = _gameState.state == LevelState.success;
    final isError = _gameState.state == LevelState.spectrumError ||
                    _gameState.state == LevelState.wrongStart   ||
                    _gameState.state == LevelState.pathTooLong;

    final (borderColor, labelColor, labelText, bodyText) = switch (_gameState.state) {
      LevelState.success => (
        AppTheme.accent,
        AppTheme.accent,
        'ЧУДОВО!',
        'Ти зрозумів(-ла) правило спектру.\nШлях знайдено від А до В.',
      ),
      LevelState.wrongStart => (
        const Color(0xFF8B3030),
        const Color(0xFFCC5555),
        'НЕ ТА ЗІРКА',
        'Шлях починається із зірки А.\nЗнайди її і торкнись звідти.',
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
        _currentHint.text,
      ),
    };

    return AnimatedBuilder(
      animation: _bannerAnimation,
      builder: (context, child) => Opacity(
        opacity: _bannerAnimation.value,
        child: child,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
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
                    style: AppTheme.labelStyle.copyWith(
                      fontSize: 11, color: labelColor)),
                  const SizedBox(height: 6),
                  Text(bodyText,
                    style: AppTheme.bodyStyle.copyWith(
                      fontSize: 13, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Сітка
  Widget _buildGrid() {
    final highlight = _gameState.state == LevelState.playing
        ? _currentHint.highlightCells
        : <(int, int)>[];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: AspectRatio(
          aspectRatio: _gameState.level.cols / _gameState.level.rows,
          child: StarGridWidget(
            level: _gameState.level,
            gameState: _gameState,
            highlightCells: highlight,
            showHints: true,
          ),
        ),
      ),
    );
  }

  // Нижня панель
  Widget _buildBottom() {
    if (_gameState.state == LevelState.success) {
      return _buildSuccessButtons();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Легенда спектрів
          ...StarSpectrum.values.map((s) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
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
                  style: AppTheme.labelStyle.copyWith(
                    fontSize: 10, color: AppTheme.textSecondary),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // Кнопки після успіху
  Widget _buildSuccessButtons() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Прогрес туторіалу
          Text(
            'ТУТОРІАЛ ПРОЙДЕНО · СПЕКТРАЛЬНИЙ РЯД',
            style: AppTheme.labelStyle.copyWith(
              fontSize: 10, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 16),
          // Кнопка - Почати рівень
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // TODO: перейти на реальний рівень L1
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.accent),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('ПОЧАТИ РІВЕНЬ →',
                style: AppTheme.buttonStyle.copyWith(
                  color: AppTheme.accent, letterSpacing: 2)),
            ),
          ),
          const SizedBox(height: 10),
          // Кнопка - Меню
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('МЕНЮ',
              style: AppTheme.buttonStyle.copyWith(
                color: AppTheme.textSecondary, letterSpacing: 2)),
          ),
        ],
      ),
    );
  }
}