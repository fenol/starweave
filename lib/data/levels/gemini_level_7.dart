import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Близнюки · Рівень 7 · η Пропус · 8×10 · шлях=26
class GeminiLevel7 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 7,
    totalLevels: 8,
    greekLetter: 'η',
    starName: 'Пропус',
    starNameLatin: 'Propus',
    constellation: 'Близнюки',
    goalText: 'Знайди шлях від А до В',
    pathLength: 26,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ЗИҐЗАҐ ПРАВОРУЧ-ВНИЗУ · ПЕТЛЯ ВНИЗУ-ПРАВОРУЧ · ЗИҐЗАҐ ЛІВОРУЧ-ВГОРУ',
    grid: _buildGrid(),
    startPos: (6, 6),
    endPos:   (0, 5),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ────────────────────────────────────────────────────────
    _p(grid, 0, 0, g);
    _p(grid, 0, 1, g);
    _p(grid, 0, 2, g);              // крок 22
    _p(grid, 0, 3, r);
    _p(grid, 0, 5, g);              // B · крок 26
    _p(grid, 0, 6, w, type: StarType.binary, second: g); // крок 25 (uses white)
    _p(grid, 0, 7, b);

    // ── Рядок 1 (y=2) ────────────────────────────────────────────────────────
    _p(grid, 1, 0, g);              // крок 20
    _p(grid, 1, 1, w);              // крок 21
    _p(grid, 1, 3, w);              // крок 23
    _p(grid, 1, 6, b);
    _p(grid, 1, 7, b, type: StarType.binary, second: w);

    // ── Рядок 2 (y=3) ────────────────────────────────────────────────────────
    _p(grid, 2, 0, g, type: StarType.binary, second: r);
    _p(grid, 2, 3, b);
    _p(grid, 2, 4, g);              // крок 24
    _p(grid, 2, 5, b);
    _p(grid, 2, 6, g);
    _p(grid, 2, 7, g);

    // ── Рядок 3 (y=4) ────────────────────────────────────────────────────────
    _p(grid, 3, 0, r, type: StarType.binary, second: b);
    _p(grid, 3, 1, r);
    _p(grid, 3, 2, r, type: StarType.binary, second: b); // крок 19 (uses red)
    _p(grid, 3, 3, r, type: StarType.binary, second: b);
    _p(grid, 3, 4, b);
    _p(grid, 3, 6, r);
    _p(grid, 3, 7, b);

    // ── Рядок 4 (y=5) ────────────────────────────────────────────────────────
    _p(grid, 4, 0, b, type: StarType.binary, second: w);
    _p(grid, 4, 2, w);
    _p(grid, 4, 3, r, type: StarType.binary, second: b);
    _p(grid, 4, 4, b);
    _p(grid, 4, 5, b);
    _p(grid, 4, 6, w);
    _p(grid, 4, 7, r, type: StarType.binary, second: b);

    // ── Рядок 5 (y=6) ────────────────────────────────────────────────────────
    _p(grid, 5, 0, g);              // крок 18
    _p(grid, 5, 3, r);
    _p(grid, 5, 4, r, type: StarType.binary, second: b); // крок 4 (uses blue)
    _p(grid, 5, 5, w);              // крок 3

    // ── Рядок 6 (y=7) ────────────────────────────────────────────────────────
    _p(grid, 6, 1, b);
    _p(grid, 6, 2, r);              // крок 13
    _p(grid, 6, 3, w, type: StarType.binary, second: g); // крок 5 (uses white)
    _p(grid, 6, 4, b);              // крок 2
    _p(grid, 6, 6, w);              // A · крок 1
    _p(grid, 6, 7, g, type: StarType.binary, second: r);

    // ── Рядок 7 (y=8) ────────────────────────────────────────────────────────
    _p(grid, 7, 0, r);              // крок 17
    _p(grid, 7, 1, g);              // крок 16
    _p(grid, 7, 3, g);              // крок 12
    _p(grid, 7, 5, r);              // крок 9
    _p(grid, 7, 6, g);              // крок 8

    // ── Рядок 8 (y=9) ────────────────────────────────────────────────────────
    _p(grid, 8, 0, w);              // крок 15
    _p(grid, 8, 2, g);              // крок 14
    _p(grid, 8, 3, b, type: StarType.binary, second: w); // крок 11 (uses white)
    _p(grid, 8, 5, g);              // крок 6

    // ── Рядок 9 (y=10) ───────────────────────────────────────────────────────
    _p(grid, 9, 3, w, type: StarType.binary, second: g); // крок 10 (uses gold)
    _p(grid, 9, 6, r);              // крок 7
    _p(grid, 9, 7, b, type: StarType.binary, second: w);

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
