import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 7 · ζ Zeta Per · 9×11 · pathLength=22 · ~67% заповнення
/// 8 стрибків через null:
///   (3,6)→(3,8)   верт через (3,7)
///   (4,7)→(4,5)   верт через (4,6)
///   (4,5)→(6,5)   гориз через (5,5)
///   (7,3)→(7,1)   верт через (7,2)
///   (6,2)→(8,2)   гориз через (7,2)
///   (9,1)→(9,3)   верт через (9,2)
///   (9,3)→(9,5)   верт через (9,4)
///   (9,5)→(9,7)   верт через (9,6)
class PerseusLevel7 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 7,
    totalLevels: 7,
    greekLetter: 'η',
    starName: 'Ета Пер.',
    starNameLatin: 'Eta Per',
    constellation: 'Персей',
    goalText: 'Знайди шлях від А до В',
    pathLength: 22,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'СТРИБКИ ВНИЗ · ЧЕРЕЗ ВЕРШИНУ · КРАЙНЯ ПРАВА ВНИЗ',
    grid: _buildGrid(),
    startPos: (5, 2), // col3,row6
    endPos:   (7, 6), // col7,row8
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(11, (_) => List<GridStar?>.filled(9, null));

    // ── Правильний шлях A→B ───────────────────────────────────────────────
    _p(grid, 5, 2, b); // A · (3,6)
    _p(grid, 7, 2, w); //   · (3,8)  стрибок верт через (3,7)=null
    _p(grid, 6, 3, b); //   · (4,7)
    _p(grid, 4, 3, w); //   · (4,5)  стрибок верт через (4,6)=null
    _p(grid, 4, 5, b); //   · (6,5)  стрибок гориз через (5,5)=null
    _p(grid, 4, 6, w); //   · (7,5)
    _p(grid, 3, 6, g); //   · (7,4)
    _p(grid, 3, 7, r); //   · (8,4)
    _p(grid, 2, 6, g); //   · (7,3)
    _p(grid, 0, 6, r); //   · (7,1)  стрибок верт через (7,2)=null
    _p(grid, 0, 5, g); //   · (6,1)
    _p(grid, 0, 4, r); //   · (5,1)
    _p(grid, 1, 5, g); //   · (6,2)
    _p(grid, 1, 7, w); //   · (8,2)  стрибок гориз через (7,2)=null
    _p(grid, 0, 8, b); //   · (9,1)
    _p(grid, 2, 8, w); //   · (9,3)  стрибок верт через (9,2)=null
    _p(grid, 4, 8, b); //   · (9,5)  стрибок верт через (9,4)=null
    _p(grid, 6, 8, w); //   · (9,7)  стрибок верт через (9,6)=null
    _p(grid, 5, 7, g); //   · (8,6)
    _p(grid, 5, 6, r); //   · (7,6)
    _p(grid, 6, 6, g); //   · (7,7)
    _p(grid, 7, 6, r); // B · (7,8)

    // ── Заповнювачі ───────────────────────────────────────────────────────

    // Рядок 0 (y=1) — path: (0,4)r (0,5)g (0,6)r (0,8)b
    _p(grid, 0, 0, r); // (1,1)
    _p(grid, 0, 1, g); // (2,1)
    _p(grid, 0, 2, b); // (3,1)
    _p(grid, 0, 3, g); // (4,1)
    _p(grid, 0, 7, g); // (8,1)

    // Рядок 1 (y=2) — path: (1,5)g (1,7)w
    _p(grid, 1, 0, r); // (1,2)
    _p(grid, 1, 1, g); // (2,2)
    _p(grid, 1, 2, b); // (3,2)

    // Рядок 2 (y=3) — path: (2,6)g (2,8)w
    _p(grid, 2, 0, r); // (1,3)
    _p(grid, 2, 1, w); // (2,3)
    _p(grid, 2, 2, r); // (3,3)
    _p(grid, 2, 5, b); // (6,3)

    // Рядок 3 (y=4) — path: (3,6)g (3,7)r
    _p(grid, 3, 1, w); // (2,4)
    _p(grid, 3, 2, w); // (3,4)
    _p(grid, 3, 3, w); // (4,4)

    // Рядок 4 (y=5) — path: (4,3)w (4,5)b (4,6)w (4,8)b
    _p(grid, 4, 0, w); // (1,5)
    _p(grid, 4, 2, r); // (3,5)

    // Рядок 5 (y=6) — path: (5,2)b A (5,6)r (5,7)g
    _p(grid, 5, 0, b); // (1,6)
    _p(grid, 5, 1, b); // (2,6)
    _p(grid, 5, 4, b); // (5,6)

    // Рядок 6 (y=7) — path: (6,3)b (6,6)g (6,8)w
    _p(grid, 6, 0, g); // (1,7)
    _p(grid, 6, 1, b); // (2,7)
    _p(grid, 6, 5, b); // (6,7)

    // Рядок 7 (y=8) — path: (7,2)w (7,6)r B
    _p(grid, 7, 0, r); // (1,8)
    _p(grid, 7, 3, b); // (4,8)
    _p(grid, 7, 5, w); // (6,8)

    // Рядок 8 (y=9)
    _p(grid, 8, 0, g); // (1,9)
    _p(grid, 8, 1, b); // (2,9)
    _p(grid, 8, 2, g); // (3,9)
    _p(grid, 8, 3, r); // (4,9)
    _p(grid, 8, 4, b); // (5,9)
    _p(grid, 8, 6, r); // (7,9)
    _p(grid, 8, 8, b); // (9,9)

    // Рядок 9 (y=10)
    _p(grid, 9, 0, b); // (1,10)
    _p(grid, 9, 1, r); // (2,10)
    _p(grid, 9, 2, g); // (3,10)
    _p(grid, 9, 3, r); // (4,10)
    _p(grid, 9, 5, g); // (6,10)
    _p(grid, 9, 7, r); // (8,10)

    // Рядок 10 (y=11)
    _p(grid,10, 0, b); // (1,11)
    _p(grid,10, 2, b); // (3,11)
    _p(grid,10, 4, b); // (5,11)
    _p(grid,10, 5, b); // (6,11)
    _p(grid,10, 6, r); // (7,11)

    return grid; // 22 шлях + 44 заповн. = 66 / 99 ≈ 67%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
