import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 4 · η Eta Per · 9×11 · pathLength=19 · ~70% заповнення
/// 8 стрибків через null:
///   (4,9)→(6,11)  діаг через (5,10)
///   (6,11)→(6,9)  верт через (6,10)
///   (5,8)→(3,8)   гориз через (4,8)
///   (3,8)→(5,6)   діаг через (4,7)
///   (5,6)→(7,4)   діаг через (6,5)
///   (7,5)→(5,5)   гориз через (6,5)
///   (1,4)→(3,6)   діаг через (2,5)
///   (3,6)→(1,8)   діаг через (2,7)
class PerseusLevel4 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 4,
    totalLevels: 7,
    greekLetter: 'η',
    starName: 'Ета Пер.',
    starNameLatin: 'Eta Per',
    constellation: 'Персей',
    goalText: 'Прокладіть шлях від А до В',
    pathLength: 19,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ВНИЗ СТРИБКАМИ · ЗИҐЗАҐ · ВГОРУ ДІАГОНАЛЯМИ',
    grid: _buildGrid(),
    startPos: (8, 3), // col4,row9
    endPos:   (7, 0), // col1,row8
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(11, (_) => List<GridStar?>.filled(9, null));

    // ── Правильний шлях A→B ───────────────────────────────────────────────
    _p(grid, 8, 3, b); // A · (4,9)
    _p(grid,10, 5, w); //   · (6,11) стрибок діаг через (5,10)=null
    _p(grid, 8, 5, b); //   · (6,9)  стрибок верт через (6,10)=null
    _p(grid, 7, 4, w); //   · (5,8)
    _p(grid, 7, 2, b); //   · (3,8)  стрибок гориз через (4,8)=null
    _p(grid, 5, 4, w); //   · (5,6)  стрибок діаг через (4,7)=null
    _p(grid, 3, 6, g); //   · (7,4)  стрибок діаг через (6,5)=null
    _p(grid, 4, 7, w); //   · (8,5)
    _p(grid, 4, 6, b); //   · (7,5)
    _p(grid, 4, 4, w); //   · (5,5)  стрибок гориз через (6,5)=null
    _p(grid, 3, 5, b); //   · (6,4)
    _p(grid, 2, 4, w); //   · (5,3)
    _p(grid, 1, 3, g); //   · (4,2)
    _p(grid, 1, 4, r); //   · (5,2)
    _p(grid, 2, 3, g); //   · (4,3)
    _p(grid, 3, 2, r); //   · (3,4)
    _p(grid, 3, 0, g); //   · (1,4)
    _p(grid, 5, 2, w); //   · (3,6)  стрибок діаг через (2,5)=null
    _p(grid, 7, 0, g); // B · (1,8)  стрибок діаг через (2,7)=null

    // ── Заповнювачі ───────────────────────────────────────────────────────

    // Рядок 0 (y=1)
    _p(grid, 0, 1, g); // (2,1)
    _p(grid, 0, 2, g); // (3,1)
    _p(grid, 0, 3, g); // (4,1)
    _p(grid, 0, 5, g); // (6,1)
    _p(grid, 0, 6, b); // (7,1)
    _p(grid, 0, 8, r); // (9,1)

    // Рядок 1 (y=2) — path: (1,3)g (1,4)r
    _p(grid, 1, 0, b); // (1,2)
    _p(grid, 1, 2, b); // (3,2)
    _p(grid, 1, 5, r); // (6,2)
    _p(grid, 1, 6, r); // (7,2)
    _p(grid, 1, 7, g); // (8,2)
    _p(grid, 1, 8, b); // (9,2)

    // Рядок 2 (y=3) — path: (2,3)g (2,4)w
    _p(grid, 2, 0, r); // (1,3)
    _p(grid, 2, 5, b); // (6,3)
    _p(grid, 2, 6, b); // (7,3)
    _p(grid, 2, 8, g); // (9,3)

    // Рядок 3 (y=4) — path: (3,0)g (3,2)r (3,5)b (3,6)g
    // (немає заповнювачів)

    // Рядок 4 (y=5) — path: (4,4)w (4,6)b (4,7)w
    _p(grid, 4, 0, r); // (1,5)
    _p(grid, 4, 8, r); // (9,5)

    // Рядок 5 (y=6) — path: (5,2)w (5,4)w
    _p(grid, 5, 0, b); // (1,6)
    _p(grid, 5, 1, r); // (2,6)
    _p(grid, 5, 6, w); // (7,6)
    _p(grid, 5, 7, w); // (8,6)

    // Рядок 6 (y=7)
    _p(grid, 6, 2, r); // (3,7)
    _p(grid, 6, 5, r); // (6,7)
    _p(grid, 6, 7, r); // (8,7)
    _p(grid, 6, 8, b); // (9,7)

    // Рядок 7 (y=8) — path: (7,0)g B (7,2)b (7,4)w
    _p(grid, 7, 1, b); // (2,8)
    _p(grid, 7, 5, r); // (6,8)
    _p(grid, 7, 6, b); // (7,8)
    _p(grid, 7, 7, w); // (8,8)
    _p(grid, 7, 8, b); // (9,8)

    // Рядок 8 (y=9) — path: (8,3)b A (8,5)b
    _p(grid, 8, 0, g); // (1,9)
    _p(grid, 8, 1, r); // (2,9)
    _p(grid, 8, 2, b); // (3,9)
    _p(grid, 8, 4, r); // (5,9)
    _p(grid, 8, 6, g); // (7,9)
    _p(grid, 8, 7, b); // (8,9)
    _p(grid, 8, 8, r); // (9,9)

    // Рядок 9 (y=10)
    _p(grid, 9, 0, b); // (1,10)
    _p(grid, 9, 2, g); // (3,10)
    _p(grid, 9, 3, b); // (4,10)
    _p(grid, 9, 6, r); // (7,10)
    _p(grid, 9, 8, b); // (9,10)

    // Рядок 10 (y=11) — path: (10,5)w
    _p(grid,10, 0, w); // (1,11)
    _p(grid,10, 1, r); // (2,11)
    _p(grid,10, 2, g); // (3,11)
    _p(grid,10, 3, g); // (4,11)
    _p(grid,10, 4, g); // (5,11)
    _p(grid,10, 6, w); // (7,11)
    _p(grid,10, 8, r); // (9,11)

    return grid; // 19 шлях + 50 заповн. = 69 / 99 ≈ 70%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
