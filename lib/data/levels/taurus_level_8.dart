import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Телець · Рівень 8 · θ Тета Тельця
// Сітка 8×10, шлях=26
// Рішення: A(7,1)g→(7,0)binr→w→(8,0)b→(8,1)binr→w
//           →(7,2)b→JUMP→(5,2)bin→w→JUMP→(3,2)g→JUMP→(5,4)r
//           →(4,5)g→JUMP→(2,3)r→(2,4)g→JUMP→(0,6)r
//           →(0,5)bin→g→JUMP→(0,3)binr→w→JUMP→(2,5)g
//           →(2,6)w→(3,6)g→(4,7)r→(5,6)g→(5,5)r
//           →JUMP→(7,7)g→JUMP→(9,5)r→JUMP→(9,3)g
//           →(9,2)r→(9,1)bin→g→(9,0)w=B
class TaurusLevel8 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 8,
    totalLevels: 9,
    greekLetter: 'θ',
    starName: 'Тета Тельця',
    starNameLatin: 'Theta Tau',
    constellation: 'Телець',
    goalText: 'Знайди шлях від А до В',
    pathLength: 26,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (7, 1),
    endPos: (9, 0),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, b, type: StarType.binary, second: w);
    _p(grid, 0, 1, g, type: StarType.binary, second: r);
    _p(grid, 0, 3, w, type: StarType.binaryReversed, second: g); // крок 14
    _p(grid, 0, 5, w, type: StarType.binary, second: g); // крок 13
    _p(grid, 0, 6, r); // крок 12
    _p(grid, 0, 7, b);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 1, r);
    _p(grid, 1, 2, b);
    _p(grid, 1, 7, b);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, r);
    _p(grid, 2, 1, b);
    _p(grid, 2, 2, b);
    _p(grid, 2, 3, r); // крок 10
    _p(grid, 2, 4, g); // крок 11
    _p(grid, 2, 5, g); // крок 15
    _p(grid, 2, 6, w); // крок 16
    _p(grid, 2, 7, r, type: StarType.binaryReversed, second: b);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 1, r, type: StarType.binary, second: b);
    _p(grid, 3, 2, g); // крок 7
    _p(grid, 3, 3, r);
    _p(grid, 3, 5, b);
    _p(grid, 3, 6, g); // крок 17

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, b, type: StarType.binaryReversed, second: w);
    _p(grid, 4, 4, b);
    _p(grid, 4, 5, g); // крок 9
    _p(grid, 4, 6, b);
    _p(grid, 4, 7, r); // крок 18

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 1, r, type: StarType.binary, second: b);
    _p(grid, 5, 2, b, type: StarType.binary, second: w); // крок 6
    _p(grid, 5, 4, r); // крок 8
    _p(grid, 5, 5, r); // крок 20
    _p(grid, 5, 6, g); // крок 19

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 3, r, type: StarType.binary, second: b);
    _p(grid, 6, 5, g, type: StarType.binaryReversed, second: r);
    _p(grid, 6, 7, g);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, w, type: StarType.binaryReversed, second: g); // крок 2
    _p(grid, 7, 1, g); // A · крок 1
    _p(grid, 7, 2, b); // крок 5
    _p(grid, 7, 4, b);
    _p(grid, 7, 5, r, type: StarType.binaryReversed, second: b);
    _p(grid, 7, 6, b);
    _p(grid, 7, 7, g); // крок 21

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, b); // крок 3
    _p(grid, 8, 1, w, type: StarType.binaryReversed, second: g); // крок 4
    _p(grid, 8, 2, b);
    _p(grid, 8, 4, b);
    _p(grid, 8, 5, b);
    _p(grid, 8, 7, w);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w); // B · крок 26
    _p(grid, 9, 1, w, type: StarType.binary, second: g); // крок 25
    _p(grid, 9, 2, r); // крок 24
    _p(grid, 9, 3, g); // крок 23
    _p(grid, 9, 5, r); // крок 22
    _p(grid, 9, 6, r, type: StarType.binaryReversed, second: b);
    _p(grid, 9, 7, w);

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
