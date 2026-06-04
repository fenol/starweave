import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/tutorial_binary_data.dart';
import '../data/tutorial_spectrum_data.dart';
import '../game/game_state.dart';
import '../models/level_model.dart';
import '../models/star_model.dart';
import '../theme/app_theme.dart';
import '../widgets/star_grid_widget.dart';
import 'level_screen.dart';
import 'tutorial_screen.dart';

class TutorialBinaryScreen extends StatefulWidget {
  final LevelData? firstLevel;

  const TutorialBinaryScreen({super.key, this.firstLevel});

  @override
  State<TutorialBinaryScreen> createState() => _TutorialBinaryScreenState();
}

class _TutorialBinaryScreenState extends State<TutorialBinaryScreen>
    with SingleTickerProviderStateMixin {

  late GameState _gameState;
  late AnimationController _bannerController;
  late Animation<double> _bannerAnimation;
  LevelState _prevState    = LevelState.playing;
  int        _prevHintStep = -1;

  @override
  void initState() {
    super.initState();
    _gameState = GameState(level: TutorialBinaryData.level);
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
    if (newState != _prevState || newHintStep != _prevHintStep) {
      _bannerController
        ..reset()
        ..forward();
      _prevState    = newState;
      _prevHintStep = newHintStep;
    }
    setState(() {});
  }

  TutorialHint get _currentHint {
    final step = _gameState.stepCount;
    return TutorialBinaryData.hints.lastWhere(
      (h) => h.afterStep <= step,
      orElse: () => TutorialBinaryData.hints.first,
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(TutorialResult.menu),
            child: const Icon(Icons.chevron_left,
              color: AppTheme.textSecondary, size: 24),
          ),
          const Spacer(),
          Column(
            children: [
              Text('ТУТОРІАЛ', style: AppTheme.labelStyle.copyWith(
                fontSize: 10, color: AppTheme.textSecondary)),
              Text('БІНАРНА ЗІРКА', style: AppTheme.labelStyle.copyWith(
                fontSize: 12, color: AppTheme.textPrimary)),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: _gameState.resetPath,
            child: const Icon(Icons.refresh,
              color: AppTheme.textSecondary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    final (borderColor, labelColor, labelText, bodyText) = switch (_gameState.state) {
      LevelState.success => (
        AppTheme.accent,
        AppTheme.accent,
        'ЧУДОВО!',
        'Ти освоїв(-ла) бінарну зірку.\nПам\'ятай: торкнись ще раз — і вона зміниться!',
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
        'Бінарна зірка в неправильному стані.\nТоркнись її ще раз щоб змінити колір назад!',
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

  Widget _buildBottom() {
    if (_gameState.state == LevelState.success) {
      return _buildSuccessButtons();
    }

    /* Легенда яскравості зірок — закоментована, буде використана пізніше
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
    */
    return const SizedBox.shrink();
  }

  Widget _buildSuccessButtons() {
    if (widget.firstLevel != null) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ТУТОРІАЛ ПРОЙДЕНО · БІНАРНА ЗІРКА',
              style: AppTheme.labelStyle.copyWith(
                  fontSize: 10, color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  final completed = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(
                      builder: (_) => LevelScreen(level: widget.firstLevel!),
                    ),
                  );
                  if (!mounted) return;
                  Navigator.of(context).pop(
                    completed == true
                        ? TutorialResult.goToLevel
                        : TutorialResult.menu,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.accent),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: Text('ПЕРЕЙТИ НА РІВЕНЬ →',
                    style: AppTheme.buttonStyle.copyWith(
                        color: AppTheme.accent, letterSpacing: 2)),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(TutorialResult.menu),
              child: Text('МЕНЮ СУЗіР\'Я',
                  style: AppTheme.buttonStyle.copyWith(
                      color: AppTheme.textSecondary, letterSpacing: 2)),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ТУТОРІАЛ ПРОЙДЕНО · БІНАРНА ЗІРКА',
            style: AppTheme.labelStyle.copyWith(
                fontSize: 10, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () =>
                  Navigator.of(context).pop(TutorialResult.menu),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.accent),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Text('ПОВЕРНУТИСЬ →',
                  style: AppTheme.buttonStyle.copyWith(
                      color: AppTheme.accent, letterSpacing: 2)),
            ),
          ),
        ],
      ),
    );
  }
}
