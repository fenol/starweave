import '../models/constellation_model.dart';

/// Розділ 5 — Візничий (Auriga)
///
/// 5 зірок: α Capella (0) · β Menkalinan (1) · ε Almaaz (2)
///          ζ Sadatoni (3) · θ Mahasim (4)
class AurigaData {
  static final ConstellationChapter chapter = ConstellationChapter(
    name: 'Візничий',
    nameLatin: 'Auriga',
    mythQuote:
        '«Капелла — коза Амальтея, що вигодувала Зевса. '
        'Зламаний ріг став першим Рогом достатку.»',
    storyTitle: 'Коза Зевса і Колісниця',
    storyOnCompletion: false,
    story:
        'Коли владика богів Зевс ще був немовлям, мати Рея сховала його '
        'на Криті від прожерливого батька Кроноса. '
        'Дитину вигодувала свята коза Амальтея — її молоко було настільки '
        'чистим і міцним, що немовля-Зевс виростало не по днях, а по годинах.\n\n'
        'Одного разу юний бог у грі зламав козі ріг. '
        'Збентежений і засмучений, він поклав у нього особливу силу: '
        'з тих пір ріг Амальтеї завжди переповнений — '
        'плодами, квітами, зерном, усім, чого побажає його власник. '
        'Так з\'явився Cornucopia — Ріг достатку.\n\n'
        'Коли Амальтея померла, вдячний Зевс помістив її серед зірок. '
        'Капелла — «маленька коза» — стала найяскравішою зіркою Візничого '
        'і шостою за яскравістю на всьому небі. '
        'Три зірки поруч із нею — ε, ζ і η — звуть «Козенятами».\n\n'
        'За іншим переказом, Візничий — це Еріхтоній, легендарний цар Афін, '
        'що народився з землі. Він мав кволі ноги й не міг ходити, '
        'тому придумав чотириколісну колісницю — квадригу. '
        'Його майстерність в управлінні кіньми вразила навіть богів, '
        'і Зевс помістив його на небо як Візничого зі зірками-козенятами.',
    stars: [
      // ─── Рівень 1 · α Capella · найлегший ────────────────────────────────
      ConstellationStar(
        name: 'Капелла', nameLatin: 'Capella', greekLetter: 'α',
        x: 0.38, y: 0.15, levelIndex: 0, isUnlocked: true,
      ),
      // ─── Рівень 2 · β Menkalinan ──────────────────────────────────────────
      ConstellationStar(
        name: 'Менкалінан', nameLatin: 'Menkalinan', greekLetter: 'β',
        x: 0.74, y: 0.28, levelIndex: 1,
      ),
      // ─── Рівень 3 · ε Almaaz ──────────────────────────────────────────────
      ConstellationStar(
        name: 'Альмааз', nameLatin: 'Almaaz', greekLetter: 'ε',
        x: 0.18, y: 0.50, levelIndex: 2,
      ),
      // ─── Рівень 4 · ζ Sadatoni ────────────────────────────────────────────
      ConstellationStar(
        name: 'Садатоні', nameLatin: 'Sadatoni', greekLetter: 'ζ',
        x: 0.26, y: 0.68, levelIndex: 3,
      ),
      // ─── Рівень 5 · θ Mahasim · найважчий ────────────────────────────────
      ConstellationStar(
        name: 'Махасім', nameLatin: 'Mahasim', greekLetter: 'θ',
        x: 0.62, y: 0.74, levelIndex: 4,
      ),
    ],
    lines: [
      // ── П'ятикутник Візничого ─────────────────────────────────────────────
      const ConstellationLine(0, 1), // α Capella    → β Menkalinan
      const ConstellationLine(1, 4), // β Menkalinan → θ Mahasim
      const ConstellationLine(4, 3), // θ Mahasim    → ζ Sadatoni
      const ConstellationLine(3, 2), // ζ Sadatoni   → ε Almaaz
      const ConstellationLine(2, 0), // ε Almaaz     → α Capella
      // ── Діагональ (колісниця) ─────────────────────────────────────────────
      const ConstellationLine(0, 4), // α Capella    → θ Mahasim
    ],
  );
}
