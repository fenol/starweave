import 'package:flutter/material.dart';
import '../models/star_model.dart';
import '../models/level_model.dart';
import 'game_logic.dart';

// Стан ігрового екрану
enum LevelState {
  playing,       // грає нормально
  wrongStart,    // натиснув не на A
  spectrumError, // помилка спектру в середині
  pathTooLong,   // шлях вийшов за межі pathLength без досягнення B
  binaryChoice,  // бінарна вимагає вибору
  success,       // рівень пройдено!
}

class GameState extends ChangeNotifier {
  final LevelData level;

  // Поточний шлях
  List<PathNode> path = [];

  // Стан рівня
  LevelState state = LevelState.playing;

  // Скільки зірок від кінця шляху є помилковими (legacy, завжди 0)
  int errorTailLength = 0;

  // Зірка що порушила правило спектру (малюємо червону лінію до неї)
  GridStar? errorStar;

  // Зірка що очікує вибору спектру (для бінарної)
  GridStar? pendingBinaryStar;

  GameState({required this.level});

  // Кількість кроків
  int get stepCount => path.length;

  // Поточна сума яскравості
  int get brightnessSum => GameLogic.currentBrightnessSum(path);

  // Скільки кроків залишилось
  int get stepsLeft =>
      level.targetBrightness != null ? level.pathLength - stepCount : 0;

  // Обробка тапу по зірці
  void onStarTapped(GridStar star) {
    if (state == LevelState.success) return;
    if (state == LevelState.pathTooLong) return;

    // Тап на останню бінарну зірку в шляху → переключення спектру
    if (path.isNotEmpty &&
        path.last.star.row == star.row &&
        path.last.star.col == star.col &&
        star.isBinary) {
      _toggleLastBinary();
      return;
    }

    // Якщо остання зірка сама є джерелом помилки (бінарна в неправильному стані),
    // нові кроки заблоковані — треба спочатку виправити або скинути шлях.
    if (state == LevelState.spectrumError &&
        path.isNotEmpty &&
        errorStar != null &&
        errorStar!.row == path.last.star.row &&
        errorStar!.col == path.last.star.col) {
      return;
    }

    // Перший крок
    if (path.isEmpty) {
      final result = GameLogic.validateFirstStep(star, level);
      if (result.isValid) {
        path = [PathNode(star: star, usedSpectrum: result.chosenSpectrum!)];
        state = LevelState.playing;
        errorStar = null;
      } else {
        state = LevelState.wrongStart;
        errorStar = null;
      }
      notifyListeners();
      return;
    }

    // Наступні кроки
    final result = GameLogic.validateNextStep(path.last, star, path, level);

    if (result.isValid) {
      path.add(PathNode(star: star, usedSpectrum: result.chosenSpectrum!));
      errorStar = null;
      state = LevelState.playing;

      if (GameLogic.isPathComplete(path, level)) {
        state = LevelState.success;
      } else if (path.length >= level.pathLength) {
        state = LevelState.pathTooLong;
      }
    } else {
      errorStar = result.error == PathError.wrongStartStar ? null : star;
      state = result.error == PathError.wrongStartStar
          ? LevelState.wrongStart
          : LevelState.spectrumError;
    }

    notifyListeners();
  }

  // Переключення спектру останньої бінарної зірки в шляху
  void _toggleLastBinary() {
    final lastNode = path.last;
    final star = lastNode.star;

    final newSpectrum = lastNode.usedSpectrum == star.spectrum
        ? star.secondSpectrum!
        : star.spectrum;

    path[path.length - 1] = PathNode(star: star, usedSpectrum: newSpectrum);

    // Перевіряємо перехід від попереднього вузла
    if (path.length >= 2) {
      final prevSpectrum = path[path.length - 2].usedSpectrum;
      if (!GameLogic.isValidTransition(prevSpectrum, newSpectrum)) {
        errorStar = star;
        state = LevelState.spectrumError;
        notifyListeners();
        return;
      }
    }

    state = LevelState.playing;
    errorStar = null;
    notifyListeners();
  }

  // Вибір спектру в бінарній зірці
  void onBinarySpectrumChosen(StarSpectrum spectrum) {
    if (pendingBinaryStar == null) return;
    path.add(PathNode(star: pendingBinaryStar!, usedSpectrum: spectrum));
    pendingBinaryStar = null;
    state = LevelState.playing;
    errorTailLength = 0;

    if (GameLogic.isPathComplete(path, level)) {
      state = LevelState.success;
    }
    notifyListeners();
  }

  // Скинути шлях (почати з початку)
  void resetPath() {
    path = [];
    state = LevelState.playing;
    errorStar = null;
    pendingBinaryStar = null;
    notifyListeners();
  }

  // Видалити останній крок (backtrack)
  void removeLastStep() {
    if (path.isEmpty) return;
    path.removeLast();
    state = LevelState.playing;
    errorStar = null;
    notifyListeners();
  }
}