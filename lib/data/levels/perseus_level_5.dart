import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 5 · ε Eps Per · 9×11 · pathLength=20 · ~70% заповнення
/// 7 стрибків через null:
///   (1,6)→(3,4)   діаг через (2,5)
///   (3,5)→(1,7)   діаг через (2,6)
///   (1,11)→(3,11) гориз через (2,11)
///   (3,11)→(5,9)  діаг через (4,10)
///   (5,9)→(7,11)  діаг через (6,10)
///   (7,11)→(7,9)  верт через (7,10)
///   (9,9)→(9,7)   верт через (9,8)
class PerseusLevel5 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 5,
    totalLevels: 7,
    greekLetter: 'ε',
    starName: 'Епсілон Пер.',
    starNameLatin: 'Eps Per',
    constellation: 'Персей',
    goalText: 'Знайди шлях від А до В',
    pathLength: 20,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ЛІВОРУЧ ВНИЗ ЗИҐЗАҐОМ · СТРИБКИ ПРАВОРУЧ',
    grid: _buildGrid(),
    startPos: (6, 1), // col2,row7
    endPos:   (5, 7), // col8,row6
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(11, (_) => List<GridStar?>.filled(9, null));

    // ── Правильний шлях A→B ───────────────────────────────────────────────
    _p(grid, 6, 1, b); // A · (2,7)
    _p(grid, 5, 0, w); //   · (1,6)
    _p(grid, 3, 2, g); //   · (3,4) стрибок діаг через (2,5)=null
    _p(grid, 4, 2, r); //   · (3,5)
    _p(grid, 6, 0, g); //   · (1,7) стрибок діаг через (2,6)=null
    _p(grid, 7, 0, w); //   · (1,8)
    _p(grid, 7, 1, g); //   · (2,8)
    _p(grid, 8, 0, r); //   · (1,9)
    _p(grid, 8, 1, g); //   · (2,9)
    _p(grid, 9, 1, r); //   · (2,10)
    _p(grid,10, 0, g); //   · (1,11)
    _p(grid,10, 2, r); //   · (3,11) стрибок гориз через (2,11)=null
    _p(grid, 8, 4, g); //   · (5,9)  стрибок діаг через (4,10)=null
    _p(grid,10, 6, w); //   · (7,11) стрибок діаг через (6,10)=null
    _p(grid, 8, 6, b); //   · (7,9)  стрибок верт через (7,10)=null
    _p(grid, 7, 7, w); //   · (8,8)
    _p(grid, 8, 8, g); //   · (9,9)
    _p(grid, 6, 8, w); //   · (9,7)  стрибок верт через (9,8)=null
    _p(grid, 5, 8, b); //   · (9,6)
    _p(grid, 5, 7, w); // B · (8,6)

    // ── Заповнювачі ───────────────────────────────────────────────────────

    // Рядок 0 (y=1)
    _p(grid, 0, 0, g); // (1,1)
    _p(grid, 0, 2, g); // (3,1)
    _p(grid, 0, 3, r); // (4,1)
    _p(grid, 0, 5, r); // (6,1)
    _p(grid, 0, 8, r); // (9,1)

    // Рядок 1 (y=2)
    _p(grid, 1, 0, r); // (1,2)
    _p(grid, 1, 1, w); // (2,2)
    _p(grid, 1, 2, r); // (3,2)
    _p(grid, 1, 4, b); // (5,2)
    _p(grid, 1, 5, w); // (6,2)
    _p(grid, 1, 6, b); // (7,2)
    _p(grid, 1, 7, w); // (8,2)
    _p(grid, 1, 8, b); // (9,2)

    // Рядок 2 (y=3)
    _p(grid, 2, 0, b); // (1,3)
    _p(grid, 2, 1, b); // (2,3)
    _p(grid, 2, 2, b); // (3,3)
    _p(grid, 2, 4, r); // (5,3)
    _p(grid, 2, 5, b); // (6,3)
    _p(grid, 2, 6, w); // (7,3)
    _p(grid, 2, 7, g); // (8,3)
    _p(grid, 2, 8, g); // (9,3)

    // Рядок 3 (y=4) — path: (3,2)g
    _p(grid, 3, 1, g); // (2,4)
    _p(grid, 3, 3, b); // (4,4)
    _p(grid, 3, 4, g); // (5,4)
    _p(grid, 3, 6, g); // (7,4)
    _p(grid, 3, 8, g); // (9,4)

    // Рядок 4 (y=5) — path: (4,2)r
    _p(grid, 4, 0, r); // (1,5)
    _p(grid, 4, 3, g); // (4,5)
    _p(grid, 4, 4, b); // (5,5)
    _p(grid, 4, 6, g); // (7,5)
    _p(grid, 4, 7, r); // (8,5)
    _p(grid, 4, 8, b); // (9,5)

    // Рядок 5 (y=6) — path: (5,0)w (5,7)w B (5,8)b
    _p(grid, 5, 3, b); // (4,6)
    _p(grid, 5, 5, g); // (6,6)
    _p(grid, 5, 6, g); // (7,6)

    // Рядок 6 (y=7) — path: (6,0)g (6,1)b A (6,8)w
    _p(grid, 6, 3, w); // (4,7)
    _p(grid, 6, 4, b); // (5,7)
    _p(grid, 6, 7, r); // (8,7)

    // Рядок 7 (y=8) — path: (7,0)w (7,1)g (7,7)w
    _p(grid, 7, 2, b); // (3,8)
    _p(grid, 7, 4, g); // (5,8)

    // Рядок 8 (y=9) — path: (8,0)r (8,1)g (8,4)g (8,6)b (8,8)g
    _p(grid, 8, 3, w); // (4,9)
    _p(grid, 8, 5, b); // (6,9)
    _p(grid, 8, 7, r); // (8,9)

    // Рядок 9 (y=10) — path: (9,1)r
    _p(grid, 9, 0, b); // (1,10)
    _p(grid, 9, 4, g); // (5,10)
    _p(grid, 9, 8, w); // (9,10)

    // Рядок 10 (y=11) — path: (10,0)g (10,2)r (10,6)w
    _p(grid,10, 4, b); // (5,11)
    _p(grid,10, 7, w); // (8,11)
    _p(grid,10, 8, g); // (9,11)

    return grid; // 20 шлях + 49 заповн. = 69 / 99 ≈ 70%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
