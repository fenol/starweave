import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 2 · γ Phecda · 6×6 · pathLength=7
/// Складність: ЛЕГКО
/// Форма: діагональ + 1 горизонтальний поворот посередині
/// Спектр: blue → white → gold → red → gold → white → blue
class UrsaMajorLevel2 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 2,
    totalLevels: 7,
    greekLetter: 'γ',
    starName: 'Фекда',
    starNameLatin: 'Phecda',
    constellation: 'Велика Ведмедиця',
    goalText: 'Один поворот прихований у сітці',
    pathLength: 7,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'ШЛЯХ ЗМІНЮЄ НАПРЯМОК · ШУКАЙ ПОВОРОТ',
    grid: _buildGrid(),
    startPos: (5, 0),
    endPos: (0, 3),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(6, (_) => List<GridStar?>.filled(6, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    // b→w→g→r  (діагональ вгору-праворуч)
    //          → поворот: (3,3)r→(2,4)g
    //          → g→w→b  (продовження вгору)
    _p(grid, 5, 0, b); // A — старт
    _p(grid, 4, 1, w);
    _p(grid, 3, 2, g);
    _p(grid, 3, 3, r); // ← поворот (горизонтальний крок)
    _p(grid, 2, 4, g);
    _p(grid, 1, 4, w);
    _p(grid, 0, 3, b); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 5, 1, w); // adj A: b→w ✓
    _p(grid, 4, 0, w); // adj A: b→w ✓ інший бік
    _p(grid, 4, 2, g); // adj step2: w→g ✓ мимо шляху
    _p(grid, 3, 1, b); // adj step2: w→b ✓ → від b важко потрапити до (3,2)g
    _p(grid, 2, 2, r); // adj turn: g→r ✓ ловить гравця що пішов в інший бік
    _p(grid, 4, 3, r); // adj turn area: від g(3,2) r→? g→r ✓ але не поворот
    _p(grid, 3, 4, r); // adj after turn: від r(3,3) r→r ЗАБОРОНЕНО — добра пастка
    _p(grid, 2, 3, g); // adj step5: r→g ✓ близько до шляху але відводить
    _p(grid, 1, 3, g); // adj step6: w→g ✓ прямо над поворотом — тупик до B
    _p(grid, 1, 5, g); // adj step5: g→g ЗАБОРОНЕНО з шляху
    _p(grid, 0, 4, w); // adj B: b→w ЗАБОРОНЕНО diff=1 але інша сторона

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 5, 3, g);
    _p(grid, 5, 4, r);
    _p(grid, 4, 5, b);
    _p(grid, 3, 5, w);
    _p(grid, 2, 5, b);
    _p(grid, 1, 0, r);
    _p(grid, 0, 1, g);

    return grid; // 7+11+7 = 25/36 = 69.4%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
