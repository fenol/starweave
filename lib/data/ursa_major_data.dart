import '../models/constellation_model.dart';

/// Дані першого розділу — Велика Ведмедиця (Ківш)
///
/// Зірки впорядковані від найменш яскравої (рівень 1) до найяскравішої (рівень 7).
/// Позиції x/y (0.0–1.0) відповідають реальному розташуванню зірок на небі
/// за прямим піднесенням та схиленням.
class UrsaMajorData {
  // static final — синглтон: прогрес (isCompleted/isUnlocked) зберігається в сесії
  static final ConstellationChapter chapter = ConstellationChapter(
    name: 'Велика Ведмедиця',
    nameLatin: 'Ursa Major',
    mythQuote:
        '«Зевс перетворив Калісто на ведмедицю, щоб сховати від гніву Гери. '
        'Її син Аркас ледь не вбив матір на полюванні — '
        'і Зевс помістив обох серед зірок навіки.»',
    stars: [
      // ─── Рівень 1 · δ Megrez · найменш яскрава · зяблик чаші ─────────────
      ConstellationStar(
        name: 'Мегрец',
        nameLatin: 'Megrez',
        greekLetter: 'δ',
        x: 0.42,
        y: 0.32,
        levelIndex: 0,
        isUnlocked: true, // перший рівень відкрито одразу
      ),

      // ─── Рівень 2 · γ Phecda · дно чаші ──────────────────────────────────
      ConstellationStar(
        name: 'Фекда',
        nameLatin: 'Phecda',
        greekLetter: 'γ',
        x: 0.38,
        y: 0.60,
        levelIndex: 1,
      ),

      // ─── Рівень 3 · β Merak · передній низ чаші ───────────────────────────
      ConstellationStar(
        name: 'Мерак',
        nameLatin: 'Merak',
        greekLetter: 'β',
        x: 0.12,
        y: 0.48,
        levelIndex: 2,
      ),

      // ─── Рівень 4 · ζ Mizar · середина ручки ─────────────────────────────
      ConstellationStar(
        name: 'Мізар',
        nameLatin: 'Mizar',
        greekLetter: 'ζ',
        x: 0.76,
        y: 0.55,
        levelIndex: 3,
      ),

      // ─── Рівень 5 · η Alkaid · кінець ручки ──────────────────────────────
      ConstellationStar(
        name: 'Алькаїд',
        nameLatin: 'Alkaid',
        greekLetter: 'η',
        x: 0.90,
        y: 0.72,
        levelIndex: 4,
      ),

      // ─── Рівень 6 · α Dubhe · передній верх чаші ─────────────────────────
      ConstellationStar(
        name: 'Дубге',
        nameLatin: 'Dubhe',
        greekLetter: 'α',
        x: 0.10,
        y: 0.20,
        levelIndex: 5,
      ),

      // ─── Рівень 7 · ε Alioth · початок ручки · найяскравіша ──────────────
      ConstellationStar(
        name: 'Аліот',
        nameLatin: 'Alioth',
        greekLetter: 'ε',
        x: 0.60,
        y: 0.42,
        levelIndex: 6,
      ),
    ],
    lines: [
      // ── Чаша ковша (4 лінії) ──────────────────────────────────────────────
      const ConstellationLine(5, 2), // Dubhe  → Merak   (передня сторона)
      const ConstellationLine(2, 1), // Merak  → Phecda  (нижня сторона)
      const ConstellationLine(1, 0), // Phecda → Megrez  (задня сторона)
      const ConstellationLine(0, 5), // Megrez → Dubhe   (верхня сторона)
      // ── Ручка ковша (3 лінії) ─────────────────────────────────────────────
      const ConstellationLine(0, 6), // Megrez → Alioth
      const ConstellationLine(6, 3), // Alioth → Mizar
      const ConstellationLine(3, 4), // Mizar  → Alkaid
    ],
  );
}
