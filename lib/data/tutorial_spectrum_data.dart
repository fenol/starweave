import '../models/star_model.dart';
import '../models/level_model.dart';

// Підказка що з'являється на певному кроці туторіалу
class TutorialHint {
  final int afterStep;        // після скількох кроків показати
  final String text;          // текст підказки
  final List<(int, int)> highlightCells; // клітинки що підсвічуємо

  const TutorialHint({
    required this.afterStep,
    required this.text,
    this.highlightCells = const [],
  });
}

// Дані туторіального рівня "Спектральний ряд"
class TutorialSpectrumData {

  // Кольори спектрів для зручності
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  // Сітка 7×7
  // Правильний шлях: (5,0)→(4,1)→(3,2)→(2,3)→(1,4)→(0,5)
  //   blue → white → gold → red → gold → white=B
  //
  // ПРАВИЛО: кожен крок рівно ±1 по спектру.
  // Однаковий спектр двічі поспіль — ЗАБОРОНЕНО (різниця = 0).
  // Перескок через клас — ЗАБОРОНЕНО (різниця = 2+).
  static List<List<GridStar?>> buildGrid() {
    final grid = List.generate(
      7,
      (row) => List<GridStar?>.filled(7, null),
    );

    // ── Зірки правильного шляху ──────────────────────────────
    _place(grid, 5, 0, b); // A — старт     (синій)
    _place(grid, 4, 1, w); // крок 2        (білий)    blue→white  ✓
    _place(grid, 3, 2, g); // крок 3        (золотий)  white→gold  ✓
    _place(grid, 2, 3, r); // крок 4        (червоний) gold→red    ✓
    _place(grid, 1, 4, g); // крок 5        (золотий)  red→gold    ✓
    _place(grid, 0, 5, w); // B — фініш     (білий)    gold→white  ✓

    // ── Зірки-пастки ─────────────────────────────────────────
    _place(grid, 5, 2, g); // пастка біля A — золотий (не сусідній з синім)
    _place(grid, 4, 3, r); // пастка — червоний (перескок з білого)
    _place(grid, 3, 0, r); // пастка — червоний далеко від шляху
    _place(grid, 2, 5, b); // пастка — синій (надто далеко назад)
    _place(grid, 1, 2, b); // пастка — синій (неправильний спектр)
    _place(grid, 0, 3, r); // пастка біля B — червоний (не сусідній з білим B)
    _place(grid, 3, 4, w); // додаткова пастка
    _place(grid, 6, 1, g); // пастка внизу

    return grid;
  }

  static void _place(
    List<List<GridStar?>> grid,
    int row, int col,
    StarSpectrum spectrum, {
    StarType type = StarType.normal,
    StarSpectrum? second,
  }) {
    grid[row][col] = GridStar(
      row: row,
      col: col,
      spectrum: spectrum,
      type: type,
      secondSpectrum: second,
    );
  }

  static LevelData get level => LevelData(
    levelNumber: 0,
    totalLevels: 7,
    greekLetter: '',
    starName: 'Туторіал',
    starNameLatin: 'Tutorial',
    constellation: 'Велика Ведмедиця',
    goalText: 'Прокладіть шлях від А до В, змінюючи спектр поступово',
    pathLength: 6,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ТУТОРІАЛ',
    hint: 'СПЕКТР · ЛИШЕ СУСІДНІ КЛАСИ',
    grid: buildGrid(),
    startPos: (5, 0),
    endPos: (0, 5),
  );

  // Підказки: text показується ПІСЛЯ того як гравець зробив крок afterStep
  // afterStep: 0 = одразу на початку, 1 = після A, 2 = після 2-ї зірки, ...
  static const List<TutorialHint> hints = [
    TutorialHint(
      afterStep: 0,
      text: 'Знайди зірку А — вона світиться синім.\nТоркнись її щоб почати шлях.',
      highlightCells: [(5, 0)],
    ),
    TutorialHint(
      afterStep: 1,
      text: 'Синій → Білий.\nСпектр змінюється лише на один крок.',
      highlightCells: [(4, 1)],
    ),
    TutorialHint(
      afterStep: 2,
      text: 'Білий → Золотий.\nПродовжуй рухатись по спектральному ряду.',
      highlightCells: [(3, 2)],
    ),
    TutorialHint(
      afterStep: 3,
      text: 'Золотий → Червоний.\nОднаковий спектр двічі поспіль — заборонено!',
      highlightCells: [(2, 3)],
    ),
    TutorialHint(
      afterStep: 4,
      text: 'Червоний → Золотий.\nМожна рухатись і вперед, і назад по ряду.',
      highlightCells: [(1, 4)],
    ),
    TutorialHint(
      afterStep: 5,
      text: 'Золотий → Білий.\nДійди до зірки В щоб завершити шлях!',
      highlightCells: [(0, 5)],
    ),
  ];
}
