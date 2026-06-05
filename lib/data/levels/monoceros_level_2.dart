import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Єдиноріг · Рівень 2 · β Бета Єдин.
// Сітка 8×10, шлях=19
// Рішення: A(5,1)w→(4,2)b→(5,3)w→JUMP→(7,5)g→JUMP→(5,7)w
//           →JUMP→(5,5)g→JUMP→(3,5)r→JUMP→(4,4)binr→g→JUMP→(4,6)r
//           →(3,7)g→(2,6)r→(1,7)g→(1,5)binr→r
//           →(0,6)g→(0,5)r→JUMP→(2,7)g→(3,6)w
//           →JUMP→(5,4)binr→g→JUMP→(3,2)w=B
class MonocerosLevel2 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 2,
    totalLevels: 5,
    greekLetter: 'β',
    starName: 'Бета Єдин.',
    starNameLatin: 'Beta Mon',
    constellation: 'Єдиноріг',
    goalText: 'Знайди шлях від А до В',
    pathLength: 19,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (5, 1),
    endPos: (3, 2),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, b);
    _p(grid, 0, 1, b);
    _p(grid, 0, 2, b);
    _p(grid, 0, 3, b);
    _p(grid, 0, 4, b, type: StarType.binary, second: w);
    _p(grid, 0, 5, r); // крок 15
    _p(grid, 0, 6, g); // крок 14

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 1, w);
    _p(grid, 1, 2, r);
    _p(grid, 1, 3, b);
    _p(grid, 1, 5, r, type: StarType.binaryReversed, second: b); // крок 13
    _p(grid, 1, 7, g); // крок 12

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, b);
    _p(grid, 2, 1, r, type: StarType.binary, second: b);
    _p(grid, 2, 2, r, type: StarType.binaryReversed, second: b);
    _p(grid, 2, 3, w);
    _p(grid, 2, 5, w);
    _p(grid, 2, 6, r); // крок 11
    _p(grid, 2, 7, g); // крок 16

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, r);
    _p(grid, 3, 1, w);
    _p(grid, 3, 2, w); // B · крок 19
    _p(grid, 3, 4, w);
    _p(grid, 3, 5, r); // крок 7
    _p(grid, 3, 6, w); // крок 17
    _p(grid, 3, 7, g); // крок 10

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 2, b); // крок 2
    _p(grid, 4, 4, g, type: StarType.binaryReversed, second: r); // крок 8
    _p(grid, 4, 6, r); // крок 9

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, b);
    _p(grid, 5, 1, w); // A · крок 1
    _p(grid, 5, 3, w); // крок 3
    _p(grid, 5, 4, w, type: StarType.binaryReversed, second: g); // крок 18
    _p(grid, 5, 5, g); // крок 6
    _p(grid, 5, 7, w); // крок 5

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, b);
    _p(grid, 6, 5, b);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, b);
    _p(grid, 7, 2, b);
    _p(grid, 7, 4, b);
    _p(grid, 7, 5, g); // крок 4
    _p(grid, 7, 6, b);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r);
    _p(grid, 8, 1, b);
    _p(grid, 8, 2, g);
    _p(grid, 8, 3, b);
    _p(grid, 8, 4, w);
    _p(grid, 8, 5, w, type: StarType.binaryReversed, second: g);
    _p(grid, 8, 7, g, type: StarType.binary, second: r);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g);
    _p(grid, 9, 1, g);
    _p(grid, 9, 2, w);
    _p(grid, 9, 3, g);
    _p(grid, 9, 4, g);
    _p(grid, 9, 5, r, type: StarType.binary, second: b);
    _p(grid, 9, 6, g);

    return grid;
  }

  static void _p(
    List<List<GridStar?>> grid, int row, int col, StarSpectrum s, {
    StarType type = StarType.normal,
    StarSpectrum? second,
  }) {
    grid[row][col] = GridStar(
      row: row, col: col, spectrum: s, type: type, secondSpectrum: second,
    );
  }
}
