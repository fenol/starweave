import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Кассіопея · Рівень 3 · γ Наві · «Дзеркало»
// Сітка 8×10, шлях=16
// Рішення: A(0,1)r→(0,0)g→(2,0)w→(1,1)b→(2,2)BIN(w)→(2,1)g→(1,2)r→(0,3)g
//           →(0,2)r→(1,3)g→(3,5)w→(3,4)BIN(g)→(3,3)r→(4,3)g→(5,2)r→(7,0)g=B
class CassiopeiaLevel3 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 3,
    totalLevels: 5,
    greekLetter: 'γ',
    starName: 'Наві',
    starNameLatin: 'Navi',
    constellation: 'Кассіопея',
    goalText: 'Знайди шлях від А до В',
    pathLength: 16,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНІШЕ',
    hint: 'БІНАРНА · ПЕРЕКЛЮЧАЙ КОЛІР',
    grid: _buildGrid(),
    startPos: (0, 1),
    endPos: (7, 0),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, g); // крок 2
    _p(grid, 0, 1, r); // A
    _p(grid, 0, 2, r); // крок 9
    _p(grid, 0, 3, g); // крок 8
    _p(grid, 0, 4, g);
    _p(grid, 0, 5, b);
    _p(grid, 0, 6, b);
    _p(grid, 0, 7, w);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 1, b); // крок 4
    _p(grid, 1, 2, r); // крок 7
    _p(grid, 1, 3, g); // крок 10
    _p(grid, 1, 4, b);
    _p(grid, 1, 6, g);
    _p(grid, 1, 7, b);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, w); // крок 3
    _p(grid, 2, 1, g); // крок 6
    _p(grid, 2, 2, b, type: StarType.binary, second: w); // бінарна крок 5
    _p(grid, 2, 3, b);
    _p(grid, 2, 6, b);
    _p(grid, 2, 7, r);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, r);
    _p(grid, 3, 2, r);
    _p(grid, 3, 3, r); // крок 13
    _p(grid, 3, 4, w, type: StarType.binary, second: g); // бінарна крок 12
    _p(grid, 3, 5, w); // крок 11
    _p(grid, 3, 6, b);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, w);
    _p(grid, 4, 3, g); // крок 14
    _p(grid, 4, 6, w);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, b);
    _p(grid, 5, 1, r);
    _p(grid, 5, 2, r); // крок 15
    _p(grid, 5, 4, b);
    _p(grid, 5, 7, w);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, r);
    _p(grid, 6, 4, r, type: StarType.binary, second: b); // бінарна (пастка)
    _p(grid, 6, 5, r);
    _p(grid, 6, 6, r, type: StarType.binary, second: b); // бінарна (пастка)
    _p(grid, 6, 7, w);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, g); // B
    _p(grid, 7, 1, g);
    _p(grid, 7, 2, b);
    _p(grid, 7, 3, b);
    _p(grid, 7, 6, r);
    _p(grid, 7, 7, b);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r);
    _p(grid, 8, 1, b);
    _p(grid, 8, 2, r);
    _p(grid, 8, 4, b);
    _p(grid, 8, 5, r, type: StarType.binary, second: b); // бінарна (пастка)

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 1, r);
    _p(grid, 9, 2, r);
    _p(grid, 9, 4, g, type: StarType.binary, second: r); // бінарна (пастка)
    _p(grid, 9, 5, r);
    _p(grid, 9, 6, g);
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
