import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:state_interaksi_707012400017/main.dart';
import 'package:state_interaksi_707012400017/models/keranjang_model.dart';

void main() {
  testWidgets('AplikasiKantin smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => KeranjangModel(),
        child: const AplikasiKantin(),
      ),
    );

    expect(find.text('Menu Kantin'), findsOneWidget);
  });
}
