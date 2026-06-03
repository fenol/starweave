import '../models/constellation_model.dart';

/// Дані п'ятого розділу — Близнюки
///
/// 8 ігрових зірок (levelIndex 0–7) + 9 декоративних:
///   Ігрові: β Pollux(0), α Castor(1), δ Wasat(2), ε Mebsuta(3),
///           ζ Mekbuta(4), γ Alhena(5), μ Tejat(6), η Propus(7)
///   Декоративні: υ(8), κ(9), ι(10), ρ(11), τ(12), θ(13), λ(14), ξ(15), ν(16)
///
/// Структура (лівий близнюк / правий близнюк):
///   β → υ → κ (гілка вліво)
///   υ → ι → τ (поперечний з'єднок)
///   α → ρ → τ
///   τ → θ (гілка вправо)
///   τ → ε Mebsuta
///   υ → δ Wasat → λ → ξ
///   δ → ζ Mekbuta → γ Alhena
///   ε → μ Tejat → η Propus
///   ε → ν
class GeminiData {
  static final ConstellationChapter chapter = ConstellationChapter(
    name: 'Близнюки',
    nameLatin: 'Gemini',
    mythQuote:
        '«Поллукс благав Зевса поділити безсмертя з братом. '
        'Відтоді близнюки вічно мандрують небом разом — '
        'наполовину боги, наполовину люди.»',
    storyOnCompletion: true,
    storyTitle: 'Нерозлучні Брати',
    story:
        'Кастор і Поллукс — сини цариці Леди зі Спарти. '
        'Поллукс народився безсмертним — його батько Зевс з\'явився до Леди '
        'у вигляді лебедя. Кастор був смертним сином царя Тіндарея.\n\n'
        'Попри різну природу, брати були нерозлучні. '
        'Разом вони брали участь у поході аргонавтів за Золотим руном, '
        'мисливстві на Калідонського вепра, численних пригодах. '
        'Кастор славився як приборкувач коней, Поллукс — як кулачний боєць.\n\n'
        'Доля розлучила їх лише раз. У сутичці з двоюрідними братами '
        'Їдасом та Лінкеєм Кастор загинув від смертельного удару. '
        'Поллукс, невтішний від горя, відмовився від безсмертя на Олімпі '
        'і благав Зевса поділити долю з братом.\n\n'
        'Зевс був зворушений такою відданістю. Він запропонував вибір: '
        'один день брати проводять разом на Олімпі, '
        'інший — у підземному царстві Аїда. '
        'Так близнюки стали напівбогами, що вічно мандрують між двома світами.\n\n'
        'На зоряному небі пара Кастор і Поллукс видна цілу зиму. '
        'Моряки шанували Діоскурів як покровителів під час морських бур. '
        'Вогні святого Ельма, що виникають на щоглах кораблів у грозу, '
        'вважались знаком їхньої присутності та символом порятунку.',
    stars: [
      // ═══ Ігрові зірки (levelIndex 0–7) ═══════════════════════════════════

      // ─── Рівень 1 · β Pollux · голова лівого близнюка ───────────────────
      ConstellationStar(
        name: 'Поллукс', nameLatin: 'Pollux', greekLetter: 'β',
        x: 0.28, y: 0.09, levelIndex: 0, isUnlocked: true,
      ),
      // ─── Рівень 2 · α Castor · голова правого близнюка ──────────────────
      ConstellationStar(
        name: 'Кастор', nameLatin: 'Castor', greekLetter: 'α',
        x: 0.62, y: 0.06, levelIndex: 1,
      ),
      // ─── Рівень 3 · δ Wasat · тіло лівого близнюка ───────────────────────
      ConstellationStar(
        name: 'Васат', nameLatin: 'Wasat', greekLetter: 'δ',
        x: 0.20, y: 0.44, levelIndex: 2,
      ),
      // ─── Рівень 4 · ε Mebsuta · тіло правого близнюка ───────────────────
      ConstellationStar(
        name: 'Мебсута', nameLatin: 'Mebsuta', greekLetter: 'ε',
        x: 0.64, y: 0.60, levelIndex: 3,
      ),
      // ─── Рівень 5 · ζ Mekbuta · ліва нога ───────────────────────────────
      ConstellationStar(
        name: 'Мекбута', nameLatin: 'Mekbuta', greekLetter: 'ζ',
        x: 0.30, y: 0.63, levelIndex: 4,
      ),
      // ─── Рівень 6 · γ Alhena · ступня лівого близнюка ───────────────────
      ConstellationStar(
        name: 'Альхена', nameLatin: 'Alhena', greekLetter: 'γ',
        x: 0.38, y: 0.84, levelIndex: 5,
      ),
      // ─── Рівень 7 · μ Tejat · права нога ─────────────────────────────────
      ConstellationStar(
        name: 'Тейат', nameLatin: 'Tejat', greekLetter: 'μ',
        x: 0.66, y: 0.78, levelIndex: 6,
      ),
      // ─── Рівень 8 · η Propus · ступня правого близнюка ──────────────────
      ConstellationStar(
        name: 'Пропус', nameLatin: 'Propus', greekLetter: 'η',
        x: 0.78, y: 0.90, levelIndex: 7,
      ),

      // ═══ Декоративні зірки (isDecoration: true, немає рівнів) ════════════

      // ─── υ (upsilon) · вузловий центр лівого близнюка ────────────────────
      ConstellationStar(
        name: '', nameLatin: '', greekLetter: 'υ',
        x: 0.40, y: 0.22, isDecoration: true,
      ),
      // ─── κ (kappa) · рука лівого близнюка ────────────────────────────────
      ConstellationStar(
        name: '', nameLatin: '', greekLetter: 'κ',
        x: 0.08, y: 0.23, isDecoration: true,
      ),
      // ─── ι (iota) · між υ і τ ─────────────────────────────────────────────
      ConstellationStar(
        name: '', nameLatin: '', greekLetter: 'ι',
        x: 0.51, y: 0.29, isDecoration: true,
      ),
      // ─── ρ (rho) · між α і τ ──────────────────────────────────────────────
      ConstellationStar(
        name: '', nameLatin: '', greekLetter: 'ρ',
        x: 0.68, y: 0.17, isDecoration: true,
      ),
      // ─── τ (tau) · вузловий центр правого близнюка ───────────────────────
      ConstellationStar(
        name: '', nameLatin: '', greekLetter: 'τ',
        x: 0.73, y: 0.30, isDecoration: true,
      ),
      // ─── θ (theta) · рука правого близнюка ───────────────────────────────
      ConstellationStar(
        name: '', nameLatin: '', greekLetter: 'θ',
        x: 0.96, y: 0.33, isDecoration: true,
      ),
      // ─── λ (lambda) · рука лівого близнюка (нижня ліва) ──────────────────
      ConstellationStar(
        name: '', nameLatin: '', greekLetter: 'λ',
        x: 0.07, y: 0.57, isDecoration: true,
      ),
      // ─── ξ (xi) · ліва стопа ─────────────────────────────────────────────
      ConstellationStar(
        name: '', nameLatin: '', greekLetter: 'ξ',
        x: 0.12, y: 0.90, isDecoration: true,
      ),
      // ─── ν (nu) · гілка від ε вниз-вліво ─────────────────────────────────
      ConstellationStar(
        name: '', nameLatin: '', greekLetter: 'ν',
        x: 0.54, y: 0.80, isDecoration: true,
      ),
    ],
    lines: [
      // ── Лівий близнюк ─────────────────────────────────────────────────────
      const ConstellationLine(0,  8),  // β Pollux   → υ
      const ConstellationLine(8,  9),  // υ          → κ (рука вліво)
      const ConstellationLine(8,  2),  // υ          → δ Wasat
      const ConstellationLine(2, 14),  // δ Wasat    → λ (рука вліво)
      const ConstellationLine(14, 15), // λ          → ξ
      const ConstellationLine(2,  4),  // δ Wasat    → ζ Mekbuta
      const ConstellationLine(4,  5),  // ζ Mekbuta  → γ Alhena

      // ── Правий близнюк ────────────────────────────────────────────────────
      const ConstellationLine(1, 11),  // α Castor   → ρ
      const ConstellationLine(11, 12), // ρ          → τ
      const ConstellationLine(12, 13), // τ          → θ (рука вправо)
      const ConstellationLine(12,  3), // τ          → ε Mebsuta
      const ConstellationLine(3,   6), // ε Mebsuta  → μ Tejat
      const ConstellationLine(6,   7), // μ Tejat    → η Propus
      const ConstellationLine(3,  16), // ε Mebsuta  → ν

      // ── Поперечний з'єднок між близнюками ────────────────────────────────
      const ConstellationLine(8,  10), // υ → ι
      const ConstellationLine(10, 12), // ι → τ
    ],
  );
}
