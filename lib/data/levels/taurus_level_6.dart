import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Телець · Рівень 6 · ζ Зета Тельця
// Сітка 8×10, шлях=27
// Рішення: A(4,7)g→(3,6)r→(3,5)binr→g→(2,6)w→(1,7)b
//           →JUMP→(3,7)bin→w→(4,6)bin→b→(5,7)binr→w
//           →(6,6)b→(7,7)w→(8,6)bin→g→JUMP→(6,4)r
//           →JUMP→(4,4)g→(5,5)r→(4,5)g→JUMP→(2,3)r
//           →(2,2)g→(1,2)r→JUMP→(1,0)g→JUMP→(3,0)bin→w
//           →(4,1)g→JUMP→(6,3)w→JUMP→(8,3)g→(9,4)r
//           →JUMP→(9,6)g→(8,7)binr→w→(9,7)g=B
class TaurusLevel6 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 6,
    totalLevels: 9,
    greekLetter: 'ζ',
    starName: 'Зета Тельця',
    starNameLatin: 'Zeta Tau',
    constellation: 'Телець',
    goalText: 'Знайди шлях від А до В',
    pathLength: 27,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНІШЕ',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (4, 7),
    endPos: (9, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 1, r);
    _p(grid, 0, 2, r);
    _p(grid, 0, 3, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 4, b);
    _p(grid, 0, 5, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 6, g);
    _p(grid, 0, 7, g, type: StarType.binaryReversed, second: r);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, g); // крок 19
    _p(grid, 1, 2, r); // крок 18
    _p(grid, 1, 4, b);
    _p(grid, 1, 5, b, type: StarType.binaryReversed, second: w);
    _p(grid, 1, 6, r, type: StarType.binary, second: b);
    _p(grid, 1, 7, b); // крок 5

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 2, g); // крок 17
    _p(grid, 2, 3, r); // крок 16
    _p(grid, 2, 5, r);
    _p(grid, 2, 6, w); // крок 4
    _p(grid, 2, 7, b);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, b, type: StarType.binary, second: w); // крок 20
    _p(grid, 3, 2, b);
    _p(grid, 3, 5, g, type: StarType.binaryReversed, second: r); // крок 3
    _p(grid, 3, 6, r); // крок 2
    _p(grid, 3, 7, b, type: StarType.binary, second: w); // крок 6

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, b);
    _p(grid, 4, 1, g); // крок 21
    _p(grid, 4, 2, r, type: StarType.binary, second: b);
    _p(grid, 4, 3, r);
    _p(grid, 4, 4, g); // крок 13
    _p(grid, 4, 5, g); // крок 15
    _p(grid, 4, 6, r, type: StarType.binary, second: b); // крок 7
    _p(grid, 4, 7, g); // A · крок 1

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, g, type: StarType.binary, second: r);
    _p(grid, 5, 1, b);
    _p(grid, 5, 3, r);
    _p(grid, 5, 5, r); // крок 14
    _p(grid, 5, 6, b);
    _p(grid, 5, 7, w, type: StarType.binaryReversed, second: g); // крок 8

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, b, type: StarType.binaryReversed, second: w);
    _p(grid, 6, 3, w); // крок 22
    _p(grid, 6, 4, r); // крок 12
    _p(grid, 6, 5, b);
    _p(grid, 6, 6, b); // крок 9
    _p(grid, 6, 7, g);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, r);
    _p(grid, 7, 6, b);
    _p(grid, 7, 7, w); // крок 10

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, b, type: StarType.binaryReversed, second: w);
    _p(grid, 8, 1, w);
    _p(grid, 8, 3, g); // крок 23
    _p(grid, 8, 6, w, type: StarType.binary, second: g); // крок 11
    _p(grid, 8, 7, w, type: StarType.binaryReversed, second: g); // крок 26

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g, type: StarType.binaryReversed, second: r);
    _p(grid, 9, 1, r);
    _p(grid, 9, 2, b);
    _p(grid, 9, 3, g, type: StarType.binaryReversed, second: r);
    _p(grid, 9, 4, r); // крок 24
    _p(grid, 9, 6, g); // крок 25
    _p(grid, 9, 7, g); // B · крок 27

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
