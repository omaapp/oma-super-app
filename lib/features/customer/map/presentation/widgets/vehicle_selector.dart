import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class VehicleSelector extends StatelessWidget {
  final String selectedVehicle;
  final ValueChanged<String> onChanged;

  const VehicleSelector({
    super.key,
    required this.selectedVehicle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _VehicleTile(
            title: "Taxi",
            subtitle: "4 مقاعد",
            eta: "3 دقائق",
            price: "2000 د.ع",
            badge: "الأكثر طلباً",
            icon: Icons.local_taxi,
            color: AppColors.primary,
            selected: selectedVehicle == "taxi",
            onTap: () => onChanged("taxi"),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _VehicleTile(
            title: "Tuk Tuk",
            subtitle: "2 مقاعد",
            eta: "2 دقيقة",
            price: "1000 د.ع",
            badge: "الأوفر",
            icon: Icons.electric_rickshaw,
            color: Colors.orange,
            selected: selectedVehicle == "tuk",
            onTap: () => onChanged("tuk"),
          ),
        ),
      ],
    );
  }
}

class _VehicleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String eta;
  final String price;
  final String badge;

  final IconData icon;
  final Color color;

  final bool selected;

  final VoidCallback onTap;

  const _VehicleTile({
    required this.title,
    required this.subtitle,
    required this.eta,
    required this.price,
    required this.badge,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected
              ? color
              : theme.cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected
                ? color
                : theme.dividerColor,
            width: selected ? 2 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? color.withValues(alpha: .28)
                  : Colors.black.withValues(alpha: .05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
  children: [

    Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: selected
              ? Colors.white24
              : color.withValues(alpha: .10),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          badge,
          style: TextStyle(
            color: selected
                ? Colors.white
                : color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    ),

    const SizedBox(height: 12),

    Hero(
      tag: title,
      child: CircleAvatar(
        radius: 34,
        backgroundColor: selected
            ? Colors.white24
            : color.withValues(alpha: .12),
        child: Icon(
          icon,
          size: 36,
          color: selected
              ? Colors.white
              : color,
        ),
      ),
    ),

    const SizedBox(height: 16),

    Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(
        color: selected
            ? Colors.white
            : theme.colorScheme.onSurface,
      ),
    ),

    const SizedBox(height: 6),

    Text(
      subtitle,
      textAlign: TextAlign.center,
      style: AppTextStyles.caption.copyWith(
        color: selected
            ? Colors.white70
            : Colors.grey,
      ),
    ),

    const Spacer(),

    Row(
      children: [

        Icon(
          Icons.schedule,
          size: 18,
          color: selected
              ? Colors.white
              : color,
        ),

        const SizedBox(width: 6),

        Expanded(
          child: Text(
            eta,
            style: AppTextStyles.bodyMedium.copyWith(
              color: selected
                  ? Colors.white
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    ),

    const SizedBox(height: 10),

    Row(
      children: [

        Icon(
          Icons.payments,
          size: 18,
          color: selected
              ? Colors.white
              : Colors.green,
        ),

        const SizedBox(width: 6),

        Expanded(
          child: Text(
            price,
            style: AppTextStyles.bodyMedium.copyWith(
              color: selected
                  ? Colors.white
                  : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),

    const SizedBox(height: 12),

    AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      height: 42,
      decoration: BoxDecoration(
        color: selected
            ? Colors.white
            : color.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          selected ? "تم الاختيار" : "اختر",
          style: TextStyle(
            color: selected
                ? color
                : color,
            fontWeight: FontWeight.bold,
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
