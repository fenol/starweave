// Спектральні класи зірок
// ВАЖЛИВО: порядок index = правило сусідства (±1)
enum StarSpectrum {
  blue,  // 1 — найяскравіша, синя
  white, // 2 — кремово-біла
  gold,  // 3 — жовто-золота
  red,   // 4 — помаранчево-червона
}

// Тип зірки
enum StarType {
  normal, // звичайна
  binary, // бінарна — wildcard-міст між класами
}

// Одна зірка на сітці
class GridStar {
  final int row;
  final int col;
  final StarSpectrum spectrum;
  final StarType type;
  final StarSpectrum? secondSpectrum; // тільки для бінарних

  const GridStar({
    required this.row,
    required this.col,
    required this.spectrum,
    this.type = StarType.normal,
    this.secondSpectrum,
  });

  bool get isBinary => type == StarType.binary;

  // Яскравість = числове значення спектру
  static int brightnessOf(StarSpectrum s) => s.index + 1;
}

// Крок шляху — зірка + який спектр реально використали
// (для бінарних спектр вибирається динамічно)
class PathNode {
  final GridStar star;
  final StarSpectrum usedSpectrum;

  const PathNode({required this.star, required this.usedSpectrum});

  int get brightness => usedSpectrum.index + 1;
}