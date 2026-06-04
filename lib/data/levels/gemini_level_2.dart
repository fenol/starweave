import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Близнюки · Рівень 2 · β Поллукс · 8×10 · шлях=20
class GeminiLevel2 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 2,
    totalLevels: 8,
    greekLetter: 'β',
    starName: 'Поллукс',
    starNameLatin: 'Pollux',
    constellation: 'Близнюки',
    goalText: 'Знайди шлях від А до В',
    pathLength: 20,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'СТРИБКИ ДО КРАЮ · ЗИҐЗАҐ ЧЕРЕЗ ЦЕНТР · ПЕТЛЯ ВНИЗУ ЛІВОРУЧ',
    grid: _buildGrid(),
    startPos: (3, 2),
    endPos:   (7, 1),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ────────────────────────────────────────────────────────
    _p(grid, 0, 0, w);
    _p(grid, 0, 1, r);
    _p(grid, 0, 2, b);
    _p(grid, 0, 4, b);
    _p(grid, 0, 6, g);
    _p(grid, 0, 7, g);

    // ── Рядок 1 (y=2) ────────────────────────────────────────────────────────
    _p(grid, 1, 1, r);
    _p(grid, 1, 2, g, type: StarType.binary, second: r);
    _p(grid, 1, 3, b);
    _p(grid, 1, 4, g, type: StarType.binary, second: r);
    _p(grid, 1, 5, r);
    _p(grid, 1, 6, r);
    _p(grid, 1, 7, g);

    // ── Рядок 2 (y=3) ────────────────────────────────────────────────────────
    _p(grid, 2, 1, w);              // крок 12
    _p(grid, 2, 3, b);              // крок 11
    _p(grid, 2, 6, r);
    _p(grid, 2, 7, r);

    // ── Рядок 3 (y=4) ────────────────────────────────────────────────────────
    _p(grid, 3, 0, b);              // крок 13
    _p(grid, 3, 1, w);              // крок 14
    _p(grid, 3, 2, g);              // A · крок 1
    _p(grid, 3, 3, r);
    _p(grid, 3, 6, r);
    _p(grid, 3, 7, w, type: StarType.binary, second: g);

    // ── Рядок 4 (y=5) ────────────────────────────────────────────────────────
    _p(grid, 4, 0, b, type: StarType.binary, second: w);
    _p(grid, 4, 3, g);
    _p(grid, 4, 5, w);              // крок 10
    _p(grid, 4, 6, g);
    _p(grid, 4, 7, r);

    // ── Рядок 5 (y=6) ────────────────────────────────────────────────────────
    _p(grid, 5, 0, r);              // крок 2
    _p(grid, 5, 2, g);              // крок 3
    _p(grid, 5, 3, w, type: StarType.binary, second: g); // крок 15 (uses gold)
    _p(grid, 5, 4, b);              // крок 9
    _p(grid, 5, 5, r);
    _p(grid, 5, 6, r);
    _p(grid, 5, 7, r);

    // ── Рядок 6 (y=7) ────────────────────────────────────────────────────────
    _p(grid, 6, 1, w);
    _p(grid, 6, 5, w);              // крок 8
    _p(grid, 6, 6, b);              // крок 7

    // ── Рядок 7 (y=8) ────────────────────────────────────────────────────────
    _p(grid, 7, 0, w);
    _p(grid, 7, 1, w);              // B · крок 20
    _p(grid, 7, 2, w);              // крок 4
    _p(grid, 7, 3, r);              // крок 16
    _p(grid, 7, 4, r);
    _p(grid, 7, 6, b);
    _p(grid, 7, 7, r);

    // ── Рядок 8 (y=9) ────────────────────────────────────────────────────────
    _p(grid, 8, 1, g);              // крок 19
    _p(grid, 8, 3, r, type: StarType.binary, second: b); // крок 5 (uses blue)
    _p(grid, 8, 4, w, type: StarType.binary, second: g); // крок 6 (uses white)
    _p(grid, 8, 7, b);

    // ── Рядок 9 (y=10) ───────────────────────────────────────────────────────
    _p(grid, 9, 0, w);              // крок 18
    _p(grid, 9, 1, g);              // крок 17
    _p(grid, 9, 4, r, type: StarType.binary, second: b);
    _p(grid, 9, 5, g);
    _p(grid, 9, 6, g);
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
