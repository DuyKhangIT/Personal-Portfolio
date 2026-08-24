import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/theme/editorial_motion.dart';
import 'package:personal_portfolio/widgets/motion/reveal_on_scroll.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(() {
    // Fire visibility callbacks on the next frame instead of on a timer.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  Opacity opacityOf(WidgetTester tester) => tester.widget<Opacity>(
        find.descendant(
          of: find.byType(RevealOnScroll),
          matching: find.byType(Opacity),
        ),
      );

  testWidgets('starts hidden and becomes fully visible once revealed',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: RevealOnScroll(child: Text('hello'))),
      ),
    );

    expect(opacityOf(tester).opacity, 0.0);

    await tester.pump();
    await tester.pump(EditorialMotion.revealDuration);

    expect(opacityOf(tester).opacity, 1.0);
  });

  testWidgets('a delayed reveal stays hidden until its delay elapses',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RevealOnScroll(
            delay: Duration(milliseconds: 400),
            child: Text('later'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(opacityOf(tester).opacity, 0.0);

    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(EditorialMotion.revealDuration);
    expect(opacityOf(tester).opacity, 1.0);
  });
}
