import '../models/star_model.dart';
import '../models/level_model.dart';
import 'tutorial_spectrum_data.dart';

// Дані туторіального рівня "Бінарна зірка"
class TutorialBinaryData {

  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  // Сітка 6×6
  // Правильний шлях: (5,0)b → (4,1)w → (3,2)BIN(g/r) → (2,3)r → (1,4)B(g)
  // Спектри: синій → білий → БІНАРНА(gold) → червоний → золотий=B
  //
  // Бінарна увійде у шлях як gold (білий→золотий ±1).
  // Якщо гравець натисне ще раз — переключиться на red (білий→червоний diff=2 → помилка).
  // Ще раз — повернеться до gold → шлях чистий.
  static List<List<GridStar?>> buildGrid() {
    final grid = List.generate(6, (row) => List<GridStar?>.filled(6, null));

    // ── Зірки правильного шляху ──────────────────────────────────────────────
    _place(grid, 5, 0, b);                                       // A — старт (синій)
    _place(grid, 4, 1, w);                                       // білий
    _place(grid, 3, 2, g, type: StarType.binary, second: r);    // БІНАРНА gold↔red
    _place(grid, 2, 3, r);                                       // червоний
    _place(grid, 1, 4, g);                                       // B — фініш (золотий)

    // ── Зірки-пастки ─────────────────────────────────────────────────────────
    _place(grid, 5, 2, g); // синій→золотий diff=2, недійсно
    _place(grid, 4, 3, r); // білий→червоний diff=2, недійсно
    _place(grid, 2, 1, w); // від бінарної(gold)→білий ✓, але тупик
    _place(grid, 1, 2, b); // червоний→синій diff=3, недійсно
    _place(grid, 3, 4, b); // бінарна→синій diff=3, недійсно
    _place(grid, 0, 3, r); // заповнювач

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
    constellation: 'Кассіопея',
    goalText: 'Прокладіть шлях через бінарну зірку від А до В',
    pathLength: 5,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ТУТОРІАЛ',
    hint: 'БІНАРНА · НАТИСНИ ЩЕ РАЗ ЩОБ ЗМІНИТИ',
    grid: buildGrid(),
    startPos: (5, 0),
    endPos: (1, 4),
  );

  // Підказки: afterStep = кількість зірок вже в шляху
  static const List<TutorialHint> hints = [
    TutorialHint(
      afterStep: 0,
      text: 'Зірка А — синя.\nТоркнись її щоб почати шлях.',
      highlightCells: [(5, 0)],
    ),
    TutorialHint(
      afterStep: 1,
      text: 'Синій → Білий.\nСпектр змінюється лише на ±1 крок.',
      highlightCells: [(4, 1)],
    ),
    TutorialHint(
      afterStep: 2,
      text: 'Попереду — бінарна зірка!\nВона показує лише половину свого кольору.\nТоркнись її.',
      highlightCells: [(3, 2)],
    ),
    TutorialHint(
      afterStep: 3,
      text: 'Бінарна увійшла у шлях як золота.\nТоркнись її ще раз — вона зміниться!\nПоверни назад якщо з\'явиться помилка.',
      highlightCells: [(3, 2)],
    ),
    TutorialHint(
      afterStep: 4,
      text: 'Тепер продовжуй! Червоний → Золотий.\nДійди до зірки В щоб завершити шлях.',
      highlightCells: [(1, 4)],
    ),
  ];
}
