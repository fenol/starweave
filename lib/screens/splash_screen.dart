import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_menu_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _starsController;
  late AnimationController _titleController;
  late AnimationController _progressController;
  late AnimationController _glowController;
  late AnimationController _buttonController;

  final List<_StarParticle> _stars = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _generateStars();
    _setupAnimations();
  }

  void _generateStars() {
    for (int i = 0; i < 80; i++) {
      _stars.add(_StarParticle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 2 + 1,
        opacity: _random.nextDouble() * 0.5 + 0.2,
        delay: _random.nextDouble() * 0.6,
      ));
    }
  }

  void _setupAnimations() {
    _starsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _glowController.forward();
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _titleController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) _progressController.forward();
    });

    // Кнопка з'являється після завершення прогрес-анімації
    Future.delayed(const Duration(milliseconds: 3400), () {
      if (mounted) _buttonController.forward();
    });
  }

  void _navigateToMenu() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const MainMenuScreen(),
        transitionDuration: const Duration(milliseconds: 700),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _starsController.dispose();
    _titleController.dispose();
    _progressController.dispose();
    _glowController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Шар 1: зірки
          ..._stars.map((star) => _buildStar(star, size)),

          // Шар 2: aurora glow — від низу до тексту в центрі
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) {
                final glow = CurvedAnimation(
                  parent: _glowController,
                  curve: Curves.easeOut,
                ).value;
                return Opacity(
                  opacity: glow,
                  child: Container(
                    height: size.height * 0.62,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          const Color(0xFF1B3A6B).withValues(alpha: 0.85),
                          const Color(0xFF0F2850).withValues(alpha: 0.45),
                          const Color(0xFF0A1F3D).withValues(alpha: 0.15),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 0.6, 1.0],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Шар 3: назва + підзаголовок по центру
          Center(
            child: AnimatedBuilder(
              animation: _titleController,
              builder: (context, child) {
                final progress = CurvedAnimation(
                  parent: _titleController,
                  curve: Curves.easeOut,
                ).value;
                return Opacity(
                  opacity: progress,
                  child: Transform.translate(
                    offset: Offset(0, 16 * (1 - progress)),
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('STAR', style: AppTheme.titleStyle),
                  const SizedBox(height: 4),
                  Text('WEAVE', style: AppTheme.titleStyle),
                  const SizedBox(height: 16),
                  Text(
                    'М І Ф И     З О Р Я Н О Г О     Н Е Б А',
                    style: AppTheme.labelStyle.copyWith(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                      letterSpacing: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Шар 4: подвійна прогрес-лінія
          Positioned(
            bottom: 104,
            left: size.width * 0.2,
            right: size.width * 0.2,
            child: AnimatedBuilder(
              animation: _progressController,
              builder: (context, _) {
                final progress = _progressController.value;
                return Row(
                  children: [
                    // Ліва частина лінії
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.starInactive.withValues(alpha: 0),
                              AppTheme.starInactive.withValues(alpha: progress),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12), // проміжок між двома лініями
                    // Права частина лінії
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.starInactive.withValues(alpha: progress),
                              AppTheme.starInactive.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Шар 5: кнопка "ПОЧАТИ"
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: AnimatedBuilder(
              animation: _buttonController,
              builder: (context, child) {
                final progress = CurvedAnimation(
                  parent: _buttonController,
                  curve: Curves.easeOut,
                ).value;
                return IgnorePointer(
                  ignoring: progress < 0.5,
                  child: Opacity(opacity: progress, child: child),
                );
              },
              child: OutlinedButton(
                onPressed: _navigateToMenu,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.accent, width: 1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  overlayColor: AppTheme.accent,
                ),
                child: Text(
                  'П О Ч А Т И',
                  style: AppTheme.labelStyle.copyWith(
                    fontSize: 12,
                    color: AppTheme.accent,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStar(_StarParticle star, Size size) {
    return AnimatedBuilder(
      animation: _starsController,
      builder: (context, _) {
        final progress = ((_starsController.value - star.delay) /
            (1.0 - star.delay)).clamp(0.0, 1.0);
        return Positioned(
          left: star.x * size.width,
          top: star.y * size.height,
          child: Opacity(
            opacity: progress * star.opacity,
            child: Container(
              width: star.size,
              height: star.size,
              decoration: BoxDecoration(
                color: AppTheme.starInactive,
                shape: BoxShape.circle,
                boxShadow: star.size > 2
                    ? [BoxShadow(
                        color: AppTheme.starInactive.withValues(alpha: 0.4),
                        blurRadius: star.size * 2,
                      )]
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StarParticle {
  final double x, y, size, opacity, delay;
  _StarParticle({
    required this.x, required this.y,
    required this.size, required this.opacity,
    required this.delay,
  });
}