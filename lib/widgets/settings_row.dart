import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A reusable settings row matching the `.row` CSS class.
/// Renders icon, label, subtitle, and trailing content (badge, value, chevron, toggle).
class SettingsRow extends StatelessWidget {
  final Widget icon;
  final Gradient iconBackground;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final String? trailingValue;
  final Widget? badge;
  final bool showChevron;
  final bool isFirst;
  final bool isDanger;
  final VoidCallback? onTap;

  const SettingsRow({
    super.key,
    required this.icon,
    required this.iconBackground,
    required this.label,
    this.subtitle,
    this.trailing,
    this.trailingValue,
    this.badge,
    this.showChevron = true,
    this.isFirst = false,
    this.isDanger = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirst)
          Padding(
            padding: const EdgeInsets.only(left: 66),
            child: Divider(height: 1, thickness: 1, color: AppColors.g150),
          ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 60),
              child: Row(
                children: [
                  // Icon container
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: iconBackground,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Center(child: icon),
                  ),
                  const SizedBox(width: 14),
                  // Body
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isDanger ? AppColors.red : AppColors.g900,
                            letterSpacing: -0.3,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.g500,
                              letterSpacing: -0.1,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Trailing area
                  if (trailing != null ||
                      trailingValue != null ||
                      badge != null ||
                      showChevron) ...[
                    const SizedBox(width: 7),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (badge != null) ...[
                          badge!,
                          const SizedBox(width: 7),
                        ],
                        if (trailingValue != null)
                          Padding(
                            padding: EdgeInsets.only(
                              right: showChevron ? 7 : 0,
                            ),
                            child: Text(
                              trailingValue!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.g400,
                                letterSpacing: -0.15,
                              ),
                            ),
                          ),
                        ?trailing,
                        if (showChevron && trailing == null)
                          const Text(
                            '›',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: AppColors.g300,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
