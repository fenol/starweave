import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 3 · γ Gamma Per · 9×11 · pathLength=18 · ~70% заповнення
/// Механіка: 8 напрямків + стрибки на 2 через null; спектр ±1
/// Шлях A(col4,row4)→B(col9,row7):
///   r g w g w b w b w g r g w · b w b w g
///   6 стрибків через null:
///     (5,2)→(3,2)  через (4,2)=null  — горизонтальний
///     (3,2)→(1,2)  через (2,2)=null  — горизонтальний
///     (1,2)→(1,4)  через (1,3)=null  — вертикальний
///     (5,5)→(7,7)  через (6,6)=null  — діагональний
///     (8,6)→(8,4)  через (8,5)=null  — вертикальний
///     (9,5)→(9,7)  через (9,6)=null  — вертикальний
class PerseusLevel3 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 3,
    totalLevels: 7,
    greekLetter: 'γ',
    starName: 'Гамма Пер.',
    starNameLatin: 'Gamma Per',
    constellation: 'Персей',
    goalText: 'Знайди шлях від А до В',
    pathLength: 18,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ЛІВОРУЧ СТРИБКАМИ · ПОТІМ ДІАГОНАЛЬ · ПРАВОРУЧ ВГОРУ',
    grid: _buildGrid(),
    startPos: (3, 3), // col4,row4
    endPos:   (6, 8), // col9,row7
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(11, (_) => List<GridStar?>.filled(9, null));

    // ── Правильний шлях A→B ───────────────────────────────────────────────
    _p(grid, 3, 3, r); // A · (4,4)
    _p(grid, 2, 3, g); //   · (4,3)
    _p(grid, 0, 3, w); //   · (4,1)
    _p(grid, 1, 4, g); //   · (5,2)
    _p(grid, 1, 2, w); //   · (3,2) стрибок через (4,2)=null
    _p(grid, 1, 0, b); //   · (1,2) стрибок через (2,2)=null
    _p(grid, 3, 0, w); //   · (1,4) стрибок через (1,3)=null
    _p(grid, 4, 1, b); //   · (2,5)
    _p(grid, 5, 0, w); //   · (1,6)
    _p(grid, 5, 1, g); //   · (2,6)
    _p(grid, 6, 2, r); //   · (3,7)
    _p(grid, 5, 3, g); //   · (4,6)
    _p(grid, 4, 4, w); //   · (5,5)
    _p(grid, 6, 6, b); //   · (7,7) стрибок через (6,6)=null
    _p(grid, 5, 7, w); //   · (8,6)
    _p(grid, 3, 7, b); //   · (8,4) стрибок через (8,5)=null
    _p(grid, 4, 8, w); //   · (9,5)
    _p(grid, 6, 8, g); // B · (9,7) стрибок через (9,6)=null

    // ── Заповнювачі ───────────────────────────────────────────────────────

    // Рядок 0 (y=1)
    _p(grid, 0, 0, g); // (1,1)
    _p(grid, 0, 5, w); // (6,1)
    _p(grid, 0, 6, w); // (7,1)
    _p(grid, 0, 7, r); // (8,1)

    // Рядок 1 (y=2) — path: (1,0)b (1,2)w (1,4)g
    _p(grid, 1, 5, b); // (6,2)
    _p(grid, 1, 6, w); // (7,2)
    _p(grid, 1, 7, w); // (8,2)

    // Рядок 2 (y=3) — path: (2,3)g
    _p(grid, 2, 1, r); // (2,3)
    _p(grid, 2, 2, w); // (3,3)
    _p(grid, 2, 4, g); // (5,3)
    _p(grid, 2, 6, r); // (7,3)
    _p(grid, 2, 7, r); // (8,3)
    _p(grid, 2, 8, r); // (9,3)

    // Рядок 3 (y=4) — path: (3,0)w (3,3)r A (3,7)b
    _p(grid, 3, 1, w); // (2,4)
    _p(grid, 3, 5, r); // (6,4)
    _p(grid, 3, 6, b); // (7,4)

    // Рядок 4 (y=5) — path: (4,1)b (4,4)w (4,8)w
    _p(grid, 4, 3, w); // (4,5)
    _p(grid, 4, 5, r); // (6,5)

    // Рядок 5 (y=6) — path: (5,0)w (5,1)g (5,3)g (5,7)w
    _p(grid, 5, 2, b); // (3,6)
    _p(grid, 5, 4, w); // (5,6)
    _p(grid, 5, 6, r); // (7,6)

    // Рядок 6 (y=7) — path: (6,2)r (6,6)b (6,8)g B
    _p(grid, 6, 0, w); // (1,7)
    _p(grid, 6, 3, r); // (4,7)
    _p(grid, 6, 5, b); // (6,7)
    _p(grid, 6, 7, r); // (8,7)

    // Рядок 7 (y=8)
    _p(grid, 7, 0, g); // (1,8)
    _p(grid, 7, 1, b); // (2,8)
    _p(grid, 7, 2, w); // (3,8)
    _p(grid, 7, 3, r); // (4,8)
    _p(grid, 7, 6, r); // (7,8)
    _p(grid, 7, 7, w); // (8,8)
    _p(grid, 7, 8, w); // (9,8)

    // Рядок 8 (y=9)
    _p(grid, 8, 0, r); // (1,9)
    _p(grid, 8, 1, g); // (2,9)
    _p(grid, 8, 2, w); // (3,9)
    _p(grid, 8, 3, r); // (4,9)
    _p(grid, 8, 4, r); // (5,9)
    _p(grid, 8, 6, b); // (7,9)
    _p(grid, 8, 7, w); // (8,9)
    _p(grid, 8, 8, r); // (9,9)

    // Рядок 9 (y=10)
    _p(grid, 9, 3, r); // (4,10)
    _p(grid, 9, 4, w); // (5,10)
    _p(grid, 9, 7, b); // (8,10)
    _p(grid, 9, 8, g); // (9,10)

    // Рядок 10 (y=11)
    _p(grid, 10, 0, g); // (1,11)
    _p(grid, 10, 2, w); // (3,11)
    _p(grid, 10, 3, b); // (4,11)
    _p(grid, 10, 4, r); // (5,11)
    _p(grid, 10, 6, g); // (7,11)
    _p(grid, 10, 7, g); // (8,11)
    _p(grid, 10, 8, b); // (9,11)

    return grid; // 18 шлях + 51 заповн. = 69 / 99 ≈ 70%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
