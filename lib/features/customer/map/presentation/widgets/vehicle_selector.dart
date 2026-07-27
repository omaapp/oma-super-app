import 'package:flutter/material.dart';

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
            icon: Icons.local_taxi,
            color: Colors.blue,
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
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _VehicleTile({
    required this.title,
    required this.subtitle,
    required this.eta,
    required this.price,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? color
              : theme.cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected
                ? color
                : theme.dividerColor,
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? color.withOpacity(.30)
                  : Colors.black.withOpacity(.05),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                selected
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: selected
                    ? Colors.white
                    : Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            CircleAvatar(
              radius: 34,
              backgroundColor: selected
                  ? Colors.white24
                  : color.withOpacity(.12),
              child: Icon(
                icon,
                size: 36,
                color: selected
                    ? Colors.white
                    : color,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: selected
                    ? Colors.white
                    : theme.colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              subtitle,
              style: TextStyle(
                color: selected
                    ? Colors.white70
                    : Colors.grey,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 17,
                  color: selected
                      ? Colors.white
                      : color,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    eta,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  Icons.payments,
                  size: 17,
                  color: selected
                      ? Colors.white
                      : Colors.green,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    price,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selected
                          ? Colors.white
                          : Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}