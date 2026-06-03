import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/ursa_major_data.dart';
import '../data/ursa_major_levels.dart';
import '../data/orion_data.dart';
import '../data/orion_levels.dart';
import '../data/perseus_data.dart';
import '../data/perseus_levels.dart';
import '../data/cassiopeia_data.dart';
import '../data/cassiopeia_levels.dart';
import '../data/gemini_data.dart';
import '../data/gemini_levels.dart';
import '../models/level_model.dart';
import '../models/constellation_model.dart';
import 'constellation_screen.dart';

// ── Метадані картки ───────────────────────────────────────────────────────────

class _ConEntry {
  final String nameUk;
  final String nameLatin;
  final String section;
  // true = є реальний вміст; false = заглушка («незабаром»)
  final bool hasContent;
  final ConstellationChapter? chapter;
  final LevelData? Function(int)? levelLoader;

  const _ConEntry({
    required this.nameUk,
    required this.nameLatin,
    required this.section,
    required this.hasContent,
    this.chapter,
    this.levelLoader,
  });

  bool get isFullyCompleted => chapter?.isFullyCompleted ?? false;
}

// ── Екран ─────────────────────────────────────────────────────────────────────

class SkyMapScreen extends StatefulWidget {
  const SkyMapScreen({super.key});

  @override
  State<SkyMapScreen> createState() => _SkyMapScreenState();
}

class _SkyMapScreenState extends State<SkyMapScreen> {

  // Усі сузір'я розділу (впорядковані від першого до останнього).
  // Chapters — синглтони (static final в data-файлах), прогрес зберігається в сесії.
  late final List<_ConEntry> _all;

  @override
  void initState() {
    super.initState();
    _all = [
      _ConEntry(
        nameUk: 'ВЕЛИКА ВЕДМЕДИЦЯ', nameLatin: 'Ursa Major',
        section: 'РОЗДІЛ 1', hasContent: true,
        chapter: UrsaMajorData.chapter, levelLoader: UrsaMajorLevels.getByIndex,
      ),
      _ConEntry(
        nameUk: 'ОРІОН', nameLatin: 'Orion',
        section: 'РОЗДІЛ 2', hasContent: true,
        chapter: OrionData.chapter, levelLoader: OrionLevels.getByIndex,
      ),
      _ConEntry(
        nameUk: 'ПЕРСЕЙ', nameLatin: 'Perseus',
        section: 'РОЗДІЛ 3', hasContent: true,
        chapter: PerseusData.chapter, levelLoader: PerseusLevels.getByIndex,
      ),
      _ConEntry(
        nameUk: 'КАССІОПЕЯ', nameLatin: 'Cassiopeia',
        section: 'РОЗДІЛ 4', hasContent: true,
        chapter: CassiopeiaData.chapter, levelLoader: CassiopeiaLevels.getByIndex,
      ),
      _ConEntry(
        nameUk: 'БЛИЗНЮКИ', nameLatin: 'Gemini',
        section: 'РОЗДІЛ 5', hasContent: true,
        chapter: GeminiData.chapter, levelLoader: GeminiLevels.getByIndex,
      ),
      const _ConEntry(nameUk: 'ВІЗНИК',          nameLatin: 'Auriga',     section: 'РОЗДІЛ 6', hasContent: false),
      const _ConEntry(nameUk: 'ТЕЛЕЦЬ',          nameLatin: 'Taurus',     section: 'РОЗДІЛ 7', hasContent: false),
      const _ConEntry(nameUk: 'МАЛА ВЕДМЕДИЦЯ', nameLatin: 'Ursa Minor', section: 'РОЗДІЛ 8', hasContent: false),
    ];
  }

  // ── Обчислює, які картки показати ─────────────────────────────────────────
  // Правило: показуємо всі пройдені + перший непройдений з контентом.
  // Розділи-заглушки (hasContent: false) не блокують перегляд наступних.
  List<_ConEntry> get _visible {
    final result = <_ConEntry>[];
    for (final entry in _all) {
      result.add(entry);
      if (entry.hasContent && !entry.isFullyCompleted) break;
    }
    return result;
  }

  // ── Навігація до розділу ──────────────────────────────────────────────────

