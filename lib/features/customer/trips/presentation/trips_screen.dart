import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/oma_card.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'رحلاتي',
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: const [
          _TripCard(
            from: 'الرفاعي',
            to: 'الجامعة',
            price: '2,500 د.ع',
            status: 'مكتملة',
            color: AppColors.success,
          ),
          SizedBox(height: AppSpacing.md),
          _TripCard(
            from: 'السوق',
            to: 'المستشفى',
            price: '1,500 د.ع',
            status: 'ملغاة',
            color: AppColors.error,
          ),
          SizedBox(height: AppSpacing.md),
          _TripCard(
            from: 'المنزل',
            to: 'العمل',
            price: '2,000 د.ع',
            status: 'قيد التنفيذ',
            color: AppColors.warning,
          ),
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final String from;
  final String to;
  final String price;
  final String status;
  final Color color;

  const _TripCard({
    required this.from,
    required this.to,
    required this.price,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return OmaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: .12),
                child: Icon(Icons.local_taxi_outlined, color: color),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text('$from ← $to', style: AppTextStyles.titleSmall)),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(status, style: AppTextStyles.caption.copyWith(color: color)),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(price, style: AppTextStyles.price),
        ],
      ),
    );
  }
}
