import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Близнюки · Рівень 5 · ε Мебсута · 8×10 · шлях=24
class GeminiLevel5 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 5,
    totalLevels: 8,
    greekLetter: 'ε',
    starName: 'Мебсута',
    starNameLatin: 'Mebsuta',
    constellation: 'Близнюки',
    goalText: 'Знайди шлях від А до В',
    pathLength: 24,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ПЕТЛЯ ЛІВОРУЧ-ВНИЗУ · ЗИҐЗАҐ ПО ЦЕНТРУ · ЗМІЙКА ПРАВОРУЧ-ВГОРУ',
    grid: _buildGrid(),
    startPos: (8, 2),
    endPos:   (0, 6),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ────────────────────────────────────────────────────────
    _p(grid, 0, 0, b, type: StarType.binary, second: w);
    _p(grid, 0, 1, w, type: StarType.binary, second: g);
    _p(grid, 0, 2, b, type: StarType.binary, second: w);
    _p(grid, 0, 3, r);
    _p(grid, 0, 4, g);              // крок 16
    _p(grid, 0, 5, b);              // крок 18
    _p(grid, 0, 6, g);              // B · крок 24

    // ── Рядок 1 (y=2) ────────────────────────────────────────────────────────
    _p(grid, 1, 0, r);
    _p(grid, 1, 2, r, type: StarType.binary, second: b); // крок 14 (uses blue)
    _p(grid, 1, 4, w);              // крок 15
    _p(grid, 1, 5, w);              // крок 17
    _p(grid, 1, 6, b, type: StarType.binary, second: w); // крок 19 (uses white)
    _p(grid, 1, 7, w);              // крок 23

    // ── Рядок 2 (y=3) ────────────────────────────────────────────────────────
    _p(grid, 2, 0, r);
    _p(grid, 2, 5, w, type: StarType.binary, second: g); // крок 20 (uses gold)
    _p(grid, 2, 7, g);              // крок 22

    // ── Рядок 3 (y=4) ────────────────────────────────────────────────────────
    _p(grid, 3, 0, g, type: StarType.binary, second: r);
    _p(grid, 3, 1, r);
    _p(grid, 3, 2, w);              // крок 13
    _p(grid, 3, 4, b);              // крок 12
    _p(grid, 3, 6, w);              // крок 21

    // ── Рядок 4 (y=5) ────────────────────────────────────────────────────────
    _p(grid, 4, 0, g);
    _p(grid, 4, 1, w);
    _p(grid, 4, 3, w);              // крок 11
    _p(grid, 4, 4, b, type: StarType.binary, second: w); // крок 10 (uses blue)
    _p(grid, 4, 5, w);              // крок 9
    _p(grid, 4, 7, w);

    // ── Рядок 5 (y=6) ────────────────────────────────────────────────────────
    _p(grid, 5, 2, w, type: StarType.binary, second: g); // крок 5 (uses white)
    _p(grid, 5, 5, g);              // крок 8

    // ── Рядок 6 (y=7) ────────────────────────────────────────────────────────
    _p(grid, 6, 0, w);
    _p(grid, 6, 6, b);

    // ── Рядок 7 (y=8) ────────────────────────────────────────────────────────
    _p(grid, 7, 0, r);              // крок 3
    _p(grid, 7, 2, g);              // крок 4
    _p(grid, 7, 3, w);              // крок 7
    _p(grid, 7, 4, b);              // крок 6
    _p(grid, 7, 5, b);
    _p(grid, 7, 6, g);
    _p(grid, 7, 7, b);

    // ── Рядок 8 (y=9) ────────────────────────────────────────────────────────
    _p(grid, 8, 0, r);
    _p(grid, 8, 1, g);              // крок 2
    _p(grid, 8, 2, r);              // A · крок 1
    _p(grid, 8, 3, r, type: StarType.binary, second: b);
    _p(grid, 8, 4, r, type: StarType.binary, second: b);
    _p(grid, 8, 5, b);
    _p(grid, 8, 6, b, type: StarType.binary, second: w);
    _p(grid, 8, 7, r, type: StarType.binary, second: b);

    // ── Рядок 9 (y=10) ───────────────────────────────────────────────────────
    _p(grid, 9, 0, r);
    _p(grid, 9, 1, b);
    _p(grid, 9, 2, b);
    _p(grid, 9, 3, r);
    _p(grid, 9, 4, r);
    _p(grid, 9, 5, w);
    _p(grid, 9, 6, g);
    _p(grid, 9, 7, r);

    return grid;
  }

  static void _p(
    List<List<GridStar?>> grid, int row, int col, StarSpectrum s, {
    StarType type = StarType.normal,
    StarSpectrum? second,
  }) {
    grid[row][col] = GridStar(row: row, col: col, spectrum: s, type: type, secondSpectrum: second);
  }
}
