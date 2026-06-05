import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Візничий · Рівень 4 · ζ Садатоні
// Сітка 8×10, шлях=21
// Рішення: A(8,1)g→JUMP→(6,3)r→JUMP→(6,5)g→JUMP→(6,7)binr→w
//           →(7,7)b→(8,7)binr→w→(9,7)bin→b→(9,6)w
//           →JUMP→(7,6)b→JUMP→(5,6)w→(4,7)g→(3,7)w
//           →(2,7)g→(1,7)binr→r→(0,7)g→(0,6)r
//           →(1,6)g→(2,6)r→(3,6)g→(4,6)w→(5,7)g=B
class AurigaLevel4 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 4,
    totalLevels: 5,
    greekLetter: 'ζ',
    starName: 'Садатоні',
    starNameLatin: 'Sadatoni',
    constellation: 'Візничий',
    goalText: 'Знайди шлях від А до В',
    pathLength: 21,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНІШЕ',
    hint: 'БІНАРНА · ОБЕРНЕНА БІНАРНА',
    grid: _buildGrid(),
    startPos: (8, 1),
    endPos: (5, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 2, w);
    _p(grid, 0, 3, r);
    _p(grid, 0, 4, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 5, w);
    _p(grid, 0, 6, r); // крок 16
    _p(grid, 0, 7, g); // крок 15

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, g, type: StarType.binaryReversed, second: r);
    _p(grid, 1, 1, r, type: StarType.binary, second: b);
    _p(grid, 1, 2, b);
    _p(grid, 1, 3, b);
    _p(grid, 1, 5, b);
    _p(grid, 1, 6, g); // крок 17
    _p(grid, 1, 7, r, type: StarType.binaryReversed, second: b); // крок 14

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, b);
    _p(grid, 2, 2, r);
    _p(grid, 2, 3, b, type: StarType.binary, second: w);
    _p(grid, 2, 6, r); // крок 18
    _p(grid, 2, 7, g); // крок 13

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, r);
    _p(grid, 3, 2, b, type: StarType.binary, second: w);
    _p(grid, 3, 3, b);
    _p(grid, 3, 5, b);
    _p(grid, 3, 6, g); // крок 19
    _p(grid, 3, 7, w); // крок 12

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 1, b);
    _p(grid, 4, 3, b);
    _p(grid, 4, 4, w);
    _p(grid, 4, 6, w); // крок 20
    _p(grid, 4, 7, g); // крок 11

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, b);
    _p(grid, 5, 2, r);
    _p(grid, 5, 3, w);
    _p(grid, 5, 5, g, type: StarType.binary, second: r);
    _p(grid, 5, 6, w); // крок 10
    _p(grid, 5, 7, g); // B · крок 21

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, b, type: StarType.binary, second: w);
    _p(grid, 6, 2, r);
    _p(grid, 6, 3, r); // крок 2
    _p(grid, 6, 5, g); // крок 3
    _p(grid, 6, 7, b, type: StarType.binaryReversed, second: w); // крок 4

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 1, b);
    _p(grid, 7, 4, r, type: StarType.binaryReversed, second: b);
    _p(grid, 7, 6, b); // крок 9
    _p(grid, 7, 7, b); // крок 5

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, g);
    _p(grid, 8, 1, g); // A · крок 1
    _p(grid, 8, 3, w);
    _p(grid, 8, 4, b);
    _p(grid, 8, 5, r);
    _p(grid, 8, 7, w, type: StarType.binaryReversed, second: g); // крок 6

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w);
    _p(grid, 9, 1, r);
    _p(grid, 9, 2, r);
    _p(grid, 9, 3, r);
    _p(grid, 9, 5, b);
    _p(grid, 9, 6, w); // крок 8
    _p(grid, 9, 7, r, type: StarType.binary, second: b); // крок 7

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
