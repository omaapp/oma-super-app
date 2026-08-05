import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/oma_card.dart';

class QuickActionsBar extends StatelessWidget {
  const QuickActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [

        Expanded(
          child: _QuickAction(
            icon: Icons.history_rounded,
            title: "رحلاتي",
            color: AppColors.primary,
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: _QuickAction(
            icon: Icons.favorite_rounded,
            title: "المفضلة",
            color: Colors.red,
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: _QuickAction(
            icon: Icons.account_balance_wallet_rounded,
            title: "المحفظة",
            color: AppColors.success,
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: _QuickAction(
            icon: Icons.support_agent_rounded,
            title: "الدعم",
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    final dark =
        Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {},

      child: OmaCard(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 10,
        ),
        child: Column(
          children: [

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),

              width: 56,
              height: 56,

              decoration: BoxDecoration(
                color: color.withValues(alpha: .12),
                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: dark
                    ? Colors.white
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
