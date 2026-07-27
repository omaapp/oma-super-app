import 'package:flutter/material.dart';

class RequestTripButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool loading;
  final bool driverFound;

  const RequestTripButton({
    super.key,
    required this.onPressed,
    this.loading = false,
    this.driverFound = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color color = theme.colorScheme.primary;
    String text = "طلب الرحلة";
    IconData icon = Icons.local_taxi;

    if (loading) {
      color = Colors.orange;
      text = "جاري البحث عن سائق...";
      icon = Icons.search;
    }

    if (driverFound) {
      color = Colors.green;
      text = "تم العثور على سائق";
      icon = Icons.check_circle;
    }

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: loading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: loading
                ? Row(
                    key: const ValueKey("loading"),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "جاري البحث عن سائق...",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Row(
                    key: ValueKey(text),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon),
                      const SizedBox(width: 10),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}