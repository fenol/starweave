import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 6 · ε Eps Per · 9×11 · pathLength=21 · ~69% заповнення
/// 6 стрибків через null:
///   (5,2)→(7,2)   гориз через (6,2)
///   (7,2)→(7,4)   верт через (7,3)
///   (5,7)→(3,7)   гориз через (4,7)
///   (2,8)→(4,10)  діаг через (3,9)
///   (4,10)→(2,10) гориз через (3,10)
///   (3,6)→(5,6)   гориз через (4,6)
class PerseusLevel6 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 6,
    totalLevels: 7,
    greekLetter: 'ζ',
    starName: 'Зета Пер.',
    starNameLatin: 'Zeta Per',
    constellation: 'Персей',
    goalText: 'Знайди шлях від А до В',
    pathLength: 21,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ВГОРУ ВПРАВО · ВНИЗ ЗИҐЗАҐОМ · НАЗАД ЛІВОРУЧ',
    grid: _buildGrid(),
    startPos: (2, 2), // col3,row3
    endPos:   (5, 4), // col5,row6
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(11, (_) => List<GridStar?>.filled(9, null));

    // ── Правильний шлях A→B ───────────────────────────────────────────────
    _p(grid, 2, 2, b); // A · (3,3)
    _p(grid, 1, 3, w); //   · (4,2)
    _p(grid, 1, 4, b); //   · (5,2)
    _p(grid, 1, 6, w); //   · (7,2) стрибок гориз через (6,2)=null
    _p(grid, 3, 6, g); //   · (7,4) стрибок верт через (7,3)=null
    _p(grid, 4, 7, r); //   · (8,5)
    _p(grid, 4, 8, g); //   · (9,5)
    _p(grid, 5, 8, r); //   · (9,6)
    _p(grid, 6, 8, g); //   · (9,7)
    _p(grid, 6, 6, w); //   · (7,7)
    _p(grid, 7, 5, g); //   · (6,8)
    _p(grid, 6, 4, w); //   · (5,7)
    _p(grid, 6, 2, g); //   · (3,7) стрибок гориз через (4,7)=null
    _p(grid, 7, 1, w); //   · (2,8)
    _p(grid, 9, 3, b); //   · (4,10) стрибок діаг через (3,9)=null
    _p(grid, 9, 1, w); //   · (2,10) стрибок гориз через (3,10)=null
    _p(grid, 8, 1, g); //   · (2,9)
    _p(grid, 7, 0, r); //   · (1,8)
    _p(grid, 6, 1, g); //   · (2,7)
    _p(grid, 5, 2, r); //   · (3,6)
    _p(grid, 5, 4, g); // B · (5,6) стрибок гориз через (4,6)=null

    // ── Заповнювачі ───────────────────────────────────────────────────────

    // Рядок 0 (y=1)
    _p(grid, 0, 0, r); // (1,1)
    _p(grid, 0, 1, b); // (2,1)
    _p(grid, 0, 2, r); // (3,1)
    _p(grid, 0, 4, w); // (5,1)
    _p(grid, 0, 7, g); // (8,1)
    _p(grid, 0, 8, w); // (9,1)

    // Рядок 1 (y=2) — path: (1,3)w (1,4)b (1,6)w
    _p(grid, 1, 0, w); // (1,2)
    _p(grid, 1, 1, g); // (2,2)
    _p(grid, 1, 2, g); // (3,2)
    _p(grid, 1, 7, b); // (8,2)

    // Рядок 2 (y=3) — path: (2,2)b A
    _p(grid, 2, 0, b); // (1,3)
    _p(grid, 2, 1, r); // (2,3)
    _p(grid, 2, 4, b); // (5,3)
    _p(grid, 2, 5, g); // (6,3)

    // Рядок 3 (y=4) — path: (3,6)g
    _p(grid, 3, 0, b); // (1,4)
    _p(grid, 3, 2, g); // (3,4)
    _p(grid, 3, 3, r); // (4,4)
    _p(grid, 3, 4, b); // (5,4)
    _p(grid, 3, 7, b); // (8,4)

    // Рядок 4 (y=5) — path: (4,7)r (4,8)g
    _p(grid, 4, 0, g); // (1,5)
    _p(grid, 4, 2, w); // (3,5)
    _p(grid, 4, 3, b); // (4,5)
    _p(grid, 4, 4, r); // (5,5)

    // Рядок 5 (y=6) — path: (5,2)r (5,4)g B (5,8)r
    _p(grid, 5, 0, b); // (1,6)
    _p(grid, 5, 5, r); // (6,6)
    _p(grid, 5, 6, w); // (7,6)

    // Рядок 6 (y=7) — path: (6,1)g (6,2)g (6,4)w (6,6)w (6,8)g
    _p(grid, 6, 5, w); // (6,7)

    // Рядок 7 (y=8) — path: (7,0)r (7,1)w (7,5)g
    _p(grid, 7, 2, b); // (3,8)
    _p(grid, 7, 3, r); // (4,8)
    _p(grid, 7, 4, r); // (5,8)
    _p(grid, 7, 6, w); // (7,8)
    _p(grid, 7, 7, r); // (8,8)

    // Рядок 8 (y=9) — path: (8,1)g
    _p(grid, 8, 0, w); // (1,9)
    _p(grid, 8, 3, b); // (4,9)
    _p(grid, 8, 5, b); // (6,9)
    _p(grid, 8, 7, b); // (8,9)
    _p(grid, 8, 8, b); // (9,9)

    // Рядок 9 (y=10) — path: (9,1)w (9,3)b
    _p(grid, 9, 5, r); // (6,10)
    _p(grid, 9, 6, r); // (7,10)
    _p(grid, 9, 8, b); // (9,10)

    // Рядок 10 (y=11)
    _p(grid,10, 1, w); // (2,11)
    _p(grid,10, 3, b); // (4,11)
    _p(grid,10, 4, b); // (5,11)
    _p(grid,10, 5, w); // (6,11)
    _p(grid,10, 6, g); // (7,11)
    _p(grid,10, 7, b); // (8,11)
    _p(grid,10, 8, g); // (9,11)

    return grid; // 21 шлях + 47 заповн. = 68 / 99 ≈ 69%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
