import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 5 · η Alkaid · 7×7 · pathLength=10
/// Складність: СЕРЕДНЬО+
/// Форма: шлях іде вгору-праворуч, потім ПОВЕРТАЄ НАЗАД вниз
/// Спектр: gold → red → gold → white → blue → white → gold → red → gold → white
class UrsaMajorLevel5 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 5,
    totalLevels: 7,
    greekLetter: 'η',
    starName: 'Алькаїд',
    starNameLatin: 'Alkaid',
    constellation: 'Велика Ведмедиця',
    goalText: 'Шлях повертає — не йди прямо',
    pathLength: 10,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СЕРЕДНЬО+',
    hint: 'ШЛЯХ ПОВЕРТАЄ НАЗАД · ПЛАНУЙ ЗАЗДАЛЕГІДЬ',
    grid: _buildGrid(),
    startPos: (6, 1),
    endPos: (1, 0),
  );

  static List<List<GridStar?>> _buildGrid() {
    // Сітка 7×7
    final grid = List.generate(7, (_) => List<GridStar?>.filled(7, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    // Іде діагонально вгору-праворуч до (2,5)b
    // Потім горизонтальний крок вліво: (2,5)b → (2,4)w
    // Потім ПОВЕРТАЄ ВНИЗ: (2,4)w → (3,3)g → (3,2)r
    // Потім знову вгору-ліворуч: (3,2)r → (2,1)g → (1,0)w=B
    _p(grid, 6, 1, g); // A — старт
    _p(grid, 5, 2, r);
    _p(grid, 4, 3, g);
    _p(grid, 3, 4, w);
    _p(grid, 2, 5, b);
    _p(grid, 2, 4, w); // ← горизонтальний крок (поворот)
    _p(grid, 3, 3, g); // ← повертає ВНИЗ (несподівано!)
    _p(grid, 3, 2, r);
    _p(grid, 2, 1, g);
    _p(grid, 1, 0, w); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 6, 0, r); // adj A: g→r ✓ не той напрямок
    _p(grid, 6, 2, w); // adj A: g→w ✓ не той напрямок
    _p(grid, 5, 1, g); // adj step2: r→g ✓ ловить того хто не піде вгору
    _p(grid, 5, 3, w); // adj step2: r→w diff=2 ЗАБОРОНЕНО — пастка спектру
    _p(grid, 4, 4, r); // adj step3: g→r ✓ спокуса продовжити діагональ
    _p(grid, 4, 2, w); // adj step3: g→w ✓ інший бік
    _p(grid, 3, 5, g); // adj step4: w→g ✓ спокуса продовжити вгору-праворуч
    _p(grid, 2, 3, b); // adj поворот: w→b ✓ дуже близько до шляху!
    _p(grid, 3, 1, w); // adj step8: r→w diff=2 ЗАБОРОНЕНО
    _p(grid, 2, 0, r); // adj step9: g→r ✓ веде в тупик біля B
    _p(grid, 1, 1, g); // adj B: w→g ✓ заманює перед фінішем

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 6, 3, b);
    _p(grid, 6, 4, w);
    _p(grid, 6, 5, r);
    _p(grid, 6, 6, g);
    _p(grid, 5, 4, g);
    _p(grid, 5, 5, w);
    _p(grid, 5, 6, b);
    _p(grid, 4, 5, w);
    _p(grid, 4, 0, b);
    _p(grid, 0, 2, g);
    _p(grid, 0, 4, r);

    return grid; // 10+11+11 = 32/49 = 65.3%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
