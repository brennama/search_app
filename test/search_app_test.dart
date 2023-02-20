import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:search_app/search_app.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'dart:async';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadAppFonts();
  await testMain();
}

extension AwaitImages on WidgetTester{
  Future<void> awaitImages() async {
    await runAsync(() async {
      for (final element in find.byType(Image).evaluate()) {
        final widget = element.widget as Image;
        final image = widget.image;
        await precacheImage(image, element);
        await pumpAndSettle();
      }
      for (final element in find.byType(DecoratedBox).evaluate()) {
        final widget = element.widget as DecoratedBox;
        final decoration = widget.decoration;
        if (decoration is BoxDecoration) {
          final image = decoration.image?.image;
          if (image != null) {
            await precacheImage(image, element);
            await pumpAndSettle();
          }
        }
      }
    });
  }

}

void main() {
  group('Search App', () {
    testWidgets('matches golden file', (tester) async {
      final avenirFont = rootBundle.load('/Users/brennamahn/search_app/assets/fonts/AvenirNextLTPro-Regular.otf');

      final avenirFontLoader = FontLoader('Avenir')..addFont(avenirFont);
      await avenirFontLoader.load();

      final sfFont = rootBundle.load('/Users/brennamahn/search_app/assets/fonts/FontsFree-Net-SFProDisplay-Regular.ttf');

      final sfFontLoader = FontLoader('SF Pro')..addFont(sfFont);
      await sfFontLoader.load();

      await tester.pumpWidget(const SearchApp());
      await tester.awaitImages();
      await expectLater(
        find.byType(SearchApp),
        matchesGoldenFile('goldens/search_app.png'),
      );
    }
    );
  });

}