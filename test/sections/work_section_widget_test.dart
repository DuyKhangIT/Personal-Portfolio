import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/data/portfolio_data.dart';
import 'package:personal_portfolio/sections/work_section.dart';
import 'package:personal_portfolio/widgets/project_card.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  Future<void> pumpSection(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: WorkSection(onOpenProject: (_) {}),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('renders every project by default', (tester) async {
    await pumpSection(tester);
    expect(find.byType(ProjectCard), findsNWidgets(6));
  });

  testWidgets('tapping a filter narrows the grid to that category',
      (tester) async {
    await pumpSection(tester);

    await tester.tap(find.text(ProjectCategory.enterprise.filterLabel));
    await tester.pump();

    expect(find.byType(ProjectCard), findsNWidgets(3));
    // The name appears twice per card — once on the cover, once as the title.
    expect(find.text('Rail Pro App'), findsNWidgets(2));
    expect(find.text('Rocky App'), findsNothing);
  });

  testWidgets('opening a project reports the tapped item', (tester) async {
    ProjectItem? opened;

    tester.view.physicalSize = const Size(1440, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: WorkSection(onOpenProject: (p) => opened = p),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byType(ProjectCard).first);
    await tester.pump();

    expect(opened?.id, PortfolioData.projects.first.id);
  });
}
