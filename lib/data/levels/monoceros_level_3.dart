import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Єдиноріг · Рівень 3 · γ Гамма Єдин.
// Сітка 8×10, шлях=20
// Рішення: A(0,7)g→(1,7)binr→r→(2,6)g→(1,6)w→JUMP→(3,4)g
//           →JUMP→(5,2)r→JUMP→(5,0)g→JUMP→(7,0)r→(7,1)bin→g
//           →JUMP→(9,3)w→JUMP→(9,5)g→(8,4)w→(8,5)b→(7,6)w
//           →(7,7)binr→g→(8,7)r→(8,6)g→(7,5)r→(6,6)g→JUMP→(4,6)r=B
class MonocerosLevel3 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 3,
    totalLevels: 5,
    greekLetter: 'γ',
    starName: 'Гамма Єдин.',
    starNameLatin: 'Gamma Mon',
    constellation: 'Єдиноріг',
    goalText: 'Знайди шлях від А до В',
    pathLength: 20,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СЕРЕДНЬО',
    hint: 'БІНАРНА · ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (0, 7),
    endPos: (4, 6),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 1, b);
    _p(grid, 0, 2, b);
    _p(grid, 0, 3, b, type: StarType.binary, second: w);
    _p(grid, 0, 4, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 5, r, type: StarType.binary, second: b);
    _p(grid, 0, 6, b);
    _p(grid, 0, 7, g); // A · крок 1

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 1, b);
    _p(grid, 1, 2, w);
    _p(grid, 1, 4, r, type: StarType.binary, second: b);
    _p(grid, 1, 5, r);
    _p(grid, 1, 6, w); // крок 4
    _p(grid, 1, 7, r, type: StarType.binaryReversed, second: b); // крок 2

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 1, w);
    _p(grid, 2, 6, g); // крок 3
    _p(grid, 2, 7, w);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, b);
    _p(grid, 3, 1, b, type: StarType.binaryReversed, second: w);
    _p(grid, 3, 2, b);
    _p(grid, 3, 3, g);
    _p(grid, 3, 4, g); // крок 5
    _p(grid, 3, 5, g);
    _p(grid, 3, 6, r);
    _p(grid, 3, 7, g);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, g);
    _p(grid, 4, 1, b);
    _p(grid, 4, 2, b);
    _p(grid, 4, 4, b);
    _p(grid, 4, 6, r); // B · крок 20

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, g); // крок 7
    _p(grid, 5, 2, r); // крок 6
    _p(grid, 5, 4, b, type: StarType.binaryReversed, second: w);
    _p(grid, 5, 5, b);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 2, b);
    _p(grid, 6, 3, b);
    _p(grid, 6, 4, w);
    _p(grid, 6, 5, w);
    _p(grid, 6, 6, g); // крок 19

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, r); // крок 8
    _p(grid, 7, 1, w, type: StarType.binary, second: g); // крок 9
    _p(grid, 7, 5, r); // крок 18
    _p(grid, 7, 6, w); // крок 14
    _p(grid, 7, 7, g, type: StarType.binaryReversed, second: r); // крок 15

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r, type: StarType.binary, second: b);
    _p(grid, 8, 1, r);
    _p(grid, 8, 3, w);
    _p(grid, 8, 4, w); // крок 12
    _p(grid, 8, 5, b); // крок 13
    _p(grid, 8, 6, g); // крок 17
    _p(grid, 8, 7, r); // крок 16

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g);
    _p(grid, 9, 2, w);
    _p(grid, 9, 3, w); // крок 10
    _p(grid, 9, 5, g); // крок 11
    _p(grid, 9, 6, b);
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
