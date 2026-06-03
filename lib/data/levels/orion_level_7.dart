import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 7 · β Rigel · 12×12 · pathLength=18
/// Складність: СКЛАДНО
/// Форма: діагональ з лівого верхнього кута до центру, вертикаль, поворот,
///        діагональ до правого нижнього кута — повний хрест сітки
/// Спектр: g→r→g→w→b→w→g→r→g→w→b→w→g→r→g→w→b→w
class OrionLevel7 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 7,
    totalLevels: 7,
    greekLetter: 'β',
    starName: 'Рігель',
    starNameLatin: 'Rigel',
    constellation: 'Оріон',
    goalText: 'Прокладіть шлях від А до В',
    pathLength: 18,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'З КУТА ДО КУТА · ШЛЯХ ЛАМАЄТЬСЯ ДВІЧІ',
    grid: _buildGrid(),
    startPos: (0, 0),
    endPos: (11, 11),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(12, (_) => List<GridStar?>.filled(12, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    _p(grid, 0, 0, g);  // A — лівий верхній кут
    _p(grid, 1, 1, r);
    _p(grid, 2, 2, g);
    _p(grid, 3, 3, w);
    _p(grid, 4, 4, b);
    _p(grid, 5, 5, w);
    _p(grid, 6, 5, g);  // ← перший поворот: вертикаль вниз
    _p(grid, 7, 5, r);
    _p(grid, 7, 6, g);  // ← другий поворот: горизонталь
    _p(grid, 7, 7, w);
    _p(grid, 8, 8, b);  // ← відновлюємо діагональ вниз-праворуч
    _p(grid, 9, 9, w);
    _p(grid, 10, 8, g); // ← ще один зиґзаґ: ліворуч-вниз
    _p(grid, 11, 7, r);
    _p(grid, 11, 8, g); // ← горизонталь до кута
    _p(grid, 11, 9, w);
    _p(grid, 11, 10, b);
    _p(grid, 11, 11, w); // B — правий нижній кут

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 0, 1, r);   // adj A: g→r ✓ — горизонталь
    _p(grid, 1, 0, r);   // adj A: g→r ✓ — вертикаль
    _p(grid, 2, 1, w);   _p(grid, 1, 2, w);   // adj step2: r→w diff=2 — ЗАБЛОКОВАНО
    _p(grid, 3, 2, g);   _p(grid, 2, 3, g);   // adj step3: g→g diff=0 — заблоковано
    _p(grid, 4, 3, w);   _p(grid, 3, 4, w);   // adj step4: w→w diff=0 — заблоковано
    _p(grid, 5, 4, b);   _p(grid, 4, 5, b);   // adj step5: b→b diff=0 — заблоковано
    _p(grid, 6, 6, r);   _p(grid, 5, 6, g);   // adj step6: w→g ✓ та w→r diff=2 ЗАБЛОКОВАНО
    _p(grid, 7, 4, g);   _p(grid, 6, 4, b);   // adj step7: r→g ✓ — минає поворот
    _p(grid, 8, 5, b);   _p(grid, 7, 8, r);   // adj step9: w→b та w→r diff=2 ЗАБЛОКОВАНО
    _p(grid, 9, 7, b);   _p(grid, 8, 9, w);   // adj step10
    _p(grid, 9, 8, b);   _p(grid, 10, 9, r);  // adj step11
    _p(grid, 10, 7, w);  _p(grid, 11, 6, g);  // adj step13: r→g ✓ зиґзаґ
    _p(grid, 10, 10, b); _p(grid, 11, 10, b); // adj step14 (b вже на шляху!)

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 0, 3, b);  _p(grid, 0, 5, w);  _p(grid, 0, 7, r);  _p(grid, 0, 9, g);
    _p(grid, 0, 11, b);
    _p(grid, 1, 4, g);  _p(grid, 1, 6, b);  _p(grid, 1, 8, w);  _p(grid, 1, 10, r);
    _p(grid, 2, 5, r);  _p(grid, 2, 7, g);  _p(grid, 2, 9, b);  _p(grid, 2, 11, w);
    _p(grid, 3, 6, b);  _p(grid, 3, 8, r);  _p(grid, 3, 10, w); _p(grid, 3, 11, g);
    _p(grid, 4, 7, w);  _p(grid, 4, 9, g);  _p(grid, 4, 11, r);
    _p(grid, 5, 8, r);  _p(grid, 5, 10, b); _p(grid, 5, 11, g);
    _p(grid, 6, 7, w);  _p(grid, 6, 9, b);  _p(grid, 6, 10, g); _p(grid, 6, 11, r);
    _p(grid, 7, 9, b);  _p(grid, 7, 10, g); _p(grid, 7, 11, w);
    _p(grid, 8, 0, r);  _p(grid, 8, 2, w);  _p(grid, 8, 4, g);  _p(grid, 8, 6, r);
    _p(grid, 8, 10, r); _p(grid, 8, 11, g);
    _p(grid, 9, 0, g);  _p(grid, 9, 2, b);  _p(grid, 9, 4, w);  _p(grid, 9, 6, g);
    _p(grid, 9, 11, b);
    _p(grid, 10, 0, b); _p(grid, 10, 2, r); _p(grid, 10, 4, g); _p(grid, 10, 6, b);
    _p(grid, 10, 11, r);
    _p(grid, 11, 0, w); _p(grid, 11, 1, b); _p(grid, 11, 2, g); _p(grid, 11, 3, r);
    _p(grid, 11, 5, w);

    return grid; // 18+22+44 = 84/144 = 58%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
