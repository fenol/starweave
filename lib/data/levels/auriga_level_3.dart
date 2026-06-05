import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Візничий · Рівень 3 · ε Альмааз
// Сітка 8×10, шлях=22
// Рішення: A(0,4)r→JUMP→(2,2)g→JUMP→(4,4)binr→r→JUMP→(6,4)g
//           →JUMP→(8,2)binr→r→(9,3)g→(9,4)w→(9,5)g→(9,6)w
//           →(9,7)b→(8,7)binr→w→(8,6)b→(8,5)w→(8,4)b
//           →(8,3)w→(9,2)g→(9,1)w→(9,0)g→(8,0)w→(8,1)b
//           →(7,2)binr→w→JUMP→(7,4)b=B
class AurigaLevel3 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 3,
    totalLevels: 5,
    greekLetter: 'ε',
    starName: 'Альмааз',
    starNameLatin: 'Almaaz',
    constellation: 'Візничий',
    goalText: 'Знайди шлях від А до В',
    pathLength: 22,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНІШЕ',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (0, 4),
    endPos: (7, 4),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 1, w);
    _p(grid, 0, 2, b);
    _p(grid, 0, 3, r);
    _p(grid, 0, 4, r); // A · крок 1
    _p(grid, 0, 5, b);
    _p(grid, 0, 6, r, type: StarType.binary, second: b);
    _p(grid, 0, 7, r);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, r);
    _p(grid, 1, 5, r);
    _p(grid, 1, 6, g, type: StarType.binary, second: r);
    _p(grid, 1, 7, w);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, g);
    _p(grid, 2, 1, r, type: StarType.binary, second: b);
    _p(grid, 2, 2, g); // крок 2
    _p(grid, 2, 3, r);
    _p(grid, 2, 4, b, type: StarType.binary, second: w);
    _p(grid, 2, 7, b, type: StarType.binary, second: w);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, g);
    _p(grid, 3, 2, r);
    _p(grid, 3, 4, r);
    _p(grid, 3, 5, r, type: StarType.binaryReversed, second: b);
    _p(grid, 3, 7, g);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, r);
    _p(grid, 4, 1, b);
    _p(grid, 4, 2, b);
    _p(grid, 4, 3, b);
    _p(grid, 4, 4, g, type: StarType.binaryReversed, second: r); // крок 3
    _p(grid, 4, 5, b, type: StarType.binary, second: w);
    _p(grid, 4, 6, w, type: StarType.binaryReversed, second: g);
    _p(grid, 4, 7, b);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, b);
    _p(grid, 5, 2, r);
    _p(grid, 5, 6, b);
    _p(grid, 5, 7, r);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, b);
    _p(grid, 6, 1, b);
    _p(grid, 6, 4, g); // крок 4
    _p(grid, 6, 5, b);
    _p(grid, 6, 7, r);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 2, w, type: StarType.binaryReversed, second: g); // крок 21
    _p(grid, 7, 4, b); // B · крок 22
    _p(grid, 7, 5, b);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, w); // крок 19
    _p(grid, 8, 1, b); // крок 20
    _p(grid, 8, 2, g, type: StarType.binaryReversed, second: r); // крок 5
    _p(grid, 8, 3, w); // крок 15
    _p(grid, 8, 4, b); // крок 14
    _p(grid, 8, 5, w); // крок 13
    _p(grid, 8, 6, b); // крок 12
    _p(grid, 8, 7, w, type: StarType.binaryReversed, second: g); // крок 11

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g); // крок 18
    _p(grid, 9, 1, w); // крок 17
    _p(grid, 9, 2, g); // крок 16
    _p(grid, 9, 3, g); // крок 6
    _p(grid, 9, 4, w); // крок 7
    _p(grid, 9, 5, g); // крок 8
    _p(grid, 9, 6, w); // крок 9
    _p(grid, 9, 7, b); // крок 10

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
