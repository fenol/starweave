import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Телець · Рівень 3 · γ Гіад I
// Сітка 8×10, шлях=25
// Рішення: A(7,5)w→JUMP→(5,5)b→(6,6)w→(6,7)binr→b→(7,6)w→(7,7)g
//           →(8,7)w→(8,6)g→(9,6)w→(8,5)b→JUMP→(8,3)binr→w
//           →JUMP→(6,3)b→(6,2)w→JUMP→(8,0)g→JUMP→(6,0)w
//           →JUMP→(4,0)g→JUMP→(2,0)r→(1,1)g→(0,0)w
//           →JUMP→(0,2)b→JUMP→(0,4)w→(0,5)binr→g
//           →JUMP→(0,7)bin→w→(1,7)bin→b→(2,7)w=B
class TaurusLevel3 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 3,
    totalLevels: 9,
    greekLetter: 'γ',
    starName: 'Гіад I',
    starNameLatin: 'Hyadum I',
    constellation: 'Телець',
    goalText: 'Знайди шлях від А до В',
    pathLength: 25,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (7, 5),
    endPos: (2, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, w); // крок 19
    _p(grid, 0, 2, b); // крок 20
    _p(grid, 0, 4, w); // крок 21
    _p(grid, 0, 5, g, type: StarType.binaryReversed, second: r); // крок 22
    _p(grid, 0, 7, b, type: StarType.binary, second: w); // крок 23

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 1, g); // крок 18
    _p(grid, 1, 3, g);
    _p(grid, 1, 4, g);
    _p(grid, 1, 5, b);
    _p(grid, 1, 7, r, type: StarType.binary, second: b); // крок 24

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, r); // крок 17
    _p(grid, 2, 1, r, type: StarType.binary, second: b);
    _p(grid, 2, 2, b);
    _p(grid, 2, 3, b);
    _p(grid, 2, 4, g, type: StarType.binaryReversed, second: r);
    _p(grid, 2, 6, b);
    _p(grid, 2, 7, w); // B · крок 25

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 1, r);
    _p(grid, 3, 2, r);
    _p(grid, 3, 3, r);
    _p(grid, 3, 4, w, type: StarType.binary, second: g);
    _p(grid, 3, 5, r);
    _p(grid, 3, 6, r);
    _p(grid, 3, 7, r, type: StarType.binary, second: b);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, g); // крок 16
    _p(grid, 4, 1, b);
    _p(grid, 4, 2, b, type: StarType.binaryReversed, second: w);
    _p(grid, 4, 3, r);
    _p(grid, 4, 4, w);
    _p(grid, 4, 6, b);
    _p(grid, 4, 7, b);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 1, r);
    _p(grid, 5, 2, b, type: StarType.binaryReversed, second: w);
    _p(grid, 5, 5, b); // крок 2
    _p(grid, 5, 6, b);
    _p(grid, 5, 7, r);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, w); // крок 15
    _p(grid, 6, 2, w); // крок 13
    _p(grid, 6, 3, b); // крок 12
    _p(grid, 6, 4, r);
    _p(grid, 6, 6, w); // крок 3
    _p(grid, 6, 7, r, type: StarType.binaryReversed, second: b); // крок 4

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 4, g);
    _p(grid, 7, 5, w); // A · крок 1
    _p(grid, 7, 6, w); // крок 5
    _p(grid, 7, 7, g); // крок 6

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, g); // крок 14
    _p(grid, 8, 3, w, type: StarType.binaryReversed, second: g); // крок 11
    _p(grid, 8, 5, b); // крок 10
    _p(grid, 8, 6, g); // крок 8 (wait, path=8 for x=7,y=9 → col=6 row=8)
    _p(grid, 8, 7, w); // крок 7

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g, type: StarType.binary, second: r);
    _p(grid, 9, 1, b);
    _p(grid, 9, 2, g, type: StarType.binary, second: r);
    _p(grid, 9, 3, w, type: StarType.binaryReversed, second: g);
    _p(grid, 9, 6, w); // крок 9

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
