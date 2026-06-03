import '../models/star_model.dart';
import '../models/level_model.dart';
import 'tutorial_spectrum_data.dart';

// Туторіал «Стрибки» — демонструє всі три типи стрибків
class TutorialJumpData {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  // Сітка 5×5
  // Правильний шлях (ЛИШЕ стрибки, жодного суміжного кроку):
  //   A(4,0)w →[діаг. стрибок, порожньо (3,1)]→ g(2,2)
  //            →[гориз. стрибок, порожньо (2,1)]→ r(2,0)
  //            →[верт. стрибок,  порожньо (1,0)]→ B(g)(0,0)
  static List<List<GridStar?>> buildGrid() {
    final grid = List.generate(5, (_) => List<GridStar?>.filled(5, null));

    // ── Правильний шлях ──────────────────────────────────────────────────────
    _p(grid, 4, 0, w); // A — старт (білий)
    _p(grid, 2, 2, g); // крок 2 · діагональний стрибок · white→gold ✓
    _p(grid, 2, 0, r); // крок 3 · горизонтальний стрибок · gold→red ✓
    _p(grid, 0, 0, g); // B — фініш · вертикальний стрибок · red→gold ✓

    // ── Пастки ───────────────────────────────────────────────────────────────
    _p(grid, 4, 2, b); // від A — горизонт. стрибок, white→blue ✓, але тупик
    _p(grid, 2, 4, b); // від g(2,2) — горизонт. стрибок, gold→blue diff=2 ✗
    _p(grid, 3, 3, g); // від g(2,2) — недосяжний (відстань 1+3, не стрибок)
    _p(grid, 1, 3, w); // заповнювач (важко досягти коректним шляхом)

    return grid;
  }

  static void _p(List<List<GridStar?>> grid, int row, int col, StarSpectrum s) {
    grid[row][col] = GridStar(row: row, col: col, spectrum: s);
  }

  static LevelData get level => LevelData(
    levelNumber: 0,
    totalLevels: 7,
    greekLetter: '',
    starName: 'Туторіал',
    starNameLatin: 'Tutorial',
    constellation: 'Велика Ведмедиця',
    goalText: 'Стрибай через порожні клітинки від А до В',
    pathLength: 4,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ТУТОРІАЛ',
    hint: 'СТРИБОК · ПОРОЖНЄ МІСЦЕ МІЖ ЗІРКАМИ',
    grid: buildGrid(),
    startPos: (4, 0),
    endPos: (0, 0),
  );

  static const List<TutorialHint> hints = [
    TutorialHint(
      afterStep: 0,
      text: 'Нова механіка — вперше у розділі ПЕРСЕЙ.\nЯкщо між двома зірками порожньо — можна стрибнути через це місце!\nЗнайди зірку А і торкнись її.',
      highlightCells: [(4, 0)],
    ),
    TutorialHint(
      afterStep: 1,
      text: 'Стрибок по діагоналі! ↗\nДві клітинки по діагоналі через порожнє місце.\nБілий → Золотий.',
      highlightCells: [(2, 2)],
    ),
    TutorialHint(
      afterStep: 2,
      text: 'Стрибок по горизонталі! →\nДві клітинки по прямій через порожнє місце.\nЗолотий → Червоний.',
      highlightCells: [(2, 0)],
    ),
    TutorialHint(
      afterStep: 3,
      text: 'Стрибок по вертикалі! ↑\nДві клітинки вертикально через порожнє місце.\nЧервоний → Золотий. Дійди до В!',
      highlightCells: [(0, 0)],
    ),
  ];
}
