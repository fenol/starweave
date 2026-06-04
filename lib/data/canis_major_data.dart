import '../models/constellation_model.dart';

/// Розділ 7 — Великий Пес (Canis Major)
///
/// 6 зірок: α Sirius (0) · β Mirzam (1) · γ Muliphein (2)
///          δ Wezen (3) · ε Adhara (4) · η Aludra (5)
class CanisMajorData {
  static final ConstellationChapter chapter = ConstellationChapter(
    name: 'Великий Пес',
    nameLatin: 'Canis Major',
    mythQuote:
        '«Сіріус сходить із Сонцем — і Ніл виходить із берегів. '
        'Єгиптяни знали: Пес приносить воду й життя.»',
    storyTitle: 'Зоря Пса',
    storyOnCompletion: false,
    story:
        'Сіріус — найяскравіша зірка всього нічного неба. '
        'Її блиск настільки разючий, що в ясні зимові ночі вона кидає тіні. '
        'Греки називали її Кyon — Пес — і боялися її сходу в розпал літа.\n\n'
        'Стародавні єгиптяни спостерігали за Сіріусом ретельніше, '
        'ніж за будь-якою іншою зіркою. Вони назвали її Сопдет '
        'і уособили з богинею родючості. Раз на рік, після кількох '
        'тижнів невидимості, Сіріус знову з\'являвся на сході '
        'перед самим сходом сонця — і в той же день Ніл починав розливатися. '
        'Це означало кінець посухи й початок нового аграрного року.\n\n'
        'Для греків і римлян Пес з\'являвся в найспекотніші дні серпня. '
        'Сенеку і Вергілія «собачі дні» (dies caniculares) '
        'наповнювали тривогою: вважалося, що саме Сіріус додає жару Сонцю, '
        'викликає хвороби, псує вино й зводить людей з розуму.\n\n'
        'У грецькій міфології Великий Пес — один із двох мисливських псів Оріона. '
        'Разом із Малим Псом він вічно біжить за своїм господарем '
        'через зоряне небо, а Оріон вічно переслідує Зайця.\n\n'
        'Сіріус насправді є подвійною зоряною системою: '
        'Сіріус А — гарячий білий гігант, '
        'Сіріус Б — крихітний білий карлик розміром із Землю '
        'і масою, як у Сонця. Вони обертаються один навколо одного '
        'кожні 50 років.',
    stars: [
      // ─── Рівень 1 · α Sirius · найлегший ─────────────────────────────────
      ConstellationStar(
        name: 'Сіріус', nameLatin: 'Sirius', greekLetter: 'α',
        x: 0.35, y: 0.22, levelIndex: 0, isUnlocked: true,
      ),
      // ─── Рівень 2 · β Mirzam ──────────────────────────────────────────────
      ConstellationStar(
        name: 'Мірзам', nameLatin: 'Mirzam', greekLetter: 'β',
        x: 0.14, y: 0.38, levelIndex: 1,
      ),
      // ─── Рівень 3 · γ Muliphein ───────────────────────────────────────────
      ConstellationStar(
        name: 'Муліфейн', nameLatin: 'Muliphein', greekLetter: 'γ',
        x: 0.60, y: 0.18, levelIndex: 2,
      ),
      // ─── Рівень 4 · δ Wezen ───────────────────────────────────────────────
      ConstellationStar(
        name: 'Везен', nameLatin: 'Wezen', greekLetter: 'δ',
        x: 0.55, y: 0.55, levelIndex: 3,
      ),
      // ─── Рівень 5 · ε Adhara ──────────────────────────────────────────────
      ConstellationStar(
        name: 'Адхара', nameLatin: 'Adhara', greekLetter: 'ε',
        x: 0.28, y: 0.70, levelIndex: 4,
      ),
      // ─── Рівень 6 · η Aludra · найважчий ─────────────────────────────────
      ConstellationStar(
        name: 'Алюдра', nameLatin: 'Aludra', greekLetter: 'η',
        x: 0.72, y: 0.78, levelIndex: 5,
      ),
    ],
    lines: [
      // ── Плечі/шия ─────────────────────────────────────────────────────────
      const ConstellationLine(1, 0), // β Mirzam    → α Sirius
      const ConstellationLine(0, 2), // α Sirius    → γ Muliphein
      // ── Тіло ──────────────────────────────────────────────────────────────
      const ConstellationLine(0, 3), // α Sirius    → δ Wezen
      const ConstellationLine(2, 3), // γ Muliphein → δ Wezen
      // ── Задні лапи / хвіст ────────────────────────────────────────────────
      const ConstellationLine(3, 4), // δ Wezen     → ε Adhara
      const ConstellationLine(3, 5), // δ Wezen     → η Aludra
      const ConstellationLine(1, 4), // β Mirzam    → ε Adhara
    ],
  );
}
