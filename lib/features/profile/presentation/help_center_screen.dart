import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  Widget item(
    IconData icon,
    String title,
    String body,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(title),
        childrenPadding: const EdgeInsets.all(16),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              body,
              style: const TextStyle(
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("مركز المساعدة"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          item(
            Icons.help_outline,
            "كيف أطلب رحلة؟",
            "حدد الوجهة من البحث أو بالنقر على الخريطة ثم اضغط زر طلب الرحلة.",
          ),

          item(
            Icons.location_on,
            "لا يعمل تحديد الموقع",
            "تأكد من تفعيل GPS ومنح التطبيق صلاحية الوصول إلى الموقع.",
          ),

          item(
            Icons.payments,
            "كيف يتم حساب السعر؟",
            "يعتمد السعر على المسافة ونوع المركبة المختارة.",
          ),

          item(
            Icons.cancel,
            "إلغاء الرحلة",
            "يمكنك إلغاء الرحلة قبل قبولها من السائق أو أثناء تنفيذها وفق سياسة التطبيق.",
          ),

          item(
            Icons.phone,
            "التواصل مع الدعم",
            "يمكنك التواصل مع الدعم الفني عبر البريد الإلكتروني أو رقم خدمة العملاء.",
          ),

          const SizedBox(height: 20),

          Card(
            color: Colors.blue.shade50,
            child: const ListTile(
              leading: Icon(Icons.support_agent),
              title: Text("الدعم الفني"),
              subtitle: Text(
                "support@oma-app.com",
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}