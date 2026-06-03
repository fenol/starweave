import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 6 · α Dubhe · 8×7 · pathLength=11
/// Складність: СКЛАДНО
/// Форма: V-подібна — іде вгору-праворуч до краю, потім повертає вниз-ліворуч
/// Спектр: red → gold → white → blue → white → gold → red → gold → white → blue → white
class UrsaMajorLevel6 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 6,
    totalLevels: 7,
    greekLetter: 'α',
    starName: 'Дубге',
    starNameLatin: 'Dubhe',
    constellation: 'Велика Ведмедиця',
    goalText: 'Шлях у формі V — знайди вершину',
    pathLength: 11,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ФОРМА V · ШЛЯХ ПІДІЙМАЄТЬСЯ І СПУСКАЄТЬСЯ',
    grid: _buildGrid(),
    startPos: (7, 0),
    endPos: (4, 2),
  );

  static List<List<GridStar?>> _buildGrid() {
    // Сітка 8 рядків × 7 стовпців
    final grid = List.generate(8, (_) => List<GridStar?>.filled(7, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    // Діагональ вгору-праворуч до (1,6)r — вершина V
    // Горизонтальний крок ліворуч: (1,6)r → (1,5)g
    // Діагональ вниз-ліворуч до B(4,2)w
    _p(grid, 7, 0, r); // A — старт
    _p(grid, 6, 1, g);
    _p(grid, 5, 2, w);
    _p(grid, 4, 3, b);
    _p(grid, 3, 4, w);
    _p(grid, 2, 5, g);
    _p(grid, 1, 6, r); // ← вершина V
    _p(grid, 1, 5, g); // ← поворот горизонтальний
    _p(grid, 2, 4, w); // ← спуск вниз-ліворуч
    _p(grid, 3, 3, b);
    _p(grid, 4, 2, w); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 7, 1, g); // adj A: r→g ✓
    _p(grid, 6, 0, g); // adj A: r→g ✓ інший напрямок
    _p(grid, 6, 2, w); // adj step2: g→w ✓
    _p(grid, 5, 1, g); // adj step3: w→g ✓
    _p(grid, 5, 3, b); // adj step3: w→b ✓ тупик праворуч
    _p(grid, 4, 4, w); // adj step4: b→w ✓ манить продовжити діагональ замість V
    _p(grid, 3, 5, r); // adj step5: w→r diff=2 ЗАБОРОНЕНО
    _p(grid, 2, 6, b); // adj step6: g→b diff=2 ЗАБОРОНЕНО
    _p(grid, 1, 4, w); // adj поворот: g→w ✓ тупик — від w важко до B(w)
    _p(grid, 3, 2, g); // adj step9: b→g diff=2 ЗАБОРОНЕНО / w→g ✓ від (3,3)
    _p(grid, 4, 1, g); // adj B: w→g ✓ заманює перед фінішем
    _p(grid, 4, 5, r); // adj step5: w→r diff=2 ЗАБОРОНЕНО

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 7, 2, b);
    _p(grid, 7, 3, w);
    _p(grid, 7, 4, g);
    _p(grid, 7, 5, r);
    _p(grid, 7, 6, b);
    _p(grid, 6, 3, r);
    _p(grid, 6, 4, b);
    _p(grid, 6, 5, w);
    _p(grid, 6, 6, g);
    _p(grid, 5, 5, r);
    _p(grid, 5, 6, w);
    _p(grid, 0, 1, g);
    _p(grid, 0, 3, r);
    _p(grid, 0, 5, b);

    return grid; // 11+12+14 = 37/56 = 66.1%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
