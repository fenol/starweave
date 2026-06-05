import '../../models/star_model.dart';
import '../../models/level_model.dart';

// Великий Пес · Рівень 1 · α Сіріус
// Сітка 8×10, шлях=19
// Рішення: A(5,1)g→JUMP→(3,3)binr→w→JUMP→(5,5)b→JUMP→(3,7)w
//           →(2,7)bin→g→(1,7)r→(0,7)g→(0,6)w→(1,6)g→(2,6)w
//           →(3,6)g→(4,7)r→JUMP→(6,7)g→(7,7)r→(8,7)g
//           →(9,6)binr→w→JUMP→(8,6)g=B (wait - checking B)
// B: (6,6) = "7,7" x=7,y=7 → row=6,col=6: yellow
// Actually re-read: B at path=19 is "7,7",7,7,yellow,B → row=6,col=6
class CanisMajorLevel1 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 1,
    totalLevels: 6,
    greekLetter: 'α',
    starName: 'Сіріус',
    starNameLatin: 'Sirius',
    constellation: 'Великий Пес',
    goalText: 'Знайди шлях від А до В',
    pathLength: 19,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'БІНАРНА ЗІРКА · СТРИБОК',
    grid: _buildGrid(),
    startPos: (5, 1),
    endPos: (6, 6),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(8, null));

    // ── Рядок 0 (y=1) ───────────────────────────────────────────────────────
    _p(grid, 0, 0, r);
    _p(grid, 0, 2, r);
    _p(grid, 0, 3, b);
    _p(grid, 0, 5, g);
    _p(grid, 0, 6, w); // крок 8
    _p(grid, 0, 7, g); // крок 7

    // ── Рядок 1 (y=2) ───────────────────────────────────────────────────────
    _p(grid, 1, 0, b);
    _p(grid, 1, 1, g);
    _p(grid, 1, 3, r);
    _p(grid, 1, 4, g);
    _p(grid, 1, 6, g); // крок 9
    _p(grid, 1, 7, r); // крок 6

    // ── Рядок 2 (y=3) ───────────────────────────────────────────────────────
    _p(grid, 2, 0, b);
    _p(grid, 2, 1, g);
    _p(grid, 2, 2, b, type: StarType.binaryReversed, second: w);
    _p(grid, 2, 6, w); // крок 10
    _p(grid, 2, 7, w, type: StarType.binary, second: g); // крок 5

    // ── Рядок 3 (y=4) ───────────────────────────────────────────────────────
    _p(grid, 3, 0, r);
    _p(grid, 3, 1, g);
    _p(grid, 3, 2, r);
    _p(grid, 3, 3, b, type: StarType.binaryReversed, second: w); // крок 2
    _p(grid, 3, 4, b);
    _p(grid, 3, 6, g); // крок 11
    _p(grid, 3, 7, w); // крок 4

    // ── Рядок 4 (y=5) ───────────────────────────────────────────────────────
    _p(grid, 4, 1, g);
    _p(grid, 4, 7, r); // крок 12

    // ── Рядок 5 (y=6) ───────────────────────────────────────────────────────
    _p(grid, 5, 0, b);
    _p(grid, 5, 1, g); // A · крок 1
    _p(grid, 5, 2, r);
    _p(grid, 5, 4, b);
    _p(grid, 5, 5, b); // крок 3

    // ── Рядок 6 (y=7) ───────────────────────────────────────────────────────
    _p(grid, 6, 0, w);
    _p(grid, 6, 1, r);
    _p(grid, 6, 2, w);
    _p(grid, 6, 3, b);
    _p(grid, 6, 6, g); // B · крок 19
    _p(grid, 6, 7, g); // крок 13

    // ── Рядок 7 (y=8) ───────────────────────────────────────────────────────
    _p(grid, 7, 1, r);
    _p(grid, 7, 3, r, type: StarType.binary, second: b);
    _p(grid, 7, 4, b);
    _p(grid, 7, 7, r); // крок 14

    // ── Рядок 8 (y=9) ───────────────────────────────────────────────────────
    _p(grid, 8, 0, r);
    _p(grid, 8, 1, g, type: StarType.binaryReversed, second: r);
    _p(grid, 8, 2, w);
    _p(grid, 8, 3, b, type: StarType.binary, second: w);
    _p(grid, 8, 5, b);
    _p(grid, 8, 6, w, type: StarType.binaryReversed, second: g); // крок 18
    _p(grid, 8, 7, g); // крок 15

    // ── Рядок 9 (y=10) ──────────────────────────────────────────────────────
    _p(grid, 9, 0, g);
    _p(grid, 9, 1, b);
    _p(grid, 9, 2, b);
    _p(grid, 9, 3, r);
    _p(grid, 9, 4, r, type: StarType.binaryReversed, second: b);
    _p(grid, 9, 5, g, type: StarType.binary, second: r);
    _p(grid, 9, 6, g); // крок 17
    _p(grid, 9, 7, r); // крок 16

    return grid;
  }

  static void _p(
    List<List<GridStar?>> grid, int row, int col, StarSpectrum s, {
    StarType type = StarType.normal,
    StarSpectrum? second,
  }) {
    grid[row][col] = GridStar(
      row: row, col: col, spectrum: s, type: type, secondSpectrum: second,
    );
  }
}
