import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Візничий · Рівень 5 · θ Махасім
// Сітка 8×10, шлях=20
// Рішення: A(0,4)r→JUMP→(2,2)binr→g→JUMP→(4,2)w→JUMP→(6,4)g
//           →JUMP→(8,2)r→(9,3)g→(9,4)r→(9,5)g→(9,6)w
//           →(9,7)b→(8,7)w→JUMP→(8,5)b→JUMP→(8,3)binr→w
//           →(9,2)b→(9,1)w→(9,0)g→(8,0)r→(8,1)bin→g
//           →(7,2)w→(7,1)g=B
class AurigaLevel5 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 5,
    totalLevels: 5,
    greekLetter: 'θ',
    starName: 'Махасім',
    starNameLatin: 'Mahasim',
    constellation: 'Візничий',
    goalText: 'Знайди шлях від А до В',
    pathLength: 20,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (0, 4),
    endPos: (7, 1),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, b);
    _p(grid, 0, 1, w);
    _p(grid, 0, 2, b);
    _p(grid, 0, 3, b);
    _p(grid, 0, 4, r); // A · крок 1
    _p(grid, 0, 5, w);
    _p(grid, 0, 6, b);
    _p(grid, 0, 7, g);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, r, type: StarType.binaryReversed, second: b);
    _p(grid, 1, 1, g, type: StarType.binary, second: r);
    _p(grid, 1, 2, b);
    _p(grid, 1, 4, b);
    _p(grid, 1, 5, w, type: StarType.binary, second: g);
    _p(grid, 1, 6, b, type: StarType.binaryReversed, second: w);
    _p(grid, 1, 7, g);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, b);
    _p(grid, 2, 1, g);
    _p(grid, 2, 2, w, type: StarType.binaryReversed, second: g); // крок 2
    _p(grid, 2, 5, b);
    _p(grid, 2, 6, b);
    _p(grid, 2, 7, g);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 1, w, type: StarType.binaryReversed, second: g);
    _p(grid, 3, 4, r, type: StarType.binaryReversed, second: b);
    _p(grid, 3, 6, r, type: StarType.binaryReversed, second: b);
    _p(grid, 3, 7, g);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 1, w);
    _p(grid, 4, 2, w); // крок 3
    _p(grid, 4, 3, r);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, r);
    _p(grid, 5, 2, w);
    _p(grid, 5, 4, w);
    _p(grid, 5, 5, g);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, b);
    _p(grid, 6, 1, w);
    _p(grid, 6, 4, g); // крок 4
    _p(grid, 6, 6, g);
    _p(grid, 6, 7, r);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 1, g); // B · крок 20
    _p(grid, 7, 2, w); // крок 19
    _p(grid, 7, 6, r);
    _p(grid, 7, 7, g);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r); // крок 17
    _p(grid, 8, 1, g, type: StarType.binary, second: r); // крок 18
    _p(grid, 8, 2, r); // крок 5
    _p(grid, 8, 3, b, type: StarType.binaryReversed, second: w); // крок 13
    _p(grid, 8, 5, b); // крок 12
    _p(grid, 8, 7, w); // крок 11

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g); // крок 16
    _p(grid, 9, 1, w); // крок 15
    _p(grid, 9, 2, b); // крок 14
    _p(grid, 9, 3, g); // крок 6
    _p(grid, 9, 4, r); // крок 7
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
