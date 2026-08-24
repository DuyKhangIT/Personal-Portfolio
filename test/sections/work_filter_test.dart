import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/data/portfolio_data.dart';
import 'package:personal_portfolio/sections/work_section.dart';

void main() {
  test('a null category returns everything, in order', () {
    final result = filterProjects(PortfolioData.projects, null);
    expect(result, hasLength(6));
    expect(result.first.id, PortfolioData.projects.first.id);
  });

  test('production returns only production projects', () {
    final result =
        filterProjects(PortfolioData.projects, ProjectCategory.production);
    expect(result, hasLength(3));
    expect(
      result.every((p) => p.category == ProjectCategory.production),
      isTrue,
    );
  });

  test('enterprise returns only enterprise projects', () {
    final result =
        filterProjects(PortfolioData.projects, ProjectCategory.enterprise);
    expect(result, hasLength(3));
    expect(
      result.every((p) => p.category == ProjectCategory.enterprise),
      isTrue,
    );
  });
}
