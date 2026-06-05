import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Великий Пес · Рівень 5 · ε Адхара
// Сітка 8×10, шлях=22
// Рішення: A(0,2)g→JUMP→(2,2)w→JUMP→(4,2)g→JUMP→(6,4)w
//           →JUMP→(8,6)b→(9,5)bin→w→(9,4)b→(9,3)w→(9,2)g
//           →(9,1)w→(9,0)binr→g→(8,0)w→(8,1)g→(8,2)r
//           →JUMP→(8,4)g→(8,5)bin→r→(9,6)g→(9,7)r
//           →(8,7)binr→g→(7,7)r→(7,6)g→JUMP→(7,4)r=B
class CanisMajorLevel5 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 5,
    totalLevels: 6,
    greekLetter: 'ε',
    starName: 'Адхара',
    starNameLatin: 'Adhara',
    constellation: 'Великий Пес',
    goalText: 'Знайди шлях від А до В',
    pathLength: 22,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'БІНАРНА · ОБЕРНЕНА БІНАРНА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (0, 2),
    endPos: (7, 4),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, b);
    _p(grid, 0, 1, b);
    _p(grid, 0, 2, g); // A · крок 1
    _p(grid, 0, 4, b);
    _p(grid, 0, 5, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 6, r, type: StarType.binaryReversed, second: b);
    _p(grid, 0, 7, r);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, b);
    _p(grid, 1, 3, g, type: StarType.binary, second: r);
    _p(grid, 1, 4, r, type: StarType.binaryReversed, second: b);
    _p(grid, 1, 5, r);
    _p(grid, 1, 6, g);
    _p(grid, 1, 7, b);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, b);
    _p(grid, 2, 2, w); // крок 2
    _p(grid, 2, 3, b);
    _p(grid, 2, 4, b);
    _p(grid, 2, 5, g, type: StarType.binary, second: r);
    _p(grid, 2, 6, b);
    _p(grid, 2, 7, b);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, b);
    _p(grid, 3, 4, r);
    _p(grid, 3, 5, b);
    _p(grid, 3, 6, b, type: StarType.binary, second: w);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, r);
    _p(grid, 4, 1, r, type: StarType.binary, second: b);
    _p(grid, 4, 2, g); // крок 3
    _p(grid, 4, 5, b);
    _p(grid, 4, 7, r);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 1, w);
    _p(grid, 5, 2, b, type: StarType.binaryReversed, second: w);
    _p(grid, 5, 7, g);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 1, b);
    _p(grid, 6, 2, r);
    _p(grid, 6, 4, w); // крок 4
    _p(grid, 6, 7, g);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, b);
    _p(grid, 7, 1, r);
    _p(grid, 7, 3, w);
    _p(grid, 7, 4, r); // B · крок 22
    _p(grid, 7, 6, g); // крок 21
    _p(grid, 7, 7, r); // крок 20

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, w); // крок 12
    _p(grid, 8, 1, g); // крок 13
    _p(grid, 8, 2, r); // крок 14
    _p(grid, 8, 4, g); // крок 15
    _p(grid, 8, 5, r, type: StarType.binary, second: b); // крок 16
    _p(grid, 8, 6, b); // крок 5
    _p(grid, 8, 7, w, type: StarType.binaryReversed, second: g); // крок 19

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w, type: StarType.binaryReversed, second: g); // крок 11
    _p(grid, 9, 1, w); // крок 10
    _p(grid, 9, 2, g); // крок 9
    _p(grid, 9, 3, w); // крок 8
    _p(grid, 9, 4, b); // крок 7
    _p(grid, 9, 5, w, type: StarType.binary, second: g); // крок 6
    _p(grid, 9, 6, g); // крок 17
    _p(grid, 9, 7, r); // крок 18

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