  Future<void> _openChapter(_ConEntry entry) async {
    if (!entry.hasContent || entry.chapter == null) return;
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ConstellationScreen(
        chapter: entry.chapter!,
        levelLoader: entry.levelLoader!,
      ),
    ));
    // Перебудовуємо список після повернення — прогрес міг змінитись
    if (mounted) setState(() {});
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final visible = _visible;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 28),
                child: Column(
                  children: [
                    for (final entry in visible)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: entry.hasContent
                            ? IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: _ConCard(
                                        entry: entry,
                                        completed: entry.isFullyCompleted,
                                        onTap: () => _openChapter(entry),
                                      ),
                                    ),
                                    if (!entry.isFullyCompleted &&
                                        entry.chapter != null)
                                      _SkipButton(
                                        onTap: () {
                                          entry.chapter!.skipAll();
                                          setState(() {});
                                        },
                                      ),
                                  ],
                                ),
                              )
                            : const _LockedCard(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 12, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: AppTheme.textSecondary, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Center(
              child: Text(
                'ПІВНІЧНЕ ЗИМОВЕ НЕБО',
                style: AppTheme.labelStyle.copyWith(
                  fontSize: 10,
                  letterSpacing: 5,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

// ── Відкрита картка ───────────────────────────────────────────────────────────

class _ConCard extends StatelessWidget {
  final _ConEntry entry;
  final bool completed;
  final VoidCallback onTap;

  const _ConCard({
    required this.entry,
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = completed
        ? AppTheme.accent.withValues(alpha: 0.35)
        : AppTheme.constellationLine.withValues(alpha: 0.42);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 88,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top:    BorderSide(color: borderColor, width: 0.8),
            left:   BorderSide(color: borderColor, width: 0.8),
            bottom: BorderSide(color: borderColor, width: 0.8),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
          color: AppTheme.skyColor.withValues(alpha: 0.48),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                    painter: _CardStarsPainter(entry.nameLatin.hashCode)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 44, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          entry.section,
                          style: AppTheme.labelStyle.copyWith(
                            fontSize: 9,
                            letterSpacing: 5,
                            color: AppTheme.textSecondary.withValues(alpha: 0.42),
                          ),
                        ),
                        if (completed) ...[
                          const SizedBox(width: 8),
                          Text(
                            '✓',
                            style: AppTheme.labelStyle.copyWith(
                              fontSize: 9,
                              color: AppTheme.accent.withValues(alpha: 0.80),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          entry.nameUk,
                          style: AppTheme.titleStyle.copyWith(
                            fontSize: 18,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          entry.nameLatin,
                          style: AppTheme.labelStyle.copyWith(
                            fontSize: 9,
                            letterSpacing: 3,
                            color: AppTheme.textSecondary.withValues(alpha: 0.35),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 14,
                bottom: 12,
                child: Text(
                  completed ? '↻' : '→',
                  style: AppTheme.labelStyle.copyWith(
                    fontSize: 14,
                    color: AppTheme.accent.withValues(alpha: completed ? 0.45 : 0.55),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Заблокована картка («незабаром») ──────────────────────────────────────────

class _LockedCard extends StatelessWidget {
  const _LockedCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top:    BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.10), width: 0.8),
          left:   BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.10), width: 0.8),
          bottom: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.10), width: 0.8),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          bottomLeft: Radius.circular(4),
        ),
      ),
      child: Center(
        child: Text(
          '?',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 22,
            letterSpacing: 0,
            color: AppTheme.textSecondary.withValues(alpha: 0.14),
          ),
        ),
      ),
    );
  }
}

// ── Skip-кнопка (тільки для тестування) ──────────────────────────────────────

class _SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SkipButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: AppTheme.textSecondary.withValues(alpha: 0.12),
                width: 0.8),
            right: BorderSide(
                color: AppTheme.textSecondary.withValues(alpha: 0.12),
                width: 0.8),
            bottom: BorderSide(
                color: AppTheme.textSecondary.withValues(alpha: 0.12),
                width: 0.8),
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Center(
          child: RotatedBox(
            quarterTurns: 1,
            child: Text(
              'SKIP',
              style: AppTheme.labelStyle.copyWith(
                fontSize: 7,
                letterSpacing: 2.5,
                color: AppTheme.textSecondary.withValues(alpha: 0.28),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Зоряне тло картки ─────────────────────────────────────────────────────────

class _CardStarsPainter extends CustomPainter {
  final int seed;
  _CardStarsPainter(this.seed);

  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(seed);
    final p = Paint();
    for (int i = 0; i < 24; i++) {
      p.color = Colors.white.withValues(alpha: rng.nextDouble() * 0.28 + 0.05);
      canvas.drawCircle(
        Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height),
        rng.nextDouble() * 0.85 + 0.25,
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
