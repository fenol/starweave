import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Кассіопея · Рівень 1 · β Каф · «Перший злам»
// Сітка 8×10, шлях=14
// Рішення: A(0,3)w→(2,1)b→(2,2)w→(1,3)g→(3,3)BIN(w)→(5,5)b→(6,5)w→(6,3)g
//           →(5,2)r→(4,2)g→(6,0)r→(7,1)g→(9,3)w→(8,3)b=B
class CassiopeiaLevel1 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 1,
    totalLevels: 5,
    greekLetter: 'β',
    starName: 'Каф',
    starNameLatin: 'Caph',
    constellation: 'Кассіопея',
    goalText: 'Знайди шлях через бінарну зірку від А до В',
    pathLength: 14,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'СПЕКТР · БІНАРНА ЗІРКА',
    grid: _buildGrid(),
    startPos: (0, 3),
    endPos: (8, 3),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, r);
    _p(grid, 0, 1, b);
    _p(grid, 0, 2, w);
    _p(grid, 0, 3, w); // A
    _p(grid, 0, 4, b);
    _p(grid, 0, 5, b);
    _p(grid, 0, 6, w);
    _p(grid, 0, 7, b);

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 1, g);
    _p(grid, 1, 3, g); // крок 4
    _p(grid, 1, 6, r);
    _p(grid, 1, 7, b);

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 1, b); // крок 2
    _p(grid, 2, 2, w); // крок 3
    _p(grid, 2, 5, b);
    _p(grid, 2, 6, b);
    _p(grid, 2, 7, r);

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, b, type: StarType.binary, second: w); // бінарна (пастка)
    _p(grid, 3, 3, w, type: StarType.binary, second: g); // бінарна крок 5
    _p(grid, 3, 4, b);
    _p(grid, 3, 5, b);
    _p(grid, 3, 6, b);
    _p(grid, 3, 7, g);

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 1, w);
    _p(grid, 4, 2, g); // крок 10
    _p(grid, 4, 6, g);
    _p(grid, 4, 7, g);

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, r);
    _p(grid, 5, 2, r); // крок 9
    _p(grid, 5, 4, r);
    _p(grid, 5, 5, b); // крок 6
    _p(grid, 5, 6, g);
    _p(grid, 5, 7, b);

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, r); // крок 11
    _p(grid, 6, 1, b);
    _p(grid, 6, 2, b);
    _p(grid, 6, 3, g); // крок 8
    _p(grid, 6, 5, w); // крок 7
    _p(grid, 6, 6, b);
    _p(grid, 6, 7, w);

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 0, b);
    _p(grid, 7, 1, g); // крок 12
    _p(grid, 7, 2, b);
    _p(grid, 7, 3, g);
    _p(grid, 7, 6, g);

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 1, b);
    _p(grid, 8, 3, b); // B
    _p(grid, 8, 4, g);
    _p(grid, 8, 5, b);
    _p(grid, 8, 6, b);
    _p(grid, 8, 7, r);

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, w);
    _p(grid, 9, 2, b);
    _p(grid, 9, 3, w); // крок 13
    _p(grid, 9, 4, g);
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
