import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Єдиноріг · Рівень 4 · δ Дельта Єдин.
// Сітка 8×10, шлях=21
// Рішення: A(5,5)g→(6,4)r→(7,4)g→(8,5)w→(7,6)b→(7,7)w→(6,6)g
//           →(6,7)w→JUMP→(4,7)binr→b→(3,6)w→(2,5)b→JUMP→(4,5)binr→w
//           →JUMP→(4,3)bin→w→JUMP→(2,3)b→JUMP→(4,1)binr→g
//           →JUMP→(6,1)r→(7,1)g→JUMP→(9,3)r→(9,2)g→(9,1)w→(8,1)g=B
class MonocerosLevel4 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 4,
    totalLevels: 5,
    greekLetter: 'δ',
    starName: 'Дельта Єдин.',
    starNameLatin: 'Delta Mon',
    constellation: 'Єдиноріг',
    goalText: 'Знайди шлях від А до В',
    pathLength: 21,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СЕРЕДНЬО',
    hint: 'БІНАРНА · ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (5, 5),
    endPos: (8, 1),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, r);
    _p(grid, 0, 1, r);
    _p(grid, 0, 2, b);
    _p(grid, 0, 3, r);
    _p(grid, 0, 4, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 6, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 7, w);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, w);
    _p(grid, 1, 1, r, type: StarType.binary, second: b);
    _p(grid, 1, 2, r);
    _p(grid, 1, 4, g);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, b);
    _p(grid, 2, 1, r);
    _p(grid, 2, 3, b, type: StarType.binary, second: w); // крок 14
    _p(grid, 2, 4, b);
    _p(grid, 2, 5, b); // крок 11
    _p(grid, 2, 6, b, type: StarType.binary, second: w);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, b);
    _p(grid, 3, 1, g);
    _p(grid, 3, 4, r);
    _p(grid, 3, 6, w); // крок 10
    _p(grid, 3, 7, r);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, b, type: StarType.binaryReversed, second: w);
    _p(grid, 4, 1, g, type: StarType.binaryReversed, second: r); // крок 15
    _p(grid, 4, 2, r);
    _p(grid, 4, 3, b); // крок 13
    _p(grid, 4, 5, w, type: StarType.binaryReversed, second: g); // крок 12
    _p(grid, 4, 7, r, type: StarType.binaryReversed, second: b); // крок 9

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, r, type: StarType.binary, second: b);
    _p(grid, 5, 2, b);
    _p(grid, 5, 3, b);
    _p(grid, 5, 5, g); // A · крок 1

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, r);
    _p(grid, 6, 1, r); // крок 16
    _p(grid, 6, 2, w);
    _p(grid, 6, 3, g);
    _p(grid, 6, 4, r); // крок 2
    _p(grid, 6, 6, g); // крок 7
    _p(grid, 6, 7, w); // крок 8

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, r);
    _p(grid, 7, 1, g); // крок 17
    _p(grid, 7, 2, b);
    _p(grid, 7, 4, g); // крок 3
    _p(grid, 7, 6, b); // крок 5
    _p(grid, 7, 7, w); // крок 6

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r, type: StarType.binary, second: b);
    _p(grid, 8, 1, g); // B · крок 21
    _p(grid, 8, 3, b);
    _p(grid, 8, 5, w); // крок 4
    _p(grid, 8, 7, r);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 1, w); // крок 20
    _p(grid, 9, 2, g); // крок 19
    _p(grid, 9, 3, r); // крок 18
    _p(grid, 9, 6, r);
    _p(grid, 9, 7, b);

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
