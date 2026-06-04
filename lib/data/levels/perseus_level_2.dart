import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 2 · β Algol · 9×11 · pathLength=17 · ~67% заповнення
/// Механіка: 8 напрямків + стрибки на 2 через null; спектр ±1
/// Шлях A(col9,row9)→B(col1,row6):
///   b w g w g w b w · g r · g w · g r g r g
///   5 діагональних стрибки:
///     (7,8)→(5,6)  через (6,7)=null
///     (6,5)→(8,3)  через (7,4)=null
///     (7,3)→(5,5)  через (6,4)=null
///     (6,6)→(4,8)  через (5,7)=null
///     (1,8)→(1,6)  через (1,7)=null
class PerseusLevel2 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 2,
    totalLevels: 7,
    greekLetter: 'β',
    starName: 'Алголь',
    starNameLatin: 'Algol',
    constellation: 'Персей',
    goalText: 'Знайди шлях від А до В',
    pathLength: 17,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ЗИҐЗАҐ ДІАГОНАЛЯМИ · П\'ЯТЬ СТРИБКІВ ЧЕРЕЗ ПУСТЕ',
    grid: _buildGrid(),
    startPos: (8, 8), // col9,row9
    endPos:   (5, 0), // col1,row6
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(11, (_) => List<GridStar?>.filled(9, null));

    // ── Правильний шлях A→B ───────────────────────────────────────────────
    _p(grid, 8, 8, b); // A · (9,9)
    _p(grid, 9, 8, w); //   · (9,10)
    _p(grid, 9, 7, g); //   · (8,10)
    _p(grid, 9, 6, w); //   · (7,10)
    _p(grid, 8, 7, g); //   · (8,9)
    _p(grid, 7, 6, w); //   · (7,8)
    _p(grid, 5, 4, b); //   · (5,6) стрибок через (6,7)=null
    _p(grid, 4, 5, w); //   · (6,5)
    _p(grid, 2, 7, g); //   · (8,3) стрибок через (7,4)=null
    _p(grid, 2, 6, r); //   · (7,3)
    _p(grid, 4, 4, g); //   · (5,5) стрибок через (6,4)=null
    _p(grid, 5, 5, w); //   · (6,6)
    _p(grid, 7, 3, g); //   · (4,8) стрибок через (5,7)=null
    _p(grid, 7, 1, r); //   · (2,8)
    _p(grid, 8, 0, g); //   · (1,9)
    _p(grid, 7, 0, r); //   · (1,8)
    _p(grid, 5, 0, g); // B · (1,6) стрибок через (1,7)=null

    // ── Заповнювачі ───────────────────────────────────────────────────────

    // Рядок 0 (y=1)
    _p(grid, 0, 0, r); // (1,1)
    _p(grid, 0, 1, g); // (2,1)
    _p(grid, 0, 3, b); // (4,1)
    _p(grid, 0, 4, r); // (5,1)

    // Рядок 1 (y=2)
    _p(grid, 1, 0, w); // (1,2)
    _p(grid, 1, 2, w); // (3,2)
    _p(grid, 1, 3, g); // (4,2)
    _p(grid, 1, 5, b); // (6,2)
    _p(grid, 1, 7, w); // (8,2)
    _p(grid, 1, 8, b); // (9,2)

    // Рядок 2 (y=3) — path: (2,7)g (2,6)r
    _p(grid, 2, 0, w); // (1,3)
    _p(grid, 2, 1, r); // (2,3)
    _p(grid, 2, 2, r); // (3,3)
    _p(grid, 2, 3, r); // (4,3)
    _p(grid, 2, 4, b); // (5,3)
    _p(grid, 2, 5, b); // (6,3)
    _p(grid, 2, 8, r); // (9,3)

    // Рядок 3 (y=4)
    _p(grid, 3, 2, w); // (3,4)
    _p(grid, 3, 3, g); // (4,4)
    _p(grid, 3, 7, b); // (8,4)

    // Рядок 4 (y=5) — path: (4,4)g (4,5)w
    _p(grid, 4, 0, w); // (1,5)
    _p(grid, 4, 1, b); // (2,5)
    _p(grid, 4, 3, g); // (4,5)
    _p(grid, 4, 6, w); // (7,5)
    _p(grid, 4, 7, w); // (8,5)
    _p(grid, 4, 8, w); // (9,5)

    // Рядок 5 (y=6) — path: (5,0)g B (5,4)b (5,5)w
    _p(grid, 5, 1, r); // (2,6)
    _p(grid, 5, 2, b); // (3,6)
    _p(grid, 5, 3, b); // (4,6)
    _p(grid, 5, 8, b); // (9,6)

    // Рядок 6 (y=7)
    _p(grid, 6, 1, r); // (2,7)
    _p(grid, 6, 3, w); // (4,7)
    _p(grid, 6, 7, r); // (8,7)
    _p(grid, 6, 8, r); // (9,7)

    // Рядок 7 (y=8) — path: (7,0)r (7,1)r (7,3)g (7,6)w
    // (немає заповнювачів)

    // Рядок 8 (y=9) — path: (8,0)g (8,7)g (8,8)b A
    _p(grid, 8, 2, g); // (3,9)
    _p(grid, 8, 3, g); // (4,9)
    _p(grid, 8, 4, g); // (5,9)

    // Рядок 9 (y=10) — path: (9,6)w (9,7)g (9,8)w
    _p(grid, 9, 0, g); // (1,10)
    _p(grid, 9, 1, g); // (2,10)
    _p(grid, 9, 2, b); // (3,10)
    _p(grid, 9, 3, g); // (4,10)
    _p(grid, 9, 4, w); // (5,10)
    _p(grid, 9, 5, g); // (6,10)

    // Рядок 10 (y=11)
    _p(grid, 10, 0, r); // (1,11)
    _p(grid, 10, 1, w); // (2,11)
    _p(grid, 10, 2, g); // (3,11)
    _p(grid, 10, 3, b); // (4,11)
    _p(grid, 10, 4, b); // (5,11)
    _p(grid, 10, 7, w); // (8,11)

    return grid; // 17 шлях + 49 заповн. = 66 / 99 ≈ 67%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
