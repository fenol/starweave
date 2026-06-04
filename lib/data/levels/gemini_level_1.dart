import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Близнюки · Рівень 1 · α Кастор · 8×10 · шлях=21
class GeminiLevel1 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 1,
    totalLevels: 8,
    greekLetter: 'α',
    starName: 'Кастор',
    starNameLatin: 'Castor',
    constellation: 'Близнюки',
    goalText: 'Знайди шлях від А до В',
    pathLength: 21,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ЗИҐЗАҐ ВНИЗ · СТРИБКИ ПО ЛІВОМУ КРАЮ · ПЕТЛЯ ВНИЗУ',
    grid: _buildGrid(),
    startPos: (3, 1),
    endPos:   (7, 6),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ────────────────────────────────────────────────────────
    _p(grid, 0, 0, g);
    _p(grid, 0, 3, r, type: StarType.binary, second: b);
    _p(grid, 0, 5, b);
    _p(grid, 0, 6, r, type: StarType.binary, second: b);

    // ── Рядок 1 (y=2) ────────────────────────────────────────────────────────
    _p(grid, 1, 0, r);
    _p(grid, 1, 1, w);
    _p(grid, 1, 2, b);
    _p(grid, 1, 3, b);
    _p(grid, 1, 5, r);
    _p(grid, 1, 6, b);
    _p(grid, 1, 7, r, type: StarType.binary, second: b);

    // ── Рядок 2 (y=3) ────────────────────────────────────────────────────────
    _p(grid, 2, 0, b);
    _p(grid, 2, 1, r);              // крок 3
    _p(grid, 2, 2, w, type: StarType.binary, second: g); // крок 2 (uses gold)
    _p(grid, 2, 3, g);
    _p(grid, 2, 4, b);
    _p(grid, 2, 5, r, type: StarType.binary, second: b);
    _p(grid, 2, 6, w);

    // ── Рядок 3 (y=4) ────────────────────────────────────────────────────────
    _p(grid, 3, 0, b);
    _p(grid, 3, 1, r);              // A · крок 1
    _p(grid, 3, 4, b);
    _p(grid, 3, 5, r);
    _p(grid, 3, 6, r, type: StarType.binary, second: b);

    // ── Рядок 4 (y=5) ────────────────────────────────────────────────────────
    _p(grid, 4, 0, r);              // крок 7
    _p(grid, 4, 2, g);              // крок 6
    _p(grid, 4, 3, g);              // крок 4
    _p(grid, 4, 6, b, type: StarType.binary, second: w);
    _p(grid, 4, 7, w);

    // ── Рядок 5 (y=6) ────────────────────────────────────────────────────────
    _p(grid, 5, 2, r, type: StarType.binary, second: b); // крок 5 (uses red)
    _p(grid, 5, 3, w);              // крок 19
    _p(grid, 5, 4, g);              // крок 20
    _p(grid, 5, 5, g);
    _p(grid, 5, 6, g);
    _p(grid, 5, 7, r);

    // ── Рядок 6 (y=7) ────────────────────────────────────────────────────────
    _p(grid, 6, 0, g);              // крок 8
    _p(grid, 6, 1, r, type: StarType.binary, second: b);
    _p(grid, 6, 2, r);
    _p(grid, 6, 6, g);
    _p(grid, 6, 7, b);

    // ── Рядок 7 (y=8) ────────────────────────────────────────────────────────
    _p(grid, 7, 1, w);              // крок 11
    _p(grid, 7, 3, b);              // крок 12
    _p(grid, 7, 4, b);
    _p(grid, 7, 5, g);              // крок 18
    _p(grid, 7, 6, r);              // B · крок 21

    // ── Рядок 8 (y=9) ────────────────────────────────────────────────────────
    _p(grid, 8, 0, w);              // крок 9
    _p(grid, 8, 1, b);              // крок 10
    _p(grid, 8, 2, w);              // крок 13
    _p(grid, 8, 3, r);
    _p(grid, 8, 4, r);              // крок 17
    _p(grid, 8, 6, b);
    _p(grid, 8, 7, w);

    // ── Рядок 9 (y=10) ───────────────────────────────────────────────────────
    _p(grid, 9, 0, g);
    _p(grid, 9, 2, b);              // крок 14
    _p(grid, 9, 3, b, type: StarType.binary, second: w); // крок 15 (uses white)
    _p(grid, 9, 4, g);              // крок 16
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
