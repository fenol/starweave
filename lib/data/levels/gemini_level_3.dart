import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Близнюки · Рівень 3 · γ Альхена · 8×10 · шлях=25
class GeminiLevel3 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 3,
    totalLevels: 8,
    greekLetter: 'γ',
    starName: 'Альхена',
    starNameLatin: 'Alhena',
    constellation: 'Близнюки',
    goalText: 'Знайди шлях від А до В',
    pathLength: 25,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ДІАГОНАЛІ ВГОРУ · ЛІВОРУЧ ВНИЗ · ПЕТЛЯ ВНИЗУ · ЗИҐЗАҐ ПРАВОРУЧ',
    grid: _buildGrid(),
    startPos: (2, 0),
    endPos:   (6, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ────────────────────────────────────────────────────────
    _p(grid, 0, 0, r, type: StarType.binary, second: b);
    _p(grid, 0, 1, b);
    _p(grid, 0, 2, b);
    _p(grid, 0, 3, b, type: StarType.binary, second: w);
    _p(grid, 0, 4, w);
    _p(grid, 0, 5, g, type: StarType.binary, second: r);
    _p(grid, 0, 6, b);
    _p(grid, 0, 7, b, type: StarType.binary, second: w);

    // ── Рядок 1 (y=2) ────────────────────────────────────────────────────────
    _p(grid, 1, 0, w);
    _p(grid, 1, 1, g);              // крок 2
    _p(grid, 1, 3, r);              // крок 3
    _p(grid, 1, 4, r);
    _p(grid, 1, 6, r);
    _p(grid, 1, 7, w);

    // ── Рядок 2 (y=3) ────────────────────────────────────────────────────────
    _p(grid, 2, 0, r);              // A · крок 1
    _p(grid, 2, 2, g);              // крок 4
    _p(grid, 2, 3, b);
    _p(grid, 2, 4, g);              // крок 22
    _p(grid, 2, 5, r, type: StarType.binary, second: b);
    _p(grid, 2, 7, r);

    // ── Рядок 3 (y=4) ────────────────────────────────────────────────────────
    _p(grid, 3, 0, b, type: StarType.binary, second: w);
    _p(grid, 3, 6, r);
    _p(grid, 3, 7, b, type: StarType.binary, second: r);

    // ── Рядок 4 (y=5) ────────────────────────────────────────────────────────
    _p(grid, 4, 0, w);              // крок 5
    _p(grid, 4, 2, g);              // крок 21
    _p(grid, 4, 5, b);              // крок 24
    _p(grid, 4, 6, w, type: StarType.binary, second: g); // крок 23 (uses white)
    _p(grid, 4, 7, g);

    // ── Рядок 5 (y=6) ────────────────────────────────────────────────────────
    _p(grid, 5, 0, b);              // крок 6
    _p(grid, 5, 2, r);
    _p(grid, 5, 3, w, type: StarType.binary, second: g); // крок 20 (uses gold)
    _p(grid, 5, 5, w, type: StarType.binary, second: g); // крок 18 (uses gold)
    _p(grid, 5, 6, r);
    _p(grid, 5, 7, b, type: StarType.binary, second: r);

    // ── Рядок 6 (y=7) ────────────────────────────────────────────────────────
    _p(grid, 6, 5, g);              // крок 16
    _p(grid, 6, 6, w);              // крок 17
    _p(grid, 6, 7, w);              // B · крок 25

    // ── Рядок 7 (y=8) ────────────────────────────────────────────────────────
    _p(grid, 7, 0, w, type: StarType.binary, second: g); // крок 7 (uses white)
    _p(grid, 7, 3, r);              // крок 19
    _p(grid, 7, 6, w);              // крок 15

    // ── Рядок 8 (y=9) ────────────────────────────────────────────────────────
    _p(grid, 8, 2, w);              // крок 9
    _p(grid, 8, 4, w);              // крок 11
    _p(grid, 8, 6, g);              // крок 12
    _p(grid, 8, 7, g);              // крок 14

    // ── Рядок 9 (y=10) ───────────────────────────────────────────────────────
    _p(grid, 9, 2, b);              // крок 8
    _p(grid, 9, 3, r, type: StarType.binary, second: b); // крок 10 (uses blue)
    _p(grid, 9, 5, w);
    _p(grid, 9, 6, r);
    _p(grid, 9, 7, w);              // крок 13

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
