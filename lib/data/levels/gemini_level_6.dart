import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Близнюки · Рівень 6 · ζ Мекбута · 8×10 · шлях=23
class GeminiLevel6 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 6,
    totalLevels: 8,
    greekLetter: 'ζ',
    starName: 'Мекбута',
    starNameLatin: 'Mekbuta',
    constellation: 'Близнюки',
    goalText: 'Знайди шлях від А до В',
    pathLength: 23,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ВНИЗ ЧЕРЕЗ ЦЕНТР · ДІАГОНАЛЬНИЙ СТРИБОК · ПЕТЛЯ ЛІВОРУЧ · ЗМІЙКА ПРАВОРУЧ',
    grid: _buildGrid(),
    startPos: (1, 5),
    endPos:   (7, 6),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ────────────────────────────────────────────────────────
    _p(grid, 0, 0, w);
    _p(grid, 0, 1, w);
    _p(grid, 0, 2, b, type: StarType.binary, second: w);
    _p(grid, 0, 3, b, type: StarType.binary, second: w);
    _p(grid, 0, 4, b);
    _p(grid, 0, 6, b);
    _p(grid, 0, 7, r, type: StarType.binary, second: b);

    // ── Рядок 1 (y=2) ────────────────────────────────────────────────────────
    _p(grid, 1, 0, b);
    _p(grid, 1, 1, r);
    _p(grid, 1, 2, b);
    _p(grid, 1, 4, g);              // крок 2
    _p(grid, 1, 5, r);              // A · крок 1

    // ── Рядок 2 (y=3) ────────────────────────────────────────────────────────
    _p(grid, 2, 0, r, type: StarType.binary, second: b);
    _p(grid, 2, 2, g);
    _p(grid, 2, 5, b);
    _p(grid, 2, 6, b, type: StarType.binary, second: w);
    _p(grid, 2, 7, w);

    // ── Рядок 3 (y=4) ────────────────────────────────────────────────────────
    _p(grid, 3, 0, g);
    _p(grid, 3, 2, g);              // крок 4
    _p(grid, 3, 4, r);              // крок 3
    _p(grid, 3, 5, b);
    _p(grid, 3, 6, r);
    _p(grid, 3, 7, b, type: StarType.binary, second: w);

    // ── Рядок 4 (y=5) ────────────────────────────────────────────────────────
    _p(grid, 4, 0, b);
    _p(grid, 4, 2, w);              // крок 5
    _p(grid, 4, 3, w);
    _p(grid, 4, 4, r);              // крок 15
    _p(grid, 4, 5, w);              // крок 17
    _p(grid, 4, 7, r, type: StarType.binary, second: b);

    // ── Рядок 5 (y=6) ────────────────────────────────────────────────────────
    _p(grid, 5, 4, g);              // крок 16

    // ── Рядок 6 (y=7) ────────────────────────────────────────────────────────
    _p(grid, 6, 0, w, type: StarType.binary, second: g); // крок 12 (uses gold)
    _p(grid, 6, 1, b);
    _p(grid, 6, 2, g);              // крок 14
    _p(grid, 6, 3, w, type: StarType.binary, second: g); // крок 7 (uses white)
    _p(grid, 6, 4, b, type: StarType.binary, second: w); // крок 6 (uses blue)
    _p(grid, 6, 5, g);              // крок 18
    _p(grid, 6, 7, b);

    // ── Рядок 7 (y=8) ────────────────────────────────────────────────────────
    _p(grid, 7, 1, r);              // крок 13
    _p(grid, 7, 3, r);
    _p(grid, 7, 4, r);
    _p(grid, 7, 6, w);              // B · крок 23
    _p(grid, 7, 7, g);              // крок 22

    // ── Рядок 8 (y=9) ────────────────────────────────────────────────────────
    _p(grid, 8, 0, w);              // крок 11
    _p(grid, 8, 1, b);              // крок 8
    _p(grid, 8, 2, r);
    _p(grid, 8, 4, b, type: StarType.binary, second: w);
    _p(grid, 8, 5, r);              // крок 19
    _p(grid, 8, 7, w);

    // ── Рядок 9 (y=10) ───────────────────────────────────────────────────────
    _p(grid, 9, 0, b);              // крок 10
    _p(grid, 9, 2, w);              // крок 9
    _p(grid, 9, 3, w);
    _p(grid, 9, 4, w, type: StarType.binary, second: g); // крок 20 (uses gold)
    _p(grid, 9, 5, r);              // крок 21
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
