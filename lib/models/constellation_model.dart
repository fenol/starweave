// Позиція зірки в реальному сузір'ї (для екрану розділу)
class ConstellationStar {
  final String name;        // Дубге
  final String nameLatin;   // Dubhe
  final String greekLetter; // α
  final double x;           // позиція 0.0–1.0 на екрані
  final double y;
  final int levelIndex;     // 0–N, або -1 для декоративних
  // true = тільки візуальна зірка, без рівня і без взаємодії
  final bool isDecoration;
  bool isUnlocked;
  bool isCompleted;

  ConstellationStar({
    required this.name,
    required this.nameLatin,
    required this.greekLetter,
    required this.x,
    required this.y,
    this.levelIndex = -1,
    this.isDecoration = false,
    this.isUnlocked = false,
    this.isCompleted = false,
  });
}

// Лінія між зірками в сузір'ї (малюємо ківш)
class ConstellationLine {
  final int fromIndex; // індекс зірки-початку
  final int toIndex;   // індекс зірки-кінця

  const ConstellationLine(this.fromIndex, this.toIndex);
}

// Повний розділ (сузір'я)
class ConstellationChapter {
  final String name;          // Велика Ведмедиця
  final String nameLatin;     // Ursa Major
  final String mythQuote;     // «Калісто...»
  final String? storyTitle;   // Заголовок попапу легенди (null = без попапу)
  final String? story;        // Повна легенда для попапу (null = без попапу)
  // false (Орion): показати при першому вході
  // true  (Perseus, Ursa Major): показати тільки після завершення розділу
  final bool storyOnCompletion;
  final List<ConstellationStar> stars; // 7 зірок з позиціями
  final List<ConstellationLine> lines; // лінії ковша

  ConstellationChapter({
    required this.name,
    required this.nameLatin,
    required this.mythQuote,
    this.storyTitle,
    this.story,
    this.storyOnCompletion = false,
    required this.stars,
    required this.lines,
  });

  // Кількість ігрових рівнів (декоративні зірки не рахуються)
  int get totalLevels => stars.where((s) => !s.isDecoration).length;

  // Скільки рівнів пройдено
  int get completedCount =>
      stars.where((s) => !s.isDecoration && s.isCompleted).length;

  // Чи весь розділ пройдено
  bool get isFullyCompleted => completedCount == totalLevels;

  // Відкрити наступний рівень після проходження поточного
  void unlockNext(int completedIndex) {
    stars[completedIndex].isCompleted = true;
    // Не відкриваємо декоративні зірки
    if (completedIndex + 1 < stars.length &&
        !stars[completedIndex + 1].isDecoration) {
      stars[completedIndex + 1].isUnlocked = true;
    }
  }

  // Позначити всі рівні як пройдені (тільки для тестування)
  void skipAll() {
    for (final star in stars) {
      if (!star.isDecoration) {
        star.isUnlocked = true;
        star.isCompleted = true;
      }
    }
  }
}