import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Великий Пес · Рівень 2 · β Мірзам
// Сітка 8×10, шлях=20
// Рішення: A(0,6)g→JUMP→(2,4)r→JUMP→(4,6)g→JUMP→(6,4)r
//           →JUMP→(8,6)g→(9,5)w→(9,4)bin→g→(9,3)r→(9,2)g
//           →(9,1)w→(9,0)g→(8,0)w→JUMP→(8,2)b→JUMP→(8,4)w
//           →(8,5)g→(9,6)r→(9,7)g→(8,7)binr→r→(7,7)binr→g
//           →(7,6)r=B
class CanisMajorLevel2 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 2,
    totalLevels: 6,
    greekLetter: 'β',
    starName: 'Мірзам',
    starNameLatin: 'Mirzam',
    constellation: 'Великий Пес',
    goalText: 'Знайди шлях від А до В',
    pathLength: 20,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (0, 6),
    endPos: (7, 6),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, w, type: StarType.binary, second: g);
    _p(grid, 0, 1, w, type: StarType.binaryReversed, second: g);
    _p(grid, 0, 2, r);
    _p(grid, 0, 3, g, type: StarType.binary, second: r);
    _p(grid, 0, 4, b);
    _p(grid, 0, 6, g); // A · крок 1
    _p(grid, 0, 7, g);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, b);
    _p(grid, 1, 1, w);
    _p(grid, 1, 2, g);
    _p(grid, 1, 3, g, type: StarType.binaryReversed, second: r);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, g);
    _p(grid, 2, 1, w);
    _p(grid, 2, 2, w);
    _p(grid, 2, 3, r);
    _p(grid, 2, 4, r); // крок 2
    _p(grid, 2, 6, r);
    _p(grid, 2, 7, w);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, w);
    _p(grid, 3, 1, w, type: StarType.binaryReversed, second: g);
    _p(grid, 3, 2, w);
    _p(grid, 3, 4, w);
    _p(grid, 3, 6, b);
    _p(grid, 3, 7, g, type: StarType.binaryReversed, second: r);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, g);
    _p(grid, 4, 1, w);
    _p(grid, 4, 2, r);
    _p(grid, 4, 6, g); // крок 3

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, r);
    _p(grid, 5, 2, r);
    _p(grid, 5, 3, w);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, r, type: StarType.binaryReversed, second: b);
    _p(grid, 6, 2, r);
    _p(grid, 6, 3, b);
    _p(grid, 6, 4, r); // крок 4
    _p(grid, 6, 5, r);
    _p(grid, 6, 7, w);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, g);
    _p(grid, 7, 2, b);
    _p(grid, 7, 4, b);
    _p(grid, 7, 6, r); // B · крок 20
    _p(grid, 7, 7, w, type: StarType.binaryReversed, second: g); // крок 19

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, w); // крок 12
    _p(grid, 8, 2, b); // крок 13
    _p(grid, 8, 4, w); // крок 14
    _p(grid, 8, 5, g); // крок 15
    _p(grid, 8, 6, g); // крок 5
    _p(grid, 8, 7, g, type: StarType.binaryReversed, second: r); // крок 18

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g); // крок 11
    _p(grid, 9, 1, w); // крок 10
    _p(grid, 9, 2, g); // крок 9
    _p(grid, 9, 3, r); // крок 8
    _p(grid, 9, 4, g, type: StarType.binary, second: r); // крок 7
    _p(grid, 9, 5, w); // крок 6
    _p(grid, 9, 6, r); // крок 16
    _p(grid, 9, 7, g); // крок 17

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
