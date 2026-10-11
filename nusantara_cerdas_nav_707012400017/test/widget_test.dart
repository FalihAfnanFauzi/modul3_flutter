import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nusantara_cerdas_nav_707012400017/main.dart';
import 'package:nusantara_cerdas_nav_707012400017/models/favorit_model.dart';
import 'package:nusantara_cerdas_nav_707012400017/models/pengajuan_model.dart';

void main() {
  testWidgets('NusantaraCerdasApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoritModel()),
          ChangeNotifierProvider(create: (_) => PengajuanModel()),
        ],
        child: const NusantaraCerdasApp(),
      ),
    );

    expect(find.text('Nusantara Cerdas'), findsWidgets);
  });
}
