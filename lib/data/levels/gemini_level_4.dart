import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Близнюки · Рівень 4 · δ Васат · 8×10 · шлях=22
class GeminiLevel4 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 4,
    totalLevels: 8,
    greekLetter: 'δ',
    starName: 'Васат',
    starNameLatin: 'Wasat',
    constellation: 'Близнюки',
    goalText: 'Знайди шлях від А до В',
    pathLength: 22,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ЗИҐЗАҐ ПРАВОЮ СТОРОНОЮ · ЛІВОРУЧ ВГОРУ ПО КРАЮ · ГОРИЗОНТАЛЬНІ СТРИБКИ',
    grid: _buildGrid(),
    startPos: (7, 5),
    endPos:   (0, 2),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ────────────────────────────────────────────────────────
    _p(grid, 0, 0, r, type: StarType.binary, second: b);
    _p(grid, 0, 1, w, type: StarType.binary, second: g);
    _p(grid, 0, 2, w);              // B · крок 22
    _p(grid, 0, 4, b);              // крок 21
    _p(grid, 0, 6, w);              // крок 20

    // ── Рядок 1 (y=2) ────────────────────────────────────────────────────────
    _p(grid, 1, 0, w);
    _p(grid, 1, 1, w);
    _p(grid, 1, 2, r);
    _p(grid, 1, 3, b);
    _p(grid, 1, 6, b, type: StarType.binary, second: w); // крок 19 (uses blue)
    _p(grid, 1, 7, r);

    // ── Рядок 2 (y=3) ────────────────────────────────────────────────────────
    _p(grid, 2, 0, g);              // крок 13
    _p(grid, 2, 2, r);              // крок 14
    _p(grid, 2, 3, w);
    _p(grid, 2, 5, r);
    _p(grid, 2, 6, w);              // крок 18
    _p(grid, 2, 7, r);

    // ── Рядок 3 (y=4) ────────────────────────────────────────────────────────
    _p(grid, 3, 0, r);              // крок 12
    _p(grid, 3, 3, r);              // крок 16
    _p(grid, 3, 4, r);              // крок 6
    _p(grid, 3, 6, b);
    _p(grid, 3, 7, b);

    // ── Рядок 4 (y=5) ────────────────────────────────────────────────────────
    _p(grid, 4, 0, w, type: StarType.binary, second: g); // крок 11 (uses gold)
    _p(grid, 4, 1, b);
    _p(grid, 4, 2, g);              // крок 15
    _p(grid, 4, 4, g);              // крок 17
    _p(grid, 4, 6, b);
    _p(grid, 4, 7, r);

    // ── Рядок 5 (y=6) ────────────────────────────────────────────────────────
    _p(grid, 5, 0, w);              // крок 10
    _p(grid, 5, 1, g);
    _p(grid, 5, 2, g);              // крок 7
    _p(grid, 5, 4, r);              // крок 8
    _p(grid, 5, 5, g);
    _p(grid, 5, 6, w, type: StarType.binary, second: g); // крок 5 (uses gold)
    _p(grid, 5, 7, b, type: StarType.binary, second: w);

    // ── Рядок 6 (y=7) ────────────────────────────────────────────────────────
    _p(grid, 6, 0, b);
    _p(grid, 6, 4, g);
    _p(grid, 6, 7, r);              // крок 4

    // ── Рядок 7 (y=8) ────────────────────────────────────────────────────────
    _p(grid, 7, 0, b);
    _p(grid, 7, 2, g);              // крок 9
    _p(grid, 7, 3, g);
    _p(grid, 7, 4, b);
    _p(grid, 7, 5, b);              // A · крок 1
    _p(grid, 7, 6, w, type: StarType.binary, second: g); // крок 2 (uses white)
    _p(grid, 7, 7, g);              // крок 3

    // ── Рядок 8 (y=9) ────────────────────────────────────────────────────────
    _p(grid, 8, 0, b, type: StarType.binary, second: w);
    _p(grid, 8, 1, w, type: StarType.binary, second: g);
    _p(grid, 8, 2, b);
    _p(grid, 8, 3, g, type: StarType.binary, second: r);
    _p(grid, 8, 4, b);
    _p(grid, 8, 5, r);

    // ── Рядок 9 (y=10) ───────────────────────────────────────────────────────
    _p(grid, 9, 1, r);
    _p(grid, 9, 2, w);
    _p(grid, 9, 3, r, type: StarType.binary, second: b);
    _p(grid, 9, 4, b);
    _p(grid, 9, 6, w);

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
