import 'package:flutter_test/flutter_test.dart';
import 'package:oma_super_app/app/app.dart';
import 'package:oma_super_app/core/services/app_settings.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('OMA app starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppSettings(),
        child: const OmaApp(),
      ),
    );

    expect(find.byType(OmaApp), findsOneWidget);
  });
}
