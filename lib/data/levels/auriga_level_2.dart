import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Візничий · Рівень 2 · β Менкалінан
// Сітка 8×10, шлях=19
// Рішення: A(3,1)g→JUMP→(1,3)r→JUMP→(3,5)g→JUMP→(3,7)binr→w
//           →(2,7)g→(1,7)r→(0,7)g→(0,6)r→JUMP→(2,6)g
//           →JUMP→(4,6)binr→r→(5,7)g→(6,7)w→(7,7)binr→b
//           →(8,7)w→(9,7)b→(8,6)w→JUMP→(6,6)b→(5,6)w→(4,7)g=B
class AurigaLevel2 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 2,
    totalLevels: 5,
    greekLetter: 'β',
    starName: 'Менкалінан',
    starNameLatin: 'Menkalinan',
    constellation: 'Візничий',
    goalText: 'Знайди шлях від А до В',
    pathLength: 19,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (3, 1),
    endPos: (4, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, g);
    _p(grid, 0, 1, g);
    _p(grid, 0, 2, r);
    _p(grid, 0, 3, b);
    _p(grid, 0, 5, w);
    _p(grid, 0, 6, r); // крок 8
    _p(grid, 0, 7, g); // крок 7

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, b);
    _p(grid, 1, 1, r);
    _p(grid, 1, 2, r);
    _p(grid, 1, 3, r); // крок 2
    _p(grid, 1, 5, w);
    _p(grid, 1, 7, r); // крок 6

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, r, type: StarType.binary, second: b);
    _p(grid, 2, 3, b, type: StarType.binary, second: w);
    _p(grid, 2, 6, g); // крок 9
    _p(grid, 2, 7, g); // крок 5

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, g);
    _p(grid, 3, 1, g); // A · крок 1
    _p(grid, 3, 2, g);
    _p(grid, 3, 5, g); // крок 3
    _p(grid, 3, 7, b, type: StarType.binaryReversed, second: w); // крок 4

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, b);
    _p(grid, 4, 1, g);
    _p(grid, 4, 2, r);
    _p(grid, 4, 3, b);
    _p(grid, 4, 6, r, type: StarType.binaryReversed, second: b); // крок 10
    _p(grid, 4, 7, g); // B · крок 19

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, g);
    _p(grid, 5, 1, g, type: StarType.binary, second: r);
    _p(grid, 5, 2, g);
    _p(grid, 5, 3, b);
    _p(grid, 5, 4, b);
    _p(grid, 5, 5, g);
    _p(grid, 5, 6, w); // крок 18
    _p(grid, 5, 7, g); // крок 11

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, w);
    _p(grid, 6, 1, g, type: StarType.binaryReversed, second: r);
    _p(grid, 6, 3, w, type: StarType.binaryReversed, second: g);
    _p(grid, 6, 6, b); // крок 17
    _p(grid, 6, 7, w); // крок 12

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, r);
    _p(grid, 7, 1, r);
    _p(grid, 7, 2, g);
    _p(grid, 7, 7, r, type: StarType.binaryReversed, second: b); // крок 13

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, w);
    _p(grid, 8, 1, r);
    _p(grid, 8, 2, g, type: StarType.binary, second: r);
    _p(grid, 8, 3, b);
    _p(grid, 8, 4, r);
    _p(grid, 8, 6, w); // крок 16
    _p(grid, 8, 7, w); // крок 14

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w);
    _p(grid, 9, 2, w);
    _p(grid, 9, 5, b);
    _p(grid, 9, 7, b); // крок 15

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
