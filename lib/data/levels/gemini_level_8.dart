import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Близнюки · Рівень 8 · μ Тейат · 8×10 · шлях=26
class GeminiLevel8 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 8,
    totalLevels: 8,
    greekLetter: 'μ',
    starName: 'Тейат',
    starNameLatin: 'Tejat',
    constellation: 'Близнюки',
    goalText: 'Знайди шлях від А до В',
    pathLength: 26,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ВГОРУ ПРАВИМ КРАЄМ · ЗИҐЗАҐ ВНИЗ-ЛІВОРУЧ · ПЕТЛЯ ВНИЗУ · ФІНАЛ ПРАВОРУЧ',
    grid: _buildGrid(),
    startPos: (2, 7),
    endPos:   (5, 5),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ────────────────────────────────────────────────────────
    _p(grid, 0, 0, g, type: StarType.binary, second: r);
    _p(grid, 0, 1, g);              // крок 14
    _p(grid, 0, 3, r);              // крок 13
    _p(grid, 0, 4, w);
    _p(grid, 0, 5, r);
    _p(grid, 0, 6, b, type: StarType.binary, second: w); // крок 5 (uses white)

    // ── Рядок 1 (y=2) ────────────────────────────────────────────────────────
    _p(grid, 1, 0, b);
    _p(grid, 1, 2, g);              // крок 16
    _p(grid, 1, 5, b);              // крок 6
    _p(grid, 1, 6, g);              // крок 4
    _p(grid, 1, 7, w);

    // ── Рядок 2 (y=3) ────────────────────────────────────────────────────────
    _p(grid, 2, 0, r);
    _p(grid, 2, 1, w);              // крок 15
    _p(grid, 2, 5, w, type: StarType.binary, second: g); // крок 12 (uses gold)
    _p(grid, 2, 6, w);              // крок 3
    _p(grid, 2, 7, w);              // A · крок 1

    // ── Рядок 3 (y=4) ────────────────────────────────────────────────────────
    _p(grid, 3, 0, g, type: StarType.binary, second: r); // крок 18 (uses gold)
    _p(grid, 3, 2, r, type: StarType.binary, second: b); // крок 17 (uses red)
    _p(grid, 3, 3, w);              // крок 7
    _p(grid, 3, 4, g);              // крок 8
    _p(grid, 3, 5, r);              // крок 11
    _p(grid, 3, 6, b);              // крок 2
    _p(grid, 3, 7, r);

    // ── Рядок 4 (y=5) ────────────────────────────────────────────────────────
    _p(grid, 4, 1, r, type: StarType.binary, second: b);
    _p(grid, 4, 2, r, type: StarType.binary, second: b);
    _p(grid, 4, 5, g);              // крок 10

    // ── Рядок 5 (y=6) ────────────────────────────────────────────────────────
    _p(grid, 5, 0, r);              // крок 19
    _p(grid, 5, 2, b);
    _p(grid, 5, 3, b);
    _p(grid, 5, 4, r, type: StarType.binary, second: b); // крок 9 (uses red)
    _p(grid, 5, 5, g);              // B · крок 26

    // ── Рядок 6 (y=7) ────────────────────────────────────────────────────────
    _p(grid, 6, 0, r);
    _p(grid, 6, 2, r);              // крок 21
    _p(grid, 6, 3, g);
    _p(grid, 6, 4, g);              // крок 24
    _p(grid, 6, 5, r);              // крок 25

    // ── Рядок 7 (y=8) ────────────────────────────────────────────────────────
    _p(grid, 7, 0, g);
    _p(grid, 7, 2, w, type: StarType.binary, second: g); // крок 20 (uses gold)
    _p(grid, 7, 3, g);              // крок 22
    _p(grid, 7, 5, w);              // крок 23

    // ── Рядок 8 (y=9) ────────────────────────────────────────────────────────
    _p(grid, 8, 0, b);
    _p(grid, 8, 2, b);

    // ── Рядок 9 (y=10) ───────────────────────────────────────────────────────
    _p(grid, 9, 2, w);
    _p(grid, 9, 4, r);
    _p(grid, 9, 5, b);
    _p(grid, 9, 6, g, type: StarType.binary, second: r);

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
