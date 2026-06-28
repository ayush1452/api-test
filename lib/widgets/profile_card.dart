import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Profile card matching `.profile-card` CSS.
/// Avatar with completion ring, name, email, progress bar, health badge, plan badge.
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.teal.withAlpha(31)),
        boxShadow: AppColors.shadowMd,
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.teal.withAlpha(15), Colors.transparent],
                  stops: const [0.0, 0.6],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                // Avatar with ring
                _buildAvatarRing(),
                const SizedBox(width: 16),
                // Info column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: name + badge
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Arjun Mehta',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.g900,
                                letterSpacing: -0.4,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.teal10,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Text(
                              'FREE',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.tealDarker,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      // Row 2: email
                      const Text(
                        'arjun.mehta@gmail.com',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: AppColors.g400,
                          letterSpacing: -0.1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Row 3: completion bar
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.g100,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.teal,
                                        AppColors.tealDark,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            '75%',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.tealDarker,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Row 4: nudge + health
                      Row(
                        children: [
                          const Text(
                            '+ Add DOB',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.amber,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: const BoxDecoration(
                              color: AppColors.g300,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          // Health pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
                              ),
                              border: Border.all(
                                color: AppColors.green.withAlpha(51),
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Under budget',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF065F46),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                // Chevron
                const Text(
                  '›',
                  style: TextStyle(fontSize: 20, color: AppColors.g300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarRing() {
    return SizedBox(
      width: 72,
      height: 72,
      child: Stack(
        children: [
          // Completion ring using CustomPaint
          Positioned.fill(
            child: CustomPaint(painter: _CompletionRingPainter(progress: 0.75)),
          ),
          // Avatar
          Positioned(
            top: 7,
            left: 7,
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.teal, AppColors.tealDark],
                ),
              ),
              child: const Center(
                child: Text(
                  'AM',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),
          ),
          // Camera edit dot
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.g200, width: 2.5),
              ),
              child: const Center(
                child: Text('📷', style: TextStyle(fontSize: 8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletionRingPainter extends CustomPainter {
  final double progress;

  _CompletionRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    // Background ring
    final bgPaint = Paint()
      ..color = AppColors.g200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress ring
    final progressPaint = Paint()
      ..color = AppColors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
