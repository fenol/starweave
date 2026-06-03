import 'package:flutter/material.dart';
import '../models/constellation_model.dart';
import '../theme/app_theme.dart';

/// Попап з легендою розділу.
///
/// Показується автоматично при першому відкритті розділу (один раз за сесію),
/// а також за натисканням посилання "ЛЕГЕНДА" на екрані сузір'я.
///
/// Висота: 70% екрану. Вміст прокручується. Закрити хрестиком.
class StoryPopup extends StatelessWidget {
  final ConstellationChapter chapter;

  const StoryPopup({super.key, required this.chapter});

  /// Показати попап. Нічого не робить, якщо [chapter.story] == null.
  static void show(BuildContext context, ConstellationChapter chapter) {
    if (chapter.story == null) return;
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.72),
      builder: (_) => StoryPopup(chapter: chapter),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        constraints: BoxConstraints(maxHeight: screenH * 0.70),
        decoration: BoxDecoration(
          color: AppTheme.skyColor,
          border: Border.all(
            color: AppTheme.constellationLine.withOpacity(0.35),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Шапка ────────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapter.nameLatin.toUpperCase(),
                          style: AppTheme.labelStyle.copyWith(
                            fontSize: 9,
                            letterSpacing: 4,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          chapter.storyTitle ?? 'ЛЕГЕНДА',
                          style: AppTheme.titleStyle.copyWith(
                            fontSize: 19,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // ── Роздільник ────────────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 1,
              color: AppTheme.constellationLine.withOpacity(0.15),
            ),

            // ── Прокручуваний текст ───────────────────────────────────────────
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                child: Text(
                  chapter.story!,
                  style: AppTheme.bodyStyle.copyWith(
                    fontSize: 14,
                    height: 1.85,
                    color: AppTheme.textSecondary.withOpacity(0.88),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
