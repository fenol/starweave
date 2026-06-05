import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Великий Пес · Рівень 4 · δ Везен
// Сітка 8×10, шлях=21
// Рішення: A(4,0)w→JUMP→(4,2)b→JUMP→(6,4)w→JUMP→(8,6)g
//           →(7,7)r→(6,7)g→(5,7)bin→w→(4,7)binr→b
//           →(3,7)w→(2,7)b→(1,7)w→(0,7)g→(0,6)bin→w
//           →(1,6)b→(2,6)w→(3,6)binr→g→JUMP→(5,6)r
//           →JUMP→(7,6)g→(8,7)w→(9,7)b→(9,6)w=B
class CanisMajorLevel4 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 4,
    totalLevels: 6,
    greekLetter: 'δ',
    starName: 'Везен',
    starNameLatin: 'Wezen',
    constellation: 'Великий Пес',
    goalText: 'Знайди шлях від А до В',
    pathLength: 21,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНІШЕ',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (4, 0),
    endPos: (9, 6),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, g);
    _p(grid, 0, 1, g);
    _p(grid, 0, 2, b);
    _p(grid, 0, 3, w, type: StarType.binaryReversed, second: g);
    _p(grid, 0, 6, b, type: StarType.binary, second: w); // крок 13
    _p(grid, 0, 7, g); // крок 12

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, w);
    _p(grid, 1, 1, r);
    _p(grid, 1, 2, b);
    _p(grid, 1, 6, b); // крок 14
    _p(grid, 1, 7, w); // крок 11

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, r, type: StarType.binary, second: b);
    _p(grid, 2, 1, w);
    _p(grid, 2, 2, g, type: StarType.binaryReversed, second: r);
    _p(grid, 2, 5, r);
    _p(grid, 2, 6, w); // крок 15
    _p(grid, 2, 7, b); // крок 10

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, g);
    _p(grid, 3, 1, b);
    _p(grid, 3, 2, b);
    _p(grid, 3, 4, r);
    _p(grid, 3, 6, g, type: StarType.binaryReversed, second: r); // крок 16
    _p(grid, 3, 7, w); // крок 9

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, w); // A · крок 1
    _p(grid, 4, 2, b); // крок 2
    _p(grid, 4, 5, b);
    _p(grid, 4, 7, b, type: StarType.binaryReversed, second: w); // крок 8

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 1, r, type: StarType.binary, second: b);
    _p(grid, 5, 4, b);
    _p(grid, 5, 5, b, type: StarType.binaryReversed, second: w);
    _p(grid, 5, 6, r); // крок 17
    _p(grid, 5, 7, b, type: StarType.binary, second: w); // крок 7

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, r);
    _p(grid, 6, 1, b, type: StarType.binaryReversed, second: w);
    _p(grid, 6, 2, r);
    _p(grid, 6, 3, w);
    _p(grid, 6, 4, w); // крок 3
    _p(grid, 6, 5, b);
    _p(grid, 6, 7, g); // крок 6

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, b);
    _p(grid, 7, 2, w);
    _p(grid, 7, 4, r);
    _p(grid, 7, 6, g); // крок 18
    _p(grid, 7, 7, r); // крок 5

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, w);
    _p(grid, 8, 3, w);
    _p(grid, 8, 4, w);
    _p(grid, 8, 5, b);
    _p(grid, 8, 6, g); // крок 4
    _p(grid, 8, 7, w); // крок 19

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g, type: StarType.binaryReversed, second: r);
    _p(grid, 9, 1, w);
    _p(grid, 9, 2, b);
    _p(grid, 9, 3, b);
    _p(grid, 9, 4, g, type: StarType.binary, second: r); // пастка (помилкове path=7 у CSV)
    _p(grid, 9, 5, w);
    _p(grid, 9, 6, w); // B · крок 21
    _p(grid, 9, 7, b); // крок 20

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
