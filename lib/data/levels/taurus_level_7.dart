import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Телець · Рівень 7 · η Альціона
// Сітка 8×10, шлях=22
// Рішення: A(9,2)b→JUMP→(7,4)w→(7,3)g→(6,3)w→(6,2)b
//           →JUMP→(6,0)w→(5,1)g→(4,0)binr→r→(4,1)binr→g
//           →(3,2)r→(2,2)g→(3,3)r→(2,4)binr→g→(1,3)r
//           →(1,2)g→JUMP→(3,4)r→JUMP→(5,6)g→(4,7)binr→r
//           →JUMP→(6,7)g→(8,5)r→(7,5)g→(6,5)r=B
class TaurusLevel7 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 7,
    totalLevels: 9,
    greekLetter: 'η',
    starName: 'Альціона',
    starNameLatin: 'Alcyone',
    constellation: 'Телець',
    goalText: 'Знайди шлях від А до В',
    pathLength: 22,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'БІНАРНА · ОБЕРНЕНА БІНАРНА',
    grid: _buildGrid(),
    startPos: (9, 2),
    endPos: (6, 5),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 1, g);
    _p(grid, 0, 2, b, type: StarType.binary, second: w);
    _p(grid, 0, 3, b, type: StarType.binary, second: w);
    _p(grid, 0, 4, w);
    _p(grid, 0, 5, r);
    _p(grid, 0, 6, w, type: StarType.binary, second: g);
    _p(grid, 0, 7, w, type: StarType.binary, second: g);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 1, g);
    _p(grid, 1, 2, g); // крок 15
    _p(grid, 1, 3, r); // крок 14
    _p(grid, 1, 4, r);
    _p(grid, 1, 5, w);
    _p(grid, 1, 6, g);
    _p(grid, 1, 7, w);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, b);
    _p(grid, 2, 1, b);
    _p(grid, 2, 2, g); // крок 11
    _p(grid, 2, 4, w, type: StarType.binaryReversed, second: g); // крок 13
    _p(grid, 2, 5, w);
    _p(grid, 2, 6, b);
    _p(grid, 2, 7, w);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, g);
    _p(grid, 3, 1, b);
    _p(grid, 3, 2, r); // крок 10
    _p(grid, 3, 3, r); // крок 12
    _p(grid, 3, 4, r); // крок 16
    _p(grid, 3, 6, r);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, g, type: StarType.binaryReversed, second: r); // крок 8
    _p(grid, 4, 1, g, type: StarType.binaryReversed, second: r); // крок 9
    _p(grid, 4, 3, r);
    _p(grid, 4, 7, r, type: StarType.binaryReversed, second: b); // крок 18

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 1, g); // крок 7
    _p(grid, 5, 2, b);
    _p(grid, 5, 3, r, type: StarType.binary, second: b);
    _p(grid, 5, 4, r);
    _p(grid, 5, 5, g);
    _p(grid, 5, 6, g); // крок 17

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, w); // крок 6
    _p(grid, 6, 2, b); // крок 5
    _p(grid, 6, 3, w); // крок 4
    _p(grid, 6, 5, r); // B · крок 22
    _p(grid, 6, 6, b);
    _p(grid, 6, 7, g); // крок 19

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 1, r);
    _p(grid, 7, 3, g); // крок 3
    _p(grid, 7, 4, w); // крок 2
    _p(grid, 7, 5, g); // крок 21

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 1, b, type: StarType.binaryReversed, second: w);
    _p(grid, 8, 2, r);
    _p(grid, 8, 5, r); // крок 20
    _p(grid, 8, 7, r);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, b);
    _p(grid, 9, 2, b); // A · крок 1
    _p(grid, 9, 4, g);
    _p(grid, 9, 5, b);
    _p(grid, 9, 7, b, type: StarType.binary, second: w);

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
