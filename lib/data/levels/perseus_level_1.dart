import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 1 · α Mirfak · 9×11 · pathLength=16 · ~70% заповнення
/// Механіка: 8 напрямків + стрибок на 2 через null; спектр ±1
/// Шлях A(col3,row6)→B(col9,row6):
///   gold↔white × 3 кроки → blue↔white × 5 кроки
///   Стрибки через null: (1,7)→(3,9), (5,7)→(7,7), (7,5)→(9,5)
///
/// Координати з вхідних даних «col,row» (1-base) → grid[row-1][col-1]
class PerseusLevel1 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 1,
    totalLevels: 7,
    greekLetter: 'α',
    starName: 'Мірфак',
    starNameLatin: 'Mirfak',
    constellation: 'Персей',
    goalText: 'Знайди шлях від А до В',
    pathLength: 16,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ЗОЛОТО↔БІЛЕ · ПОТІМ СИНЄ↔БІЛЕ · СТРИБКИ ЧЕРЕЗ ПУСТЕ',
    grid: _buildGrid(),
    startPos: (5, 2), // col3,row6
    endPos:   (5, 8), // col9,row6
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(11, (_) => List<GridStar?>.filled(9, null));

    // ── Правильний шлях A→B ───────────────────────────────────────────────
    _p(grid, 5, 2, g); // A · (3,6)
    _p(grid, 6, 2, w); //   · (3,7)
    _p(grid, 5, 1, g); //   · (2,6)
    _p(grid, 6, 0, w); //   · (1,7)
    _p(grid, 8, 2, g); //   · (3,9) стрибок через (2,8)=null
    _p(grid, 7, 2, w); //   · (3,8)
    _p(grid, 6, 3, b); //   · (4,7)
    _p(grid, 6, 4, w); //   · (5,7)
    _p(grid, 6, 6, b); //   · (7,7) стрибок через (6,7)=null
    _p(grid, 7, 5, w); //   · (6,8)
    _p(grid, 7, 6, b); //   · (7,8)
    _p(grid, 6, 7, w); //   · (8,7)
    _p(grid, 5, 6, b); //   · (7,6)
    _p(grid, 4, 6, w); //   · (7,5)
    _p(grid, 4, 8, b); //   · (9,5) стрибок через (8,5)=null
    _p(grid, 5, 8, w); // B · (9,6)

    // ── Заповнювачі ───────────────────────────────────────────────────────

    // Рядок 0 (row=0, y=1)
    _p(grid, 0, 0, w); // (1,1)
    _p(grid, 0, 2, r); // (3,1)
    _p(grid, 0, 4, b); // (5,1)
    _p(grid, 0, 5, r); // (6,1)
    _p(grid, 0, 6, w); // (7,1)
    _p(grid, 0, 7, w); // (8,1)
    _p(grid, 0, 8, g); // (9,1)

    // Рядок 1 (row=1, y=2)
    _p(grid, 1, 0, g); // (1,2)
    _p(grid, 1, 1, w); // (2,2)
    _p(grid, 1, 2, w); // (3,2)
    _p(grid, 1, 3, r); // (4,2)
    _p(grid, 1, 5, w); // (6,2)
    _p(grid, 1, 6, g); // (7,2)
    _p(grid, 1, 7, r); // (8,2)
    _p(grid, 1, 8, r); // (9,2)

    // Рядок 2 (row=2, y=3)
    _p(grid, 2, 0, w); // (1,3)
    _p(grid, 2, 1, b); // (2,3)
    _p(grid, 2, 2, r); // (3,3)
    _p(grid, 2, 3, w); // (4,3)
    _p(grid, 2, 4, w); // (5,3)
    _p(grid, 2, 5, b); // (6,3)
    _p(grid, 2, 6, r); // (7,3)
    _p(grid, 2, 7, g); // (8,3)
    _p(grid, 2, 8, w); // (9,3)

    // Рядок 3 (row=3, y=4)
    _p(grid, 3, 0, g); // (1,4)
    _p(grid, 3, 1, g); // (2,4)
    _p(grid, 3, 5, r); // (6,4)
    _p(grid, 3, 7, r); // (8,4)
    _p(grid, 3, 8, b); // (9,4)

    // Рядок 4 (row=4, y=5) — path: (4,6)(4,8)
    _p(grid, 4, 0, b); // (1,5)
    _p(grid, 4, 1, g); // (2,5)
    _p(grid, 4, 3, b); // (4,5)
    _p(grid, 4, 4, r); // (5,5)

    // Рядок 5 (row=5, y=6) — path: (5,2)(5,1)(5,6)(5,8)
    _p(grid, 5, 0, r); // (1,6)
    _p(grid, 5, 3, r); // (4,6)
    _p(grid, 5, 4, r); // (5,6)

    // Рядок 6 (row=6, y=7) — path: (6,0)(6,2)(6,3)(6,4)(6,6)(6,7)
    // (немає заповнювачів)

    // Рядок 7 (row=7, y=8) — path: (7,2)(7,5)(7,6)
    _p(grid, 7, 0, r); // (1,8)
    _p(grid, 7, 4, r); // (5,8)
    _p(grid, 7, 7, r); // (8,8)
    _p(grid, 7, 8, w); // (9,8)

    // Рядок 8 (row=8, y=9) — path: (8,2)
    _p(grid, 8, 3, r); // (4,9)
    _p(grid, 8, 4, w); // (5,9)
    _p(grid, 8, 6, g); // (7,9)

    // Рядок 9 (row=9, y=10)
    _p(grid, 9, 0, w); // (1,10)
    _p(grid, 9, 2, w); // (3,10)
    _p(grid, 9, 7, w); // (8,10)
    _p(grid, 9, 8, r); // (9,10)

    // Рядок 10 (row=10, y=11)
    _p(grid, 10, 0, b); // (1,11)
    _p(grid, 10, 1, w); // (2,11)
    _p(grid, 10, 4, b); // (5,11)
    _p(grid, 10, 5, g); // (6,11)
    _p(grid, 10, 6, b); // (7,11)
    _p(grid, 10, 8, g); // (9,11)

    return grid; // 16 шлях + 53 заповн. = 69 / 99 ≈ 70%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
