import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Великий Пес · Рівень 3 · γ Муліфейн (дані з furud)
// Сітка 8×10, шлях=23
// Рішення: A(6,4)w→(5,5)g→(4,6)r→(3,6)g→(3,7)w→JUMP→(1,5)b
//           →(0,5)w→(0,6)binr→g→(0,7)w→(1,6)binr→b
//           →(2,7)w→JUMP→(2,5)bin→b→JUMP→(4,5)w→JUMP→(4,3)g
//           →(3,4)r→(2,4)g→(1,4)bin→r→JUMP→(1,2)g
//           →(0,3)r→(0,2)g→JUMP→(2,0)r→JUMP→(4,2)binr→g
//           →JUMP→(6,2)w=B
class CanisMajorLevel3 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 3,
    totalLevels: 6,
    greekLetter: 'γ',
    starName: 'Муліфейн',
    starNameLatin: 'Muliphein',
    constellation: 'Великий Пес',
    goalText: 'Знайди шлях від А до В',
    pathLength: 23,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНІШЕ',
    hint: 'БІНАРНА · ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (6, 4),
    endPos: (6, 2),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, w);
    _p(grid, 0, 2, g); // крок 20
    _p(grid, 0, 3, r); // крок 19
    _p(grid, 0, 5, w); // крок 7
    _p(grid, 0, 6, g, type: StarType.binaryReversed, second: r); // крок 8
    _p(grid, 0, 7, w); // крок 9

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, w);
    _p(grid, 1, 2, g); // крок 18
    _p(grid, 1, 4, g, type: StarType.binary, second: r); // крок 17
    _p(grid, 1, 5, b); // крок 6
    _p(grid, 1, 6, b, type: StarType.binaryReversed, second: w); // крок 10

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, r); // крок 21
    _p(grid, 2, 4, g); // крок 16
    _p(grid, 2, 5, r, type: StarType.binary, second: b); // крок 12
    _p(grid, 2, 7, w); // крок 11

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, r);
    _p(grid, 3, 4, r); // крок 15
    _p(grid, 3, 6, g); // крок 4
    _p(grid, 3, 7, w); // крок 5

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, b);
    _p(grid, 4, 2, g, type: StarType.binaryReversed, second: r); // крок 22
    _p(grid, 4, 3, g); // крок 14
    _p(grid, 4, 5, w); // крок 13
    _p(grid, 4, 6, r); // крок 3

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, w, type: StarType.binaryReversed, second: g);
    _p(grid, 5, 1, b);
    _p(grid, 5, 5, g); // крок 2
    _p(grid, 5, 6, w);
    _p(grid, 5, 7, w);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, r);
    _p(grid, 6, 1, b);
    _p(grid, 6, 2, w); // B · крок 23
    _p(grid, 6, 4, w); // A · крок 1
    _p(grid, 6, 7, w);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, b);
    _p(grid, 7, 1, b, type: StarType.binaryReversed, second: w);
    _p(grid, 7, 2, w, type: StarType.binary, second: g);
    _p(grid, 7, 3, w);
    _p(grid, 7, 4, w);
    _p(grid, 7, 5, g);
    _p(grid, 7, 6, r, type: StarType.binaryReversed, second: b);
    _p(grid, 7, 7, b);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, g);
    _p(grid, 8, 1, g);
    _p(grid, 8, 3, w);
    _p(grid, 8, 4, w);
    _p(grid, 8, 5, r);
    _p(grid, 8, 7, r, type: StarType.binary, second: b);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w, type: StarType.binary, second: g);
    _p(grid, 9, 1, b);
    _p(grid, 9, 2, g);
    _p(grid, 9, 3, b, type: StarType.binary, second: w);
    _p(grid, 9, 4, g, type: StarType.binaryReversed, second: r);
    _p(grid, 9, 5, g);
    _p(grid, 9, 6, g);
    _p(grid, 9, 7, b, type: StarType.binaryReversed, second: w);

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
