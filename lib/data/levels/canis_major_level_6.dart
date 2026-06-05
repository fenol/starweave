import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Великий Пес · Рівень 6 · η Алюдра
// Сітка 8×10, шлях=23
// Рішення: A(2,0)w→JUMP→(0,2)g→JUMP→(2,4)bin→r→JUMP→(4,6)binr→g
//           →(3,7)r→(2,7)g→(1,7)r→(0,7)g→(0,6)binr→r
//           →(1,6)g→(2,6)r→(3,6)g→(4,7)w→(5,7)bin→g
//           →(6,7)r→(7,7)g→(8,7)w→(9,7)b→(9,6)w
//           →(8,6)g→(7,6)binr→r→(6,6)g→(5,6)r=B
class CanisMajorLevel6 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 6,
    totalLevels: 6,
    greekLetter: 'η',
    starName: 'Алюдра',
    starNameLatin: 'Aludra',
    constellation: 'Великий Пес',
    goalText: 'Знайди шлях від А до В',
    pathLength: 23,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'БІНАРНА · ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (2, 0),
    endPos: (5, 6),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, w);
    _p(grid, 0, 2, g); // крок 2
    _p(grid, 0, 3, b);
    _p(grid, 0, 4, r);
    _p(grid, 0, 6, g, type: StarType.binaryReversed, second: r); // крок 9
    _p(grid, 0, 7, g); // крок 8

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 2, g);
    _p(grid, 1, 5, b);
    _p(grid, 1, 6, g); // крок 10
    _p(grid, 1, 7, r); // крок 7

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, w); // A · крок 1
    _p(grid, 2, 3, g);
    _p(grid, 2, 4, r, type: StarType.binary, second: b); // крок 3
    _p(grid, 2, 5, b);
    _p(grid, 2, 6, r); // крок 11
    _p(grid, 2, 7, g); // крок 6

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 1, r);
    _p(grid, 3, 2, r, type: StarType.binaryReversed, second: b);
    _p(grid, 3, 3, g, type: StarType.binaryReversed, second: r);
    _p(grid, 3, 6, g); // крок 12
    _p(grid, 3, 7, r); // крок 5

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 2, g, type: StarType.binaryReversed, second: r);
    _p(grid, 4, 3, r);
    _p(grid, 4, 6, w, type: StarType.binaryReversed, second: g); // крок 4
    _p(grid, 4, 7, w); // крок 13

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, r);
    _p(grid, 5, 1, b);
    _p(grid, 5, 2, g);
    _p(grid, 5, 3, w);
    _p(grid, 5, 4, b, type: StarType.binaryReversed, second: w);
    _p(grid, 5, 6, r); // B · крок 23
    _p(grid, 5, 7, g, type: StarType.binary, second: r); // крок 14

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, g);
    _p(grid, 6, 1, b);
    _p(grid, 6, 2, w);
    _p(grid, 6, 6, g); // крок 22
    _p(grid, 6, 7, r); // крок 15

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, g, type: StarType.binary, second: r);
    _p(grid, 7, 1, b, type: StarType.binaryReversed, second: w);
    _p(grid, 7, 2, r);
    _p(grid, 7, 3, b);
    _p(grid, 7, 4, w);
    _p(grid, 7, 5, b);
    _p(grid, 7, 6, g, type: StarType.binaryReversed, second: r); // крок 21
    _p(grid, 7, 7, g); // крок 16

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 1, b);
    _p(grid, 8, 2, w);
    _p(grid, 8, 3, g, type: StarType.binaryReversed, second: r);
    _p(grid, 8, 6, g); // крок 20
    _p(grid, 8, 7, w); // крок 17

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g);
    _p(grid, 9, 1, r, type: StarType.binaryReversed, second: b);
    _p(grid, 9, 2, g);
    _p(grid, 9, 5, b);
    _p(grid, 9, 6, w); // крок 19
    _p(grid, 9, 7, b); // крок 18

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
