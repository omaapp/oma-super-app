import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/oma_card.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'المحفظة',
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _BalanceCard(),
          SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(child: _WalletAction(icon: Icons.add, title: 'شحن')),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: _WalletAction(icon: Icons.history, title: 'السجل'),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          Text('آخر العمليات', style: AppTextStyles.titleLarge),
          SizedBox(height: AppSpacing.md),
          _WalletItem(title: 'شحن رصيد', amount: '+10,000 د.ع', isCredit: true),
          SizedBox(height: AppSpacing.sm),
          _WalletItem(title: 'رحلة Taxi', amount: '-2,500 د.ع'),
          SizedBox(height: AppSpacing.sm),
          _WalletItem(title: 'رحلة Tuk Tuk', amount: '-1,500 د.ع'),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الرصيد الحالي', style: TextStyle(color: Colors.white70)),
          SizedBox(height: AppSpacing.sm),
          Text(
            '15,000 د.ع',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletAction extends StatelessWidget {
  final IconData icon;
  final String title;

  const _WalletAction({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return OmaCard(
      onTap: () {},
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 30),
          const SizedBox(height: AppSpacing.sm),
          Text(title, style: AppTextStyles.button),
        ],
      ),
    );
  }
}

class _WalletItem extends StatelessWidget {
  final String title;
  final String amount;
  final bool isCredit;

  const _WalletItem({
    required this.title,
    required this.amount,
    this.isCredit = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCredit ? AppColors.success : AppColors.error;
    return OmaCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: .12),
            child: Icon(Icons.account_balance_wallet_outlined, color: color),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(title, style: AppTextStyles.titleSmall)),
          Text(amount, style: AppTextStyles.button.copyWith(color: color)),
        ],
      ),
    );
  }
}
