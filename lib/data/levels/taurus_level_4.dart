import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Телець · Рівень 4 · δ Гіад II
// Сітка 8×10, шлях=25
// Рішення: A(3,3)r→(2,3)g→(2,4)binr→w→(1,3)b→(1,4)w
//           →JUMP→(3,6)binr→b→(4,6)w→(5,7)b→(6,7)w→(6,6)w
//           →JUMP→(6,4)g→(7,5)r→JUMP→(9,7)g→JUMP→(9,5)bin→w
//           →(8,5)bin→b→JUMP→(8,3)bin→w→(7,3)binr→g
//           →(7,2)r→JUMP→(5,0)g→JUMP→(3,2)r→JUMP→(5,4)g
//           →(5,3)w→(6,2)b→(7,1)w=B
class TaurusLevel4 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 4,
    totalLevels: 9,
    greekLetter: 'δ',
    starName: 'Гіад II',
    starNameLatin: 'Hyadum II',
    constellation: 'Телець',
    goalText: 'Знайди шлях від А до В',
    pathLength: 25,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНІШЕ',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (3, 3),
    endPos: (7, 1),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, b, type: StarType.binaryReversed, second: w);
    _p(grid, 0, 1, r, type: StarType.binary, second: b);
    _p(grid, 0, 3, b);
    _p(grid, 0, 4, g);
    _p(grid, 0, 5, w);
    _p(grid, 0, 7, g);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, b);
    _p(grid, 1, 1, b);
    _p(grid, 1, 3, b); // крок 4
    _p(grid, 1, 4, w); // крок 5
    _p(grid, 1, 7, g);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, r, type: StarType.binary, second: b);
    _p(grid, 2, 1, g, type: StarType.binary, second: r);
    _p(grid, 2, 3, g); // крок 2
    _p(grid, 2, 4, w, type: StarType.binaryReversed, second: g); // крок 3
    _p(grid, 2, 6, b);
    _p(grid, 2, 7, b);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, g);
    _p(grid, 3, 1, r);
    _p(grid, 3, 2, r); // крок 21
    _p(grid, 3, 3, r); // A · крок 1
    _p(grid, 3, 5, r);
    _p(grid, 3, 6, b, type: StarType.binaryReversed, second: w); // крок 6

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 2, r, type: StarType.binaryReversed, second: b);
    _p(grid, 4, 6, w); // крок 7

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, g); // крок 20
    _p(grid, 5, 1, r, type: StarType.binaryReversed, second: b);
    _p(grid, 5, 2, b);
    _p(grid, 5, 3, w); // крок 23
    _p(grid, 5, 4, g); // крок 22
    _p(grid, 5, 5, b, type: StarType.binaryReversed, second: w);
    _p(grid, 5, 7, b); // крок 8

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, b);
    _p(grid, 6, 2, b); // крок 24
    _p(grid, 6, 3, b);
    _p(grid, 6, 4, g); // крок 12
    _p(grid, 6, 6, w); // крок 11
    _p(grid, 6, 7, w); // крок 9

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, g);
    _p(grid, 7, 1, w); // B · крок 25
    _p(grid, 7, 2, r); // крок 19
    _p(grid, 7, 3, g, type: StarType.binaryReversed, second: r); // крок 18
    _p(grid, 7, 4, r);
    _p(grid, 7, 5, r); // крок 13
    _p(grid, 7, 6, b); // крок 10
    _p(grid, 7, 7, r);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, w);
    _p(grid, 8, 1, r);
    _p(grid, 8, 3, b, type: StarType.binary, second: w); // крок 17
    _p(grid, 8, 5, r, type: StarType.binary, second: b); // крок 16
    _p(grid, 8, 7, r, type: StarType.binary, second: b);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 1, b, type: StarType.binary, second: w);
    _p(grid, 9, 2, w);
    _p(grid, 9, 3, r);
    _p(grid, 9, 5, b, type: StarType.binary, second: w); // крок 15
    _p(grid, 9, 7, g); // крок 14

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
