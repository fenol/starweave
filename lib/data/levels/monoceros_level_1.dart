import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Єдиноріг · Рівень 1 · α Альфа Єдин.
// Сітка 8×10, шлях=18
// Рішення: A(1,3)w→JUMP→(1,1)b→(2,2)binr→w→(3,1)g→(3,2)w
//           →JUMP→(5,0)g→JUMP→(7,0)r→(8,1)g→(9,1)r→(8,2)g
//           →(9,3)r→(8,4)g→JUMP→(6,6)binr→r→JUMP→(8,6)g
//           →(8,7)w→(7,7)b→JUMP→(5,7)w→JUMP→(3,7)b=B
class MonocerosLevel1 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 1,
    totalLevels: 5,
    greekLetter: 'α',
    starName: 'Альфа Єдин.',
    starNameLatin: 'Alpha Mon',
    constellation: 'Єдиноріг',
    goalText: 'Знайди шлях від А до В',
    pathLength: 18,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (1, 3),
    endPos: (3, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, g, type: StarType.binary, second: r);
    _p(grid, 0, 3, w);
    _p(grid, 0, 4, g, type: StarType.binaryReversed, second: r);
    _p(grid, 0, 5, g);
    _p(grid, 0, 6, g, type: StarType.binary, second: r);
    _p(grid, 0, 7, r);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, w);
    _p(grid, 1, 1, b); // крок 2
    _p(grid, 1, 3, w); // A · крок 1
    _p(grid, 1, 4, r);
    _p(grid, 1, 5, b);
    _p(grid, 1, 6, r, type: StarType.binary, second: b);
    _p(grid, 1, 7, r);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 2, w, type: StarType.binaryReversed, second: g); // крок 3

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, w, type: StarType.binary, second: g);
    _p(grid, 3, 1, g); // крок 4
    _p(grid, 3, 2, w); // крок 5
    _p(grid, 3, 4, w);
    _p(grid, 3, 6, g);
    _p(grid, 3, 7, b); // B · крок 18

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, b);
    _p(grid, 4, 2, r);
    _p(grid, 4, 3, r);
    _p(grid, 4, 5, b);
    _p(grid, 4, 6, b);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, g); // крок 6
    _p(grid, 5, 3, b);
    _p(grid, 5, 4, r);
    _p(grid, 5, 5, g);
    _p(grid, 5, 6, b);
    _p(grid, 5, 7, w); // крок 17

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 2, b);
    _p(grid, 6, 3, w, type: StarType.binaryReversed, second: g);
    _p(grid, 6, 5, b);
    _p(grid, 6, 6, g, type: StarType.binaryReversed, second: r); // крок 13

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, r); // крок 7
    _p(grid, 7, 4, r);
    _p(grid, 7, 7, b); // крок 16

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r);
    _p(grid, 8, 1, g); // крок 8
    _p(grid, 8, 2, g); // крок 10
    _p(grid, 8, 4, g); // крок 12
    _p(grid, 8, 5, g);
    _p(grid, 8, 6, g); // крок 14
    _p(grid, 8, 7, w); // крок 15

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w);
    _p(grid, 9, 1, r); // крок 9
    _p(grid, 9, 2, b);
    _p(grid, 9, 3, r); // крок 11
    _p(grid, 9, 4, b);
    _p(grid, 9, 5, g);
    _p(grid, 9, 7, r);

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
