import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Єдиноріг · Рівень 5 · ε Єпсілон Єдин.
// Сітка 8×10, шлях=22
// Рішення: A(6,2)r→(5,2)g→JUMP→(3,2)w→JUMP→(3,4)g→(2,4)w
//           →JUMP→(2,2)b→JUMP→(2,0)w→(3,1)bin→g→(3,0)r→(4,0)g
//           →JUMP→(6,0)w→(5,1)b→(6,1)w→(7,2)g→(8,1)binr→r
//           →(9,2)g→(8,3)binr→r→JUMP→(6,3)g→JUMP→(8,5)bin→r
//           →(7,6)g→(6,5)r→JUMP→(4,7)g=B
class MonocerosLevel5 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 5,
    totalLevels: 5,
    greekLetter: 'ε',
    starName: 'Єпсілон Єдин.',
    starNameLatin: 'Eps Mon',
    constellation: 'Єдиноріг',
    goalText: 'Знайди шлях від А до В',
    pathLength: 22,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'БІНАРНА · ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (6, 2),
    endPos: (4, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, r);
    _p(grid, 0, 1, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 3, b, type: StarType.binaryReversed, second: w);
    _p(grid, 0, 4, w, type: StarType.binary, second: g);
    _p(grid, 0, 6, b);
    _p(grid, 0, 7, r);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 1, r);
    _p(grid, 1, 2, b);
    _p(grid, 1, 3, b);
    _p(grid, 1, 5, b);
    _p(grid, 1, 6, b);
    _p(grid, 1, 7, r, type: StarType.binaryReversed, second: b);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, w); // крок 7
    _p(grid, 2, 2, b); // крок 6
    _p(grid, 2, 4, w); // крок 5
    _p(grid, 2, 6, b, type: StarType.binary, second: w);
    _p(grid, 2, 7, w);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, r); // крок 9
    _p(grid, 3, 1, w, type: StarType.binary, second: g); // крок 8
    _p(grid, 3, 2, w); // крок 3
    _p(grid, 3, 4, g); // крок 4
    _p(grid, 3, 5, r);
    _p(grid, 3, 6, b);
    _p(grid, 3, 7, g);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, g); // крок 10
    _p(grid, 4, 3, g);
    _p(grid, 4, 6, b);
    _p(grid, 4, 7, g); // B · крок 22

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 1, b); // крок 12
    _p(grid, 5, 2, g); // крок 2
    _p(grid, 5, 5, b);
    _p(grid, 5, 7, b, type: StarType.binaryReversed, second: w);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, w); // крок 11
    _p(grid, 6, 1, w); // крок 13
    _p(grid, 6, 2, r); // A · крок 1
    _p(grid, 6, 3, g); // крок 18
    _p(grid, 6, 5, r); // крок 21
    _p(grid, 6, 7, w);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, w);
    _p(grid, 7, 1, w);
    _p(grid, 7, 2, g); // крок 14
    _p(grid, 7, 6, g); // крок 20
    _p(grid, 7, 7, r, type: StarType.binary, second: b);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, b);
    _p(grid, 8, 1, r, type: StarType.binaryReversed, second: b); // крок 15
    _p(grid, 8, 3, r, type: StarType.binaryReversed, second: b); // крок 17
    _p(grid, 8, 4, r);
    _p(grid, 8, 5, g, type: StarType.binary, second: r); // крок 19
    _p(grid, 8, 6, r, type: StarType.binaryReversed, second: b);
    _p(grid, 8, 7, b);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 1, r);
    _p(grid, 9, 2, g); // крок 16
    _p(grid, 9, 3, b);
    _p(grid, 9, 4, r);
    _p(grid, 9, 5, r);
    _p(grid, 9, 7, g);

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
