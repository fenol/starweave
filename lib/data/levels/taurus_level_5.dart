import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Телець · Рівень 5 · ε Айн
// Сітка 8×10, шлях=24
// Рішення: A(7,1)g→JUMP→(9,3)binr→r→JUMP→(7,5)g→JUMP→(7,7)w
//           →(6,6)binr→g→JUMP→(8,6)w→(9,6)g→JUMP→(7,4)w
//           →(6,4)b→(5,4)w→(5,3)b→(4,4)w→(4,3)g
//           →JUMP→(2,1)bin→w→(2,2)b→JUMP→(0,0)bin→w
//           →JUMP→(0,2)g→(1,3)r→JUMP→(1,5)bin→g
//           →(2,6)w→(2,7)g→(1,6)r→(0,7)g→(1,7)r=B
class TaurusLevel5 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 5,
    totalLevels: 9,
    greekLetter: 'ε',
    starName: 'Айн',
    starNameLatin: 'Ain',
    constellation: 'Телець',
    goalText: 'Знайди шлях від А до В',
    pathLength: 24,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНІШЕ',
    hint: 'БІНАРНА · ОБЕРНЕНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (7, 1),
    endPos: (1, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, b, type: StarType.binary, second: w); // крок 16
    _p(grid, 0, 2, g); // крок 17
    _p(grid, 0, 3, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 4, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 5, b);
    _p(grid, 0, 7, g); // крок 23

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 2, b);
    _p(grid, 1, 3, r); // крок 18
    _p(grid, 1, 5, w, type: StarType.binary, second: g); // крок 19
    _p(grid, 1, 6, r); // крок 22
    _p(grid, 1, 7, r); // B · крок 24

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 1, b, type: StarType.binary, second: w); // крок 14
    _p(grid, 2, 2, b); // крок 15
    _p(grid, 2, 3, b);
    _p(grid, 2, 4, r);
    _p(grid, 2, 5, b, type: StarType.binaryReversed, second: w);
    _p(grid, 2, 6, w); // крок 20
    _p(grid, 2, 7, g); // крок 21

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, r);
    _p(grid, 3, 1, r);
    _p(grid, 3, 3, b);
    _p(grid, 3, 4, b);
    _p(grid, 3, 5, r);
    _p(grid, 3, 6, r);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, w, type: StarType.binaryReversed, second: g);
    _p(grid, 4, 3, g); // крок 13
    _p(grid, 4, 4, w); // крок 12
    _p(grid, 4, 5, w);
    _p(grid, 4, 6, r);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, w, type: StarType.binary, second: g);
    _p(grid, 5, 1, r);
    _p(grid, 5, 2, r);
    _p(grid, 5, 3, b); // крок 11
    _p(grid, 5, 4, w); // крок 10
    _p(grid, 5, 7, g);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, g);
    _p(grid, 6, 1, g);
    _p(grid, 6, 4, b); // крок 9
    _p(grid, 6, 6, g, type: StarType.binaryReversed, second: r); // крок 5

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 1, g); // A · крок 1
    _p(grid, 7, 4, w); // крок 8
    _p(grid, 7, 5, g); // крок 3
    _p(grid, 7, 7, w); // крок 4

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 1, g);
    _p(grid, 8, 3, b, type: StarType.binaryReversed, second: w);
    _p(grid, 8, 6, w); // крок 6
    _p(grid, 8, 7, w);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w, type: StarType.binaryReversed, second: g);
    _p(grid, 9, 1, r);
    _p(grid, 9, 2, r, type: StarType.binary, second: b);
    _p(grid, 9, 3, r, type: StarType.binaryReversed, second: b); // крок 2
    _p(grid, 9, 4, r);
    _p(grid, 9, 5, b);
    _p(grid, 9, 6, g); // крок 7
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
