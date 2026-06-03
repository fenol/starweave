import 'star_model.dart';

// Дані одного рівня
class LevelData {
  final int levelNumber;       // 1–7
  final int totalLevels;       // 7
  final String greekLetter;    // α β γ δ ε ζ η
  final String starName;       // Дубге
  final String starNameLatin;  // Dubhe
  final String constellation;  // Велика Ведмедиця
  final String goalText;       // Текст цілі
  final int pathLength;        // Правильна довжина шляху
  final int? targetBrightness; // Ціль суми (null = без суми)
  final int solutionCount;     // Кількість правильних рішень
  final String difficulty;     // ЛЕГКИЙ / СКЛАДНІШЕ / НОВА МЕХАНІКА
  final String hint;           // Підказка внизу

  // Сітка: null = порожня клітинка
  final List<List<GridStar?>> grid;

  // Позиції A і B
  final (int row, int col) startPos;
  final (int row, int col) endPos;

  const LevelData({
    required this.levelNumber,
    required this.totalLevels,
    required this.greekLetter,
    required this.starName,
    required this.starNameLatin,
    required this.constellation,
    required this.goalText,
    required this.pathLength,
    this.targetBrightness,
    required this.solutionCount,
    required this.difficulty,
    required this.hint,
    required this.grid,
    required this.startPos,
    required this.endPos,
  });

  int get rows => grid.length;
  int get cols => grid.isEmpty ? 0 : grid[0].length;

  GridStar? starAt(int row, int col) {
    if (row < 0 || row >= rows) return null;
    if (col < 0 || col >= cols) return null;
    return grid[row][col];
  }
}