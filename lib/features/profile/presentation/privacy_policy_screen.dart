import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Widget section(
    String title,
    String body,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(
              fontSize: 15,
              height: 1.8,
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
        title: const Text("سياسة الخصوصية"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            section(
              "المقدمة",
              "يحرص تطبيق Oma على حماية خصوصية جميع المستخدمين. باستخدامك للتطبيق فإنك توافق على سياسة الخصوصية هذه.",
            ),

            section(
              "المعلومات التي نجمعها",
              "• رقم الهاتف\n"
              "• الموقع الحالي أثناء استخدام التطبيق\n"
              "• بيانات الرحلات\n"
              "• نوع الجهاز.",
            ),

            section(
              "استخدام البيانات",
              "تستخدم البيانات من أجل:\n"
              "• تنفيذ الرحلات.\n"
              "• تحسين الخدمة.\n"
              "• توفير الدعم الفني.\n"
              "• حماية الحساب.",
            ),

            section(
              "مشاركة البيانات",
              "لا تتم مشاركة بياناتك مع أي طرف ثالث إلا عند الحاجة لتقديم الخدمة أو إذا تطلب القانون ذلك.",
            ),

            section(
              "الموقع الجغرافي",
              "يتم استخدام الموقع فقط أثناء تشغيل التطبيق لتحديد موقع السائق والعميل وتنفيذ الرحلات.",
            ),

            section(
              "الأمان",
              "يتم تخزين البيانات باستخدام خدمات Firebase مع تطبيق إجراءات حماية مناسبة.",
            ),

            section(
              "التواصل",
              "إذا كانت لديك أي استفسارات يمكنك التواصل مع فريق الدعم من خلال مركز المساعدة داخل التطبيق.",
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}