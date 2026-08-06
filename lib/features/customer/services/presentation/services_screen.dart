import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/oma_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  static const _services = <_Service>[
    _Service('Delivery', Icons.delivery_dining, AppColors.success),
    _Service('Food', Icons.restaurant, Colors.orange),
    _Service('Pharmacy', Icons.local_pharmacy, AppColors.primary),
    _Service('Shopping', Icons.shopping_bag_outlined, Colors.deepPurple),
    _Service('Car Wash', Icons.local_car_wash_outlined, AppColors.info),
    _Service('Fuel', Icons.local_gas_station_outlined, AppColors.warning),
    _Service('Courier', Icons.inventory_2_outlined, AppColors.secondary),
  ];

  @override
  Widget build(BuildContext context) => AppScaffold(
        title: 'الخدمات',
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'ابحث عن خدمة',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 1.15,
                ),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  final service = _services[index];
                  return OmaCard(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${service.title} قريباً')),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(service.icon, color: service.color, size: 36),
                      const SizedBox(height: AppSpacing.sm),
                      Text(service.title, style: AppTextStyles.titleSmall),
                    ]),
                  );
                },
              ),
            ),
          ]),
        ),
      );
}

class _Service {
  final String title;
  final IconData icon;
  final Color color;
  const _Service(this.title, this.icon, this.color);
}
