import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 5 · κ Saiph · 12×12 · pathLength=15
/// Складність: СКЛАДНО
/// Форма: діагональ з правого нижнього кута до центру, потім вертикаль,
///        потім горизонталь — стрілка вправо
/// Спектр: r→g→w→b→w→g→r→g→w→b→w→g→r→g→w
class OrionLevel5 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 5,
    totalLevels: 7,
    greekLetter: 'ε',
    starName: 'Альнілам',
    starNameLatin: 'Alnilam',
    constellation: 'Оріон',
    goalText: 'Знайди шлях від А до В',
    pathLength: 15,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'З КУТА ДО ЦЕНТРУ · ПОТІМ ВЛіВО ВГОРУ',
    grid: _buildGrid(),
    startPos: (11, 11),
    endPos: (0, 7),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(12, (_) => List<GridStar?>.filled(12, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    _p(grid, 11, 11, r); // A — старт
    _p(grid, 10, 10, g);
    _p(grid, 9, 9, w);
    _p(grid, 8, 8, b);
    _p(grid, 7, 7, w);
    _p(grid, 6, 6, g);
    _p(grid, 5, 5, r);
    _p(grid, 4, 4, g);
    _p(grid, 3, 3, w);
    _p(grid, 2, 3, b); // ← вертикальний крок (не діагональ!)
    _p(grid, 1, 3, w);
    _p(grid, 0, 4, g); // ← тепер діагональ праворуч-вгору
    _p(grid, 0, 5, r); // ← горизонталь до B
    _p(grid, 0, 6, g);
    _p(grid, 0, 7, w); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 11, 10, g);  // adj A: r→g ✓
    _p(grid, 10, 11, g);  // adj A: r→g ✓ — веде вбік
    _p(grid, 10, 9, w);   _p(grid, 9, 10, g);  // adj step2
    _p(grid, 9, 8, b);    _p(grid, 8, 9, w);   // adj step3
    _p(grid, 8, 7, w);    _p(grid, 7, 8, b);   // adj step4
    _p(grid, 7, 6, g);    _p(grid, 6, 7, r);   // adj step5: пастка
    _p(grid, 6, 5, r);    _p(grid, 5, 6, g);   // adj step6
    _p(grid, 5, 4, g);    _p(grid, 4, 5, r);   // adj step7
    _p(grid, 4, 3, w);    _p(grid, 3, 4, b);   // adj step8
    _p(grid, 3, 2, b);    _p(grid, 2, 4, w);   // adj step9
    _p(grid, 2, 2, w);    _p(grid, 1, 2, b);   // adj step10
    _p(grid, 1, 4, g);    _p(grid, 0, 3, b);   // adj step11: b→g diff=2 — ЗАБЛОКОВАНО
    _p(grid, 0, 8, b);    _p(grid, 0, 5, r);   // adj B (r вже є на шляху!)

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 11, 0, b);  _p(grid, 11, 2, w);  _p(grid, 11, 4, g); _p(grid, 11, 6, r);
    _p(grid, 11, 8, w);
    _p(grid, 10, 1, r);  _p(grid, 10, 3, b);  _p(grid, 10, 5, g); _p(grid, 10, 7, w);
    _p(grid, 9, 0, g);   _p(grid, 9, 2, r);   _p(grid, 9, 4, w);  _p(grid, 9, 6, b);
    _p(grid, 8, 1, w);   _p(grid, 8, 3, g);   _p(grid, 8, 5, r);  _p(grid, 8, 6, g);
    _p(grid, 7, 1, b);   _p(grid, 7, 3, r);   _p(grid, 7, 5, b);
    _p(grid, 6, 1, w);   _p(grid, 6, 3, g);   _p(grid, 6, 8, b);  _p(grid, 6, 10, r);
    _p(grid, 5, 0, r);   _p(grid, 5, 2, w);   _p(grid, 5, 8, w);  _p(grid, 5, 10, g);
    _p(grid, 4, 0, g);   _p(grid, 4, 1, b);   _p(grid, 4, 9, r);  _p(grid, 4, 11, b);
    _p(grid, 3, 0, b);   _p(grid, 3, 1, w);   _p(grid, 3, 9, b);  _p(grid, 3, 11, g);
    _p(grid, 2, 0, w);   _p(grid, 2, 1, g);   _p(grid, 2, 9, g);  _p(grid, 2, 11, r);
    _p(grid, 1, 0, g);   _p(grid, 1, 1, r);   _p(grid, 1, 9, w);  _p(grid, 1, 10, b);
    _p(grid, 0, 0, r);   _p(grid, 0, 1, w);   _p(grid, 0, 2, g);  _p(grid, 0, 9, g);
    _p(grid, 0, 10, w);  _p(grid, 0, 11, b);

    return grid; // 15+22+42 = 79/144 = 55%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
