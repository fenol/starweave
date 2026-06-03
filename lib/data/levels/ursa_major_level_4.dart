import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 4 · ζ Mizar · 7×7 · pathLength=9
/// Складність: СЕРЕДНЬО
/// Форма: зиґзаґ — шлях іде праворуч потім повертає ліворуч
/// Спектр: blue → white → gold → red → gold → white → blue → white → gold
class UrsaMajorLevel4 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 4,
    totalLevels: 7,
    greekLetter: 'ζ',
    starName: 'Мізар',
    starNameLatin: 'Mizar',
    constellation: 'Велика Ведмедиця',
    goalText: 'Шлях петляє — знайди правильний зиґзаґ',
    pathLength: 9,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СЕРЕДНЬО',
    hint: 'ЗИҐЗАҐ · ШЛЯХ ПОВЕРТАЄ ЛІВОРУЧ',
    grid: _buildGrid(),
    startPos: (6, 0),
    endPos: (0, 0),
  );

  static List<List<GridStar?>> _buildGrid() {
    // Сітка 7×7
    final grid = List.generate(7, (_) => List<GridStar?>.filled(7, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    // Іде діагонально вгору-праворуч до (3,3)r
    // Потім горизонтальний крок (3,3)→(3,4)g  ← зиґзаґ
    // Потім повертає ліворуч-вгору (3,4)g→(2,3)w→(2,2)b→(1,1)w→(0,0)g
    _p(grid, 6, 0, b); // A — старт
    _p(grid, 5, 1, w);
    _p(grid, 4, 2, g);
    _p(grid, 3, 3, r);
    _p(grid, 3, 4, g); // ← горизонтальний зиґзаґ
    _p(grid, 2, 3, w); // ← повертає ліворуч-вгору
    _p(grid, 2, 2, b);
    _p(grid, 1, 1, w);
    _p(grid, 0, 0, g); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 6, 1, w); // adj A: b→w ✓
    _p(grid, 5, 0, w); // adj A: b→w ✓ інший бік
    _p(grid, 5, 2, g); // adj step2: w→g ✓ підказує продовжити діагональ
    _p(grid, 4, 1, r); // adj step3: g→r ✓ ловить того хто не зробить зиґзаґ
    _p(grid, 4, 3, w); // adj зиґзаґ: r→w diff=2 ЗАБОРОНЕНО — видима пастка
    _p(grid, 4, 4, w); // adj зиґзаґ: g→w ✓ після зиґзаґу може звернути сюди
    _p(grid, 3, 5, r); // adj після зиґзаґу: g→r ✓ манить праворуч
    _p(grid, 2, 4, r); // adj step5: w→r diff=2 ЗАБОРОНЕНО — неправильний спектр
    _p(grid, 1, 2, g); // adj step7: b→g diff=2 ЗАБОРОНЕНО / w→g ✓ тупик
    _p(grid, 1, 0, b); // adj step8: w→b ✓ тупик — від b до B(g) diff=2
    _p(grid, 0, 1, w); // adj B: g→w ✓ відволікає від B

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 6, 2, r);
    _p(grid, 6, 3, b);
    _p(grid, 6, 4, w);
    _p(grid, 6, 5, g);
    _p(grid, 6, 6, r);
    _p(grid, 5, 3, b);
    _p(grid, 5, 4, g);
    _p(grid, 5, 5, r);
    _p(grid, 5, 6, w);
    _p(grid, 4, 6, b);
    _p(grid, 3, 6, w);
    _p(grid, 0, 3, r);

    return grid; // 9+11+12 = 32/49 = 65.3%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
