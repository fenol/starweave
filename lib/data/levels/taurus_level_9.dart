import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Телець · Рівень 9 · λ Лямбда Тельця
// Сітка 8×10, шлях=26
// Рішення: A(7,5)b→JUMP→(7,3)binr→w→(6,3)g→(5,2)w→(4,3)g
//           →(5,4)r→(6,4)binr→g→(5,5)r→(6,6)g→(5,6)r
//           →(4,7)g→(3,7)binr→w→JUMP→(1,7)b→(0,6)w
//           →JUMP→(0,4)b→(0,3)w→JUMP→(0,1)b→(1,0)bin→w
//           →(2,1)b→(1,2)binr→w→(1,3)b→(1,4)w→(1,5)b
//           →(2,6)bin→w→JUMP→(4,6)bin→g→JUMP→(4,4)w=B
class TaurusLevel9 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 9,
    totalLevels: 9,
    greekLetter: 'λ',
    starName: 'Лямбда Тельця',
    starNameLatin: 'Lambda Tau',
    constellation: 'Телець',
    goalText: 'Знайди шлях від А до В',
    pathLength: 26,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'БІНАРНА · ОБЕРНЕНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (7, 5),
    endPos: (4, 4),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, b);
    _p(grid, 0, 1, b); // крок 17
    _p(grid, 0, 3, w); // крок 16
    _p(grid, 0, 4, b); // крок 15
    _p(grid, 0, 6, w); // крок 14
    _p(grid, 0, 7, r, type: StarType.binaryReversed, second: b);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, b, type: StarType.binary, second: w); // крок 18
    _p(grid, 1, 2, w, type: StarType.binaryReversed, second: g); // крок 20
    _p(grid, 1, 3, b); // крок 21
    _p(grid, 1, 4, w); // крок 22
    _p(grid, 1, 5, b); // крок 23
    _p(grid, 1, 6, r, type: StarType.binaryReversed, second: b);
    _p(grid, 1, 7, b); // крок 13

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 1, b); // крок 19
    _p(grid, 2, 4, r);
    _p(grid, 2, 6, b, type: StarType.binary, second: w); // крок 24

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, r);
    _p(grid, 3, 1, g, type: StarType.binary, second: r);
    _p(grid, 3, 5, r);
    _p(grid, 3, 7, w, type: StarType.binaryReversed, second: g); // крок 12

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, g);
    _p(grid, 4, 3, g); // крок 5
    _p(grid, 4, 4, w); // B · крок 26
    _p(grid, 4, 6, w, type: StarType.binary, second: g); // крок 25
    _p(grid, 4, 7, g); // крок 11

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, w);
    _p(grid, 5, 1, w);
    _p(grid, 5, 2, w); // крок 4
    _p(grid, 5, 3, b);
    _p(grid, 5, 4, r); // крок 6
    _p(grid, 5, 5, r); // крок 8
    _p(grid, 5, 6, r); // крок 10

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, r, type: StarType.binaryReversed, second: b);
    _p(grid, 6, 3, g); // крок 3
    _p(grid, 6, 4, g, type: StarType.binaryReversed, second: r); // крок 7
    _p(grid, 6, 6, g); // крок 9

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, b);
    _p(grid, 7, 1, b);
    _p(grid, 7, 3, w, type: StarType.binaryReversed, second: g); // крок 2
    _p(grid, 7, 5, b); // A · крок 1
    _p(grid, 7, 7, g, type: StarType.binary, second: r);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r);
    _p(grid, 8, 1, r, type: StarType.binary, second: b);
    _p(grid, 8, 2, r);
    _p(grid, 8, 3, g, type: StarType.binaryReversed, second: r);
    _p(grid, 8, 4, b);
    _p(grid, 8, 6, g, type: StarType.binary, second: r);
    _p(grid, 8, 7, g, type: StarType.binary, second: r);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w);
    _p(grid, 9, 1, w);
    _p(grid, 9, 2, r);
    _p(grid, 9, 3, g);
    _p(grid, 9, 4, b, type: StarType.binary, second: w);
    _p(grid, 9, 5, b);
    _p(grid, 9, 6, r);
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
