import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Кассіопея · Рівень 5 · ε Сегін · «Корона W»
// Сітка 8×10, шлях=20
// Рішення: A(5,7)w→(6,6)g→(5,6)w→(7,4)BIN(b)→(9,6)w→(8,7)g→(7,7)w→(8,6)b
//           →(7,5)w→(6,4)g→(5,3)w→(5,5)BIN(g)→(4,5)w→(6,3)b→(6,2)w
//           →(7,1)BIN(b)→(6,0)BIN(w)→(4,0)b→(4,1)w→(3,2)g=B
class CassiopeiaLevel5 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 5,
    totalLevels: 5,
    greekLetter: 'ε',
    starName: 'Сегін',
    starNameLatin: 'Segin',
    constellation: 'Кассіопея',
    goalText: 'Знайди шлях від А до В',
    pathLength: 20,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ВСІ ТИПИ БІНАРНИХ · УВАЖНО',
    grid: _buildGrid(),
    startPos: (5, 7),
    endPos: (3, 2),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, r, type: StarType.binary, second: b); // бінарна (пастка)
    _p(grid, 0, 1, r);
    _p(grid, 0, 2, w);
    _p(grid, 0, 3, r);
    _p(grid, 0, 5, b);
    _p(grid, 0, 6, g);
    _p(grid, 0, 7, w);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, b);
    _p(grid, 1, 1, b);
    _p(grid, 1, 2, b);
    _p(grid, 1, 3, b);
    _p(grid, 1, 4, b);
    _p(grid, 1, 5, b, type: StarType.binary, second: w); // бінарна (пастка)
    _p(grid, 1, 6, b, type: StarType.binary, second: w); // бінарна (пастка)
    _p(grid, 1, 7, w, type: StarType.binary, second: g); // бінарна (пастка)

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, b);
    _p(grid, 2, 2, b);
    _p(grid, 2, 3, w);
    _p(grid, 2, 6, g);
    _p(grid, 2, 7, r);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, r);
    _p(grid, 3, 2, g); // B
    _p(grid, 3, 7, b);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, b); // крок 18
    _p(grid, 4, 1, w); // крок 19
    _p(grid, 4, 5, w); // крок 13

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 2, w); // фон
    _p(grid, 5, 3, w); // крок 11
    _p(grid, 5, 5, g, type: StarType.binary, second: r); // бінарна крок 12
    _p(grid, 5, 6, w); // крок 3
    _p(grid, 5, 7, w); // A

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, w, type: StarType.binary, second: g); // бінарна крок 17
    _p(grid, 6, 1, r);
    _p(grid, 6, 2, w); // крок 15
    _p(grid, 6, 3, b); // крок 14
    _p(grid, 6, 4, g); // крок 10
    _p(grid, 6, 6, g); // крок 2

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, r);
    _p(grid, 7, 1, r, type: StarType.binary, second: b); // бінарна крок 16
    _p(grid, 7, 4, b, type: StarType.binary, second: w); // бінарна крок 4
    _p(grid, 7, 5, w); // крок 9
    _p(grid, 7, 7, w); // крок 7

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r, type: StarType.binary, second: b); // бінарна (пастка)
    _p(grid, 8, 1, b);
    _p(grid, 8, 2, b);
    _p(grid, 8, 4, r);
    _p(grid, 8, 6, b); // крок 8
    _p(grid, 8, 7, g); // крок 6

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w, type: StarType.binary, second: g); // бінарна (пастка)
    _p(grid, 9, 1, w);
    _p(grid, 9, 2, r);
    _p(grid, 9, 3, r);
    _p(grid, 9, 4, r);
    _p(grid, 9, 5, g);
    _p(grid, 9, 6, w); // крок 5
    _p(grid, 9, 7, r);

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
