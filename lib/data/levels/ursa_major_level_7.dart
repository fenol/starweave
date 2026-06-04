import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 7 · ε Alioth · 8×8 · pathLength=12
/// Складність: СКЛАДНО
/// Форма: Z-подібна — вгору-праворуч, поворот ліворуч-вгору, потім вниз-праворуч
/// Спектр: blue → white → gold → red → gold → white → gold → red → gold → white → blue → white
class UrsaMajorLevel7 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 7,
    totalLevels: 7,
    greekLetter: 'η',
    starName: 'Алькаїд',
    starNameLatin: 'Alkaid',
    constellation: 'Велика Ведмедиця',
    goalText: 'Знайди шлях від А до В',
    pathLength: 12,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ФОРМА Z · ТРИ ЧАСТИНИ — ТРИ НАПРЯМКИ',
    grid: _buildGrid(),
    startPos: (7, 0),
    endPos: (5, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    // Сітка 8×8
    final grid = List.generate(8, (_) => List<GridStar?>.filled(8, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    // Частина 1: вгору-праворуч  (7,0)b → (6,1)w → (5,2)g → (4,3)r
    // Поворот: (4,3)r → (3,2)g → (2,1)w  [ліворуч-вгору!]
    // Частина 2: вгору-праворуч знову  (2,1)w → (1,2)g
    // Горизонтальний крок: (1,2)g → (1,3)r  [горизонтальний]
    // Частина 3: вниз-праворуч  (1,3)r → (2,4)g → (3,5)w → (4,6)b → (5,7)w=B
    _p(grid, 7, 0, b); // A — старт
    _p(grid, 6, 1, w);
    _p(grid, 5, 2, g);
    _p(grid, 4, 3, r); // ← кінець частини 1
    _p(grid, 3, 2, g); // ← поворот ліворуч-вгору!
    _p(grid, 2, 1, w);
    _p(grid, 1, 2, g); // ← вгору-праворуч
    _p(grid, 1, 3, r); // ← горизонтальний крок
    _p(grid, 2, 4, g); // ← вниз-праворуч
    _p(grid, 3, 5, w);
    _p(grid, 4, 6, b);
    _p(grid, 5, 7, w); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 7, 1, w); // adj A: b→w ✓
    _p(grid, 6, 0, w); // adj A: b→w ✓ інший бік
    _p(grid, 6, 2, g); // adj step2: w→g ✓
    _p(grid, 5, 1, r); // adj step3: g→r ✓ ловить тих хто не зробить поворот
    _p(grid, 5, 3, w); // adj step3: g→w ✓ вабить продовжити діагональ
    _p(grid, 4, 4, g); // adj step4: r→g ✓ манить вгору-праворуч замість повороту
    _p(grid, 3, 3, w); // adj поворот: g→w ✓ дуже близько до шляху!
    _p(grid, 3, 1, r); // adj поворот: g→r ✓ тупик
    _p(grid, 2, 0, b); // adj step6: w→b ✓ тупик
    _p(grid, 2, 2, b); // adj step6: w→b ✓ інший тупик
    _p(grid, 1, 1, r); // adj step7: g→r ✓ ловить тих хто не зробить горизонт. крок
    _p(grid, 1, 4, g); // adj step8: r→g ✓ манить праворуч замість вниз
    _p(grid, 2, 3, r); // adj step9: g→r ✓ дуже близько до шляху
    _p(grid, 3, 4, b); // adj step10: w→b ✓
    _p(grid, 4, 5, r); // adj step11: b→r diff=3 ЗАБОРОНЕНО / adj step10: w→r diff=2

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 7, 2, g);
    _p(grid, 7, 3, r);
    _p(grid, 7, 4, w);
    _p(grid, 7, 5, b);
    _p(grid, 7, 6, w);
    _p(grid, 7, 7, g);
    _p(grid, 6, 3, b);
    _p(grid, 6, 4, w);
    _p(grid, 6, 5, g);
    _p(grid, 6, 6, r);
    _p(grid, 6, 7, g);
    _p(grid, 5, 4, b);
    _p(grid, 5, 5, r);
    _p(grid, 5, 6, g);
    _p(grid, 0, 0, r);

    return grid; // 12+15+15 = 42/64 = 65.6%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
