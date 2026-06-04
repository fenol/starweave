import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Кассіопея · Рівень 4 · δ Рухба · «Хибна W»
// Сітка 8×10, шлях=18
// Рішення: A(4,2)r→(3,2)BIN(g)→(1,0)w→(1,2)g→(1,3)BIN(r)→(3,1)g→(5,1)r
//           →(4,0)g→(3,0)w→(5,2)b→(3,4)BIN(w)→(3,6)g→(4,6)r→(5,7)g
//           →(6,6)r→(7,5)g→(7,7)r→(8,7)g=B
class CassiopeiaLevel4 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 4,
    totalLevels: 5,
    greekLetter: 'δ',
    starName: 'Рухба',
    starNameLatin: 'Ruchbah',
    constellation: 'Кассіопея',
    goalText: 'Знайди шлях від А до В',
    pathLength: 18,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'БІНАРНА · ДВА ПЕРЕХОДИ',
    grid: _buildGrid(),
    startPos: (4, 2),
    endPos: (8, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 1, b);
    _p(grid, 0, 3, g);
    _p(grid, 0, 4, b);
    _p(grid, 0, 5, w, type: StarType.binary, second: g); // бінарна (пастка)
    _p(grid, 0, 6, w);
    _p(grid, 0, 7, r);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, w); // крок 3
    _p(grid, 1, 2, g); // крок 4
    _p(grid, 1, 3, r, type: StarType.binary, second: b); // бінарна крок 5
    _p(grid, 1, 6, g);
    _p(grid, 1, 7, w, type: StarType.binary, second: g); // бінарна (пастка)

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 3, b);
    _p(grid, 2, 6, g);
    _p(grid, 2, 7, b);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, w); // крок 9
    _p(grid, 3, 1, g); // крок 6
    _p(grid, 3, 2, g, type: StarType.binary, second: r); // бінарна крок 2
    _p(grid, 3, 3, b);
    _p(grid, 3, 4, w, type: StarType.binary, second: g); // бінарна крок 11
    _p(grid, 3, 6, g); // крок 12
    _p(grid, 3, 7, b);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, g); // крок 8
    _p(grid, 4, 2, r); // A
    _p(grid, 4, 6, r); // крок 13

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 1, r); // крок 7
    _p(grid, 5, 2, b); // крок 10
    _p(grid, 5, 4, g);
    _p(grid, 5, 5, b);
    _p(grid, 5, 7, g); // крок 14

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, b);
    _p(grid, 6, 1, b);
    _p(grid, 6, 3, b);
    _p(grid, 6, 4, b);
    _p(grid, 6, 5, g);
    _p(grid, 6, 6, r); // крок 15
    _p(grid, 6, 7, w);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, r);
    _p(grid, 7, 1, r);
    _p(grid, 7, 2, g);
    _p(grid, 7, 3, w);
    _p(grid, 7, 4, g);
    _p(grid, 7, 5, g); // крок 16
    _p(grid, 7, 7, r); // крок 17

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r, type: StarType.binary, second: b); // бінарна (пастка)
    _p(grid, 8, 1, r);
    _p(grid, 8, 2, w, type: StarType.binary, second: g); // бінарна (пастка)
    _p(grid, 8, 3, w);
    _p(grid, 8, 4, r);
    _p(grid, 8, 6, b);
    _p(grid, 8, 7, g); // B

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 1, g);
    _p(grid, 9, 2, g, type: StarType.binary, second: r); // бінарна (пастка)
    _p(grid, 9, 3, g);
    _p(grid, 9, 4, b);
    _p(grid, 9, 5, r);
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
