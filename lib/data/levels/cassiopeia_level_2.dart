import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Кассіопея · Рівень 2 · α Шедар · «Подвійний кут»
// Сітка 8×10, шлях=15
// Рішення: A(7,1)r→(7,2)g→(5,4)r→(5,6)g→(3,6)r→(2,6)g→(2,7)r→(0,5)g
//           →(1,4)w→(0,3)BIN(b)→(1,3)w→(3,1)g→(2,1)w→(1,2)BIN(g)→(0,2)w=B
class CassiopeiaLevel2 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 2,
    totalLevels: 5,
    greekLetter: 'α',
    starName: 'Шедар',
    starNameLatin: 'Schedar',
    constellation: 'Кассіопея',
    goalText: 'Знайди шлях від А до В',
    pathLength: 15,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'БІНАРНА ЗІРКА · ±1 ПО СПЕКТРУ',
    grid: _buildGrid(),
    startPos: (7, 1),
    endPos: (0, 2),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, g);
    _p(grid, 0, 1, r);
    _p(grid, 0, 2, w); // B
    _p(grid, 0, 3, b, type: StarType.binary, second: w); // бінарна крок 10
    _p(grid, 0, 5, g); // крок 8

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, r);
    _p(grid, 1, 1, w);
    _p(grid, 1, 2, w, type: StarType.binary, second: g); // бінарна крок 14
    _p(grid, 1, 3, w); // крок 11
    _p(grid, 1, 4, w); // крок 9
    _p(grid, 1, 5, b);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, w);
    _p(grid, 2, 1, w); // крок 13
    _p(grid, 2, 3, w);
    _p(grid, 2, 6, g); // крок 6
    _p(grid, 2, 7, r); // крок 7

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, b);
    _p(grid, 3, 1, g); // крок 12
    _p(grid, 3, 4, w);
    _p(grid, 3, 6, r); // крок 5
    _p(grid, 3, 7, w);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 0, r);
    _p(grid, 4, 1, g);
    _p(grid, 4, 2, r);
    _p(grid, 4, 4, r);
    _p(grid, 4, 5, b);
    _p(grid, 4, 7, r);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, b);
    _p(grid, 5, 3, w);
    _p(grid, 5, 4, r); // крок 3
    _p(grid, 5, 6, g); // крок 4
    _p(grid, 5, 7, g);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, w);
    _p(grid, 6, 1, g);
    _p(grid, 6, 2, b);
    _p(grid, 6, 4, g, type: StarType.binary, second: r); // бінарна (пастка)
    _p(grid, 6, 7, r);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, g);
    _p(grid, 7, 1, r); // A
    _p(grid, 7, 2, g); // крок 2
    _p(grid, 7, 3, g);
    _p(grid, 7, 6, b);
    _p(grid, 7, 7, r);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, w);
    _p(grid, 8, 1, g);
    _p(grid, 8, 2, g);
    _p(grid, 8, 3, g);
    _p(grid, 8, 5, r);
    _p(grid, 8, 6, r, type: StarType.binary, second: b); // бінарна (пастка)
    _p(grid, 8, 7, b);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 1, r);
    _p(grid, 9, 3, b);
    _p(grid, 9, 4, g);
    _p(grid, 9, 5, r);
    _p(grid, 9, 6, r);
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
