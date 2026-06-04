import '../models/constellation_model.dart';

/// Розділ 6 — Телець (Taurus)
///
/// 9 зірок у порядку α→β→γ→δ→ε→ζ→η→θ→λ:
///   α Aldebaran (0) · β Elnath (1) · γ Hyadum I (2) · δ Hyadum II (3)
///   ε Ain (4) · ζ Zeta Tau (5) · η Alcyone (6) · θ Theta Tau (7) · λ Lambda Tau (8)
class TaurusData {
  static final ConstellationChapter chapter = ConstellationChapter(
    name: 'Телець',
    nameLatin: 'Taurus',
    mythQuote:
        '«Зевс перетворився на білого бика й поніс Європу за море. '
        'Плеяди й досі плачуть за нею з неба.»',
    storyTitle: 'Бик Зевса й Плеяди',
    storyOnCompletion: false,
    story:
        'Європа — донька фінікійського царя Агенора — грала з подругами '
        'на березі моря, коли з хвиль вийшов засліпливо білий бик. '
        'Він поклав голову їй на коліна, ліг біля ніг і дивився такими '
        'лагідними очима, що дівчина наважилась на нього сісти.\n\n'
        'Щойно Європа опинилась на спині бика, він підхопився і кинувся у море. '
        'Хвилі розступались перед ними. Вітер стих. '
        'Бик, що насправді був Зевсом, ніс її до берегів Криту, '
        'де боги поєдналися і Європа стала першою царицею острова.\n\n'
        'Семеро сестер Плеяд — доньки Атласа, що тримає небо на плечах. '
        'Коли Оріон почав переслідувати їх через усю землю, '
        'Зевс перетворив сестер на зірки й помістив у сузір\'ї Тельця. '
        'Кажуть, із семи зірок видно лише шість — сьома ховається з горя '
        'або сорому за ту з сестер, що вийшла заміж за смертного.\n\n'
        'Альдебаран — вогненно-руде око бика — є червоним гігантом: '
        'він у 44 рази більший за Сонце і горить у 425 разів яскравіше. '
        'Разом із чотирма іншими зірками Гіад він утворює V-подібну фігуру '
        '«голови бика» — найпомітніший астеризм у зимовому небі. '
        'Хіади — найближче до нас зоряне скупчення: лише 153 світлових роки.',
    stars: [
      // ─── Рівень 1 · α Aldebaran · найлегший ──────────────────────────────
      ConstellationStar(
        name: 'Альдебаран', nameLatin: 'Aldebaran', greekLetter: 'α',
        x: 0.28, y: 0.52, levelIndex: 0, isUnlocked: true,
      ),
      // ─── Рівень 2 · β Elnath · кінчик північного рогу ────────────────────
      ConstellationStar(
        name: 'Ельнат', nameLatin: 'Elnath', greekLetter: 'β',
        x: 0.85, y: 0.14,
        levelIndex: 1,
      ),
      // ─── Рівень 3 · γ Hyadum I ────────────────────────────────────────────
      ConstellationStar(
        name: 'Гіад I', nameLatin: 'Hyadum I', greekLetter: 'γ',
        x: 0.55, y: 0.40,
        levelIndex: 2,
      ),
      // ─── Рівень 4 · δ Hyadum II ───────────────────────────────────────────
      ConstellationStar(
        name: 'Гіад II', nameLatin: 'Hyadum II', greekLetter: 'δ',
        x: 0.58, y: 0.54,
        levelIndex: 3,
      ),
      // ─── Рівень 5 · ε Ain ─────────────────────────────────────────────────
      ConstellationStar(
        name: 'Айн', nameLatin: 'Ain', greekLetter: 'ε',
        x: 0.46, y: 0.28,
        levelIndex: 4,
      ),
      // ─── Рівень 6 · ζ Zeta Tau · кінчик південного рогу ──────────────────
      ConstellationStar(
        name: 'Зета Тельця', nameLatin: 'Zeta Tau', greekLetter: 'ζ',
        x: 0.83, y: 0.70,
        levelIndex: 5,
      ),
      // ─── Рівень 7 · η Alcyone · найяскравіша Плеяда ──────────────────────
      ConstellationStar(
        name: 'Альціона', nameLatin: 'Alcyone', greekLetter: 'η',
        x: 0.65, y: 0.12,
        levelIndex: 6,
      ),
      // ─── Рівень 8 · θ¹ Theta Tau ─────────────────────────────────────────
      ConstellationStar(
        name: 'Тета Тельця', nameLatin: 'Theta Tau', greekLetter: 'θ',
        x: 0.62, y: 0.68,
        levelIndex: 7,
      ),
      // ─── Рівень 9 · λ Lambda Tau · найважчий ─────────────────────────────
      ConstellationStar(
        name: 'Лямбда Тельця', nameLatin: 'Lambda Tau', greekLetter: 'λ',
        x: 0.32, y: 0.80,
        levelIndex: 8,
      ),
    ],
    lines: [
      // ── Плеяди → голова ───────────────────────────────────────────────────
      const ConstellationLine(6, 4),  // η Alcyone   → ε Ain
      // ── Голова (Хіади-V) ──────────────────────────────────────────────────
      const ConstellationLine(4, 0),  // ε Ain       → α Aldebaran
      const ConstellationLine(4, 2),  // ε Ain       → γ Hyadum I
      const ConstellationLine(2, 3),  // γ Hyadum I  → δ Hyadum II
      const ConstellationLine(0, 3),  // α Aldebaran → δ Hyadum II
      const ConstellationLine(3, 7),  // δ Hyadum II → θ Theta Tau
      // ── Роги ──────────────────────────────────────────────────────────────
      const ConstellationLine(4, 1),  // ε Ain        → β Elnath (пн. ріг)
      const ConstellationLine(3, 5),  // δ Hyadum II  → ζ Zeta Tau (пд. ріг)
      // ── Тіло/шия ──────────────────────────────────────────────────────────
      const ConstellationLine(0, 8),  // α Aldebaran → λ Lambda Tau
    ],
  );
}
