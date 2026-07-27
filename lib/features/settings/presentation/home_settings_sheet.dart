import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/app_settings.dart';

class HomeSettingsSheet extends StatelessWidget {
  const HomeSettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 55,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "إعدادات التطبيق",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("اللغة"),
              subtitle: Text(
                settings.locale.languageCode == "ar"
                    ? "العربية"
                    : "English",
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: () async {
                final result = await showDialog<String>(
                  context: context,
                  builder: (_) => SimpleDialog(
                    title: const Text("اختر اللغة"),
                    children: [
                      SimpleDialogOption(
                        onPressed: () =>
                            Navigator.pop(context, "ar"),
                        child: const Text("العربية"),
                      ),
                      SimpleDialogOption(
                        onPressed: () =>
                            Navigator.pop(context, "en"),
                        child: const Text("English"),
                      ),
                    ],
                  ),
                );

                if (result != null) {
                  await settings.setLanguage(result);
                }
              },
            ),

            const Divider(),

            SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text("الوضع الليلي"),
              value: settings.themeMode == ThemeMode.dark,
              onChanged: (value) async {
                await settings.setDarkMode(value);
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}