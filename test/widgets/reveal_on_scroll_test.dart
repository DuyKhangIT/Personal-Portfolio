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

  testWidgets('collapses to its child once the reveal has landed',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: RevealOnScroll(child: Text('hello'))),
      ),
    );

    // Settle rather than counting pumps: the reveal fires a frame after the
    // visibility callback, and the collapse a frame after the animation ends.
    await tester.pumpAndSettle();

    // A revealed section keeps neither a visibility detector nor the animation
    // wrappers — both cost UI-thread time on every subsequent scrolled frame.
    expect(
      find.descendant(
        of: find.byType(RevealOnScroll),
        matching: find.byType(VisibilityDetector),
      ),
      findsNothing,
    );
    expect(
      find.descendant(
        of: find.byType(RevealOnScroll),
        matching: find.byType(Opacity),
      ),
      findsNothing,
    );
    expect(find.text('hello'), findsOneWidget);
  });

  testWidgets('a reveal that never becomes visible keeps its child hidden',
      (tester) async {
    // Guards the collapse above: it must key off the animation completing, not
    // merely off time passing, or offscreen sections would pop in un-animated.
    // SingleChildScrollView, not ListView: a lazy list would never build the
    // offscreen child at all, and the test would pass without proving anything.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 2000),
                RevealOnScroll(child: Container(height: 50)),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(opacityOf(tester).opacity, 0.0);
    expect(
      find.descendant(
        of: find.byType(RevealOnScroll),
        matching: find.byType(VisibilityDetector),
      ),
      findsOneWidget,
    );
  });
}
