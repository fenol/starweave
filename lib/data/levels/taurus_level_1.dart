import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Телець · Рівень 1 · α Альдебаран
// Сітка 8×10, шлях=23
// Рішення: A(1,6)b→(0,6)w→(1,7)b→JUMP→(3,5)w→(4,5)g→(5,4)binr→r
//           →(4,3)g→(6,1)w→(5,1)g→(4,2)w→JUMP→(2,2)binr→b
//           →(3,3)w→(5,5)b→(6,5)w→(5,6)g→(5,7)bin→w
//           →JUMP→(7,5)binr→g→(8,6)w→(8,7)b→(7,6)w
//           →JUMP→(9,4)g→(9,3)w→(8,4)b=B
class TaurusLevel1 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 1,
    totalLevels: 9,
    greekLetter: 'α',
    starName: 'Альдебаран',
    starNameLatin: 'Aldebaran',
    constellation: 'Телець',
    goalText: 'Знайди шлях від А до В',
    pathLength: 23,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'БІНАРНА ЗІРКА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (1, 6),
    endPos: (8, 4),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, r);
    _p(grid, 0, 2, g);
    _p(grid, 0, 3, g);
    _p(grid, 0, 4, g, type: StarType.binary, second: r);
    _p(grid, 0, 5, b);
    _p(grid, 0, 6, w); // крок 2
    _p(grid, 0, 7, r);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, w, type: StarType.binary, second: g);
    _p(grid, 1, 2, b);
    _p(grid, 1, 5, r);
    _p(grid, 1, 6, b); // A · крок 1
    _p(grid, 1, 7, b); // крок 3

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, r, type: StarType.binary, second: b);
    _p(grid, 2, 1, r, type: StarType.binaryReversed, second: b);
    _p(grid, 2, 2, b, type: StarType.binaryReversed, second: w); // крок 11
    _p(grid, 2, 4, r);
    _p(grid, 2, 5, r);
    _p(grid, 2, 7, g, type: StarType.binary, second: r);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, b);
    _p(grid, 3, 3, w); // крок 12
    _p(grid, 3, 4, b);
    _p(grid, 3, 5, w); // крок 4
    _p(grid, 3, 6, b);
    _p(grid, 3, 7, r, type: StarType.binary, second: b);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 2, w); // крок 10
    _p(grid, 4, 3, g); // крок 7
    _p(grid, 4, 5, g); // крок 5
    _p(grid, 4, 7, g);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, g, type: StarType.binaryReversed, second: r);
    _p(grid, 5, 1, g); // крок 9
    _p(grid, 5, 4, g, type: StarType.binaryReversed, second: r); // крок 6
    _p(grid, 5, 5, b); // крок 13
    _p(grid, 5, 6, g); // крок 15
    _p(grid, 5, 7, b, type: StarType.binary, second: w); // крок 16

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, b);
    _p(grid, 6, 1, w); // крок 8
    _p(grid, 6, 2, w);
    _p(grid, 6, 5, w); // крок 14

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, w);
    _p(grid, 7, 1, w);
    _p(grid, 7, 2, w);
    _p(grid, 7, 4, w);
    _p(grid, 7, 5, g, type: StarType.binaryReversed, second: r); // крок 17
    _p(grid, 7, 6, w); // крок 20
    _p(grid, 7, 7, r);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 1, r);
    _p(grid, 8, 2, r);
    _p(grid, 8, 4, b); // B · крок 23
    _p(grid, 8, 6, w); // крок 18
    _p(grid, 8, 7, b); // крок 19

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g);
    _p(grid, 9, 1, g);
    _p(grid, 9, 2, w);
    _p(grid, 9, 3, w); // крок 22
    _p(grid, 9, 4, g); // крок 21
    _p(grid, 9, 7, w, type: StarType.binaryReversed, second: g);

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
