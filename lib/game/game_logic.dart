import '../models/star_model.dart';
import '../models/level_model.dart';

// Типи помилок при побудові шляху
enum PathError {
  wrongStartStar,  // натиснув не на зірку A
  notAdjacent,     // зірки не сусідні
  spectrumBroken,  // порушено правило спектру
  alreadyInPath,   // зірка вже є в шляху
}

// Результат перевірки одного кроку
class StepResult {
  final bool isValid;
  final PathError? error;
  final StarSpectrum? chosenSpectrum; // для бінарних
  final bool needsChoice;            // бінарна — обидва спектри підходять

  const StepResult.valid(StarSpectrum spectrum)
      : isValid = true, error = null,
        chosenSpectrum = spectrum, needsChoice = false;

  const StepResult.ambiguous()
      : isValid = true, error = null,
        chosenSpectrum = null, needsChoice = true;

  const StepResult.invalid(PathError e)
      : isValid = false, error = e,
        chosenSpectrum = null, needsChoice = false;
}

class GameLogic {

  // Чи дві зірки є сусідніми (8 напрямків, 1 клітинка)
  static bool isAdjacent(GridStar a, GridStar b) {
    final dr = (a.row - b.row).abs();
    final dc = (a.col - b.col).abs();
    return dr <= 1 && dc <= 1 && !(dr == 0 && dc == 0);
  }

  // Чи є стрибок на 2 клітинки валідним (по прямій або діагоналі через null)
  static bool _isValidJump(GridStar a, GridStar b, LevelData level) {
    final dr = b.row - a.row;
    final dc = b.col - a.col;
    // Рівно 2 клітинки: пряма (2,0)/(0,2) або діагональ (2,2)
    final isJumpShape = (dr.abs() == 2 && dc == 0) ||
                        (dr == 0 && dc.abs() == 2) ||
                        (dr.abs() == 2 && dc.abs() == 2);
    if (!isJumpShape) return false;
    // Проміжна клітинка має бути порожньою
    final midRow = a.row + dr ~/ 2;
    final midCol = a.col + dc ~/ 2;
    return level.starAt(midRow, midCol) == null;
  }

  // Чи можна дістатися зірки b від a (суміжна або стрибок через null)
  static bool isReachable(GridStar a, GridStar b, LevelData level) {
    return isAdjacent(a, b) || _isValidJump(a, b, level);
  }

  // Чи є перехід між спектрами валідним (тільки ±1)
  static bool isValidTransition(StarSpectrum from, StarSpectrum to) {
    return (from.index - to.index).abs() == 1;
  }

  // Перевірка першого кроку (чи натиснули на A)
  static StepResult validateFirstStep(GridStar tapped, LevelData level) {
    final (startRow, startCol) = level.startPos;
    if (tapped.row == startRow && tapped.col == startCol) {
      return StepResult.valid(tapped.spectrum);
    }
    return const StepResult.invalid(PathError.wrongStartStar);
  }

  // Перевірка наступного кроку
  static StepResult validateNextStep(
    PathNode lastNode,
    GridStar next,
    List<PathNode> currentPath,
    LevelData level,
  ) {
    // Зірка вже в шляху?
    final alreadyInPath = currentPath.any(
      (n) => n.star.row == next.row && n.star.col == next.col,
    );
    if (alreadyInPath) return const StepResult.invalid(PathError.alreadyInPath);

    // Досяжна? (сусідня або стрибок через null)
    if (!isReachable(lastNode.star, next, level)) {
      return const StepResult.invalid(PathError.notAdjacent);
    }

    // Бінарна зірка — обираємо спектр автоматично
    if (next.isBinary) {
      return _validateBinaryStep(lastNode.usedSpectrum, next);
    }

    // Звичайна зірка — перевіряємо спектр
    if (!isValidTransition(lastNode.usedSpectrum, next.spectrum)) {
      return const StepResult.invalid(PathError.spectrumBroken);
    }

    return StepResult.valid(next.spectrum);
  }

  // Логіка бінарної зірки — перший клік використовує primary, потім fallback на secondary.
  // Подальше перемикання відбувається через GameState._toggleLastBinary().
  static StepResult _validateBinaryStep(
    StarSpectrum prevSpectrum,
    GridStar binary,
  ) {
    if (isValidTransition(prevSpectrum, binary.spectrum)) {
      return StepResult.valid(binary.spectrum);
    }
    if (isValidTransition(prevSpectrum, binary.secondSpectrum!)) {
      return StepResult.valid(binary.secondSpectrum!);
    }
    return const StepResult.invalid(PathError.spectrumBroken);
  }

  // Перевірка завершеного шляху (коли дійшли до B)
  static bool isPathComplete(
    List<PathNode> path,
    LevelData level,
  ) {
    if (path.isEmpty) return false;

    // Останній вузол = точка B?
    final last = path.last.star;
    final (endRow, endCol) = level.endPos;
    if (last.row != endRow || last.col != endCol) return false;

    // Довжина правильна?
    if (path.length != level.pathLength) return false;

    // Сума яскравості (якщо є ціль)?
    if (level.targetBrightness != null) {
      final sum = path.fold(0, (acc, n) => acc + n.brightness);
      if (sum != level.targetBrightness) return false;
    }

    return true;
  }

  // Поточна сума яскравості шляху
  static int currentBrightnessSum(List<PathNode> path) {
    return path.fold(0, (acc, n) => acc + n.brightness);
  }
}