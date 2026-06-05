import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Телець · Рівень 2 · β Ельнат
// Сітка 8×10, шлях=21
// Рішення: A(8,7)g→(7,6)r→JUMP→(9,4)g→JUMP→(7,4)r→(7,3)g
//           →JUMP→(5,5)w→(4,5)bin→g→(4,6)r→JUMP→(2,6)binr→g
//           →(2,5)w→JUMP→(0,7)g→JUMP→(0,5)r→JUMP→(2,3)g
//           →(1,2)w→(1,3)b→(2,4)w→(3,5)b→(3,4)w→(4,3)b
//           →JUMP→(6,5)bin→w→(6,6)b=B
class TaurusLevel2 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 2,
    totalLevels: 9,
    greekLetter: 'β',
    starName: 'Ельнат',
    starNameLatin: 'Elnath',
    constellation: 'Телець',
    goalText: 'Знайди шлях від А до В',
    pathLength: 21,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'БІНАРНА ЗІРКА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (8, 7),
    endPos: (6, 6),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, w);
    _p(grid, 0, 1, r);
    _p(grid, 0, 2, r);
    _p(grid, 0, 3, r);
    _p(grid, 0, 4, r);
    _p(grid, 0, 5, r); // крок 12
    _p(grid, 0, 7, g); // крок 11

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, w);
    _p(grid, 1, 2, w); // крок 14
    _p(grid, 1, 3, b); // крок 15
    _p(grid, 1, 5, r, type: StarType.binary, second: b);
    _p(grid, 1, 7, g);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, g);
    _p(grid, 2, 1, r, type: StarType.binary, second: b);
    _p(grid, 2, 3, g); // крок 13
    _p(grid, 2, 4, w); // крок 16
    _p(grid, 2, 5, w); // крок 10
    _p(grid, 2, 6, g, type: StarType.binaryReversed, second: r); // крок 9

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, g);
    _p(grid, 3, 1, b);
    _p(grid, 3, 3, r);
    _p(grid, 3, 4, w); // крок 18
    _p(grid, 3, 5, b); // крок 17
    _p(grid, 3, 7, g);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, b);
    _p(grid, 4, 1, g);
    _p(grid, 4, 2, w);
    _p(grid, 4, 3, b); // крок 19
    _p(grid, 4, 4, r, type: StarType.binaryReversed, second: b);
    _p(grid, 4, 5, w, type: StarType.binary, second: g); // крок 7
    _p(grid, 4, 6, r); // крок 8
    _p(grid, 4, 7, r);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 1, b);
    _p(grid, 5, 5, w); // крок 6
    _p(grid, 5, 6, r, type: StarType.binaryReversed, second: b);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 2, b);
    _p(grid, 6, 3, b);
    _p(grid, 6, 5, b, type: StarType.binary, second: w); // крок 20
    _p(grid, 6, 6, b); // B · крок 21
    _p(grid, 6, 7, r, type: StarType.binaryReversed, second: b);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, w);
    _p(grid, 7, 1, g);
    _p(grid, 7, 3, g); // крок 5
    _p(grid, 7, 4, r); // крок 4
    _p(grid, 7, 6, r); // крок 2

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, b);
    _p(grid, 8, 1, b);
    _p(grid, 8, 3, b);
    _p(grid, 8, 7, g); // A · крок 1

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g, type: StarType.binaryReversed, second: r);
    _p(grid, 9, 1, r);
    _p(grid, 9, 3, g);
    _p(grid, 9, 4, g); // крок 3
    _p(grid, 9, 5, b);
    _p(grid, 9, 6, r);
    _p(grid, 9, 7, g, type: StarType.binary, second: r);

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
