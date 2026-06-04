import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 3 · β Merak · 7×6 · pathLength=8
/// Складність: ЛЕГКО+
/// Форма: два повороти — горизонтальний і вертикальний
/// Спектр: white → gold → red → gold → white → blue → white → gold
class UrsaMajorLevel3 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 3,
    totalLevels: 7,
    greekLetter: 'γ',
    starName: 'Фекда',
    starNameLatin: 'Phecda',
    constellation: 'Велика Ведмедиця',
    goalText: 'Знайди шлях від А до В',
    pathLength: 8,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО+',
    hint: 'ДВА ПОВОРОТИ · СТЕЖ ЗА СПЕКТРОМ',
    grid: _buildGrid(),
    startPos: (6, 0),
    endPos: (0, 2),
  );

  static List<List<GridStar?>> _buildGrid() {
    // Сітка 7 рядків × 6 стовпців
    final grid = List.generate(7, (_) => List<GridStar?>.filled(6, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    // (6,0)w → (5,1)g → (4,2)r
    //   Поворот 1: (4,2)r → (4,3)g  [горизонтальний]
    // (4,3)g → (3,4)w
    //   Поворот 2: (3,4)w → (2,4)b  [вертикальний]
    // (2,4)b → (1,3)w → (0,2)g=B
    _p(grid, 6, 0, w); // A — старт
    _p(grid, 5, 1, g);
    _p(grid, 4, 2, r);
    _p(grid, 4, 3, g); // ← поворот 1
    _p(grid, 3, 4, w);
    _p(grid, 2, 4, b); // ← поворот 2
    _p(grid, 1, 3, w);
    _p(grid, 0, 2, g); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 6, 1, g); // adj A: w→g ✓
    _p(grid, 5, 0, r); // adj A: w→r diff=2 ЗАБОРОНЕНО — пастка неправильного спектру
    _p(grid, 5, 2, w); // adj step2: g→w ✓ мимо
    _p(grid, 4, 1, g); // adj step3: r→g ✓ ловить тих хто поверне вліво
    _p(grid, 3, 3, r); // adj поворот1: g→r ✓ спокуса продовжити діагональ
    _p(grid, 4, 4, w); // adj поворот1: g→w ✓ інший бік від правильного шляху
    _p(grid, 3, 5, g); // adj step5: w→g ✓ але веде в кут
    _p(grid, 1, 4, b); // adj step6: b→b ЗАБОРОНЕНО або adj step7: w→b ✓ тупик
    _p(grid, 0, 3, w); // adj B: g→w ✓ але відволікає від B
    _p(grid, 1, 2, b); // adj B: від w(1,3) w→b ✓ але далі від B важко

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 6, 2, b);
    _p(grid, 6, 3, r);
    _p(grid, 6, 4, w);
    _p(grid, 6, 5, g);
    _p(grid, 5, 3, b);
    _p(grid, 5, 4, g);
    _p(grid, 5, 5, r);
    _p(grid, 3, 1, r);
    _p(grid, 2, 0, w);
    _p(grid, 0, 0, r);

    return grid; // 8+10+10 = 28/42 = 66.7%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
