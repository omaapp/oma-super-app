import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool loading;
  final Widget? placesList;

  const SearchBox({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.loading,
    this.placesList,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool dark =
        theme.brightness == Brightness.dark;

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: dark
                ? const Color(0xff1F1F1F)
                : Colors.white,
            borderRadius:
                BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: "إلى أين تريد الذهاب؟",

              hintStyle: TextStyle(
                color: Colors.grey.shade500,
              ),

              border: InputBorder.none,

              contentPadding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),

              prefixIcon: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary
                      .withValues(alpha: .12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.search,
                  color: theme.colorScheme.primary,
                ),
              ),

              suffixIcon: loading
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.my_location,
                      ),
                      onPressed: () {},
                    ),
            ),
          ),
        ),

        if (placesList != null) ...[
          const SizedBox(height: 10),

          AnimatedContainer(
            duration:
                const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: dark
                  ? const Color(0xff1F1F1F)
                  : Colors.white,
              borderRadius:
                  BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .10),
                  blurRadius: 18,
                ),
              ],
            ),
            child: placesList,
          ),
        ],
      ],
    );
  }
}