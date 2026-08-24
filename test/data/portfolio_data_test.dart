import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/data/portfolio_data.dart';

void main() {
  test('has six projects with unique ids', () {
    expect(PortfolioData.projects, hasLength(6));
    final ids = PortfolioData.projects.map((p) => p.id).toSet();
    expect(ids, hasLength(6));
  });

  test('splits three production and three enterprise projects', () {
    int count(ProjectCategory c) =>
        PortfolioData.projects.where((p) => p.category == c).length;
    expect(count(ProjectCategory.production), 3);
    expect(count(ProjectCategory.enterprise), 3);
  });

  test('every project carries bullets, tech and an impact headline', () {
    for (final p in PortfolioData.projects) {
      expect(p.bullets, isNotEmpty, reason: p.id);
      expect(p.tech, isNotEmpty, reason: p.id);
      expect(p.impact, isNotEmpty, reason: p.id);
    }
  });

  test('has four expertise items, seven stack groups, three experiences', () {
    expect(PortfolioData.expertise, hasLength(4));
    expect(PortfolioData.stack, hasLength(7));
    expect(PortfolioData.experiences, hasLength(3));
  });

  test('cover assets, when present, live under the projects asset folder', () {
    for (final p in PortfolioData.projects) {
      if (p.coverAsset != null) {
        expect(p.coverAsset, startsWith('assets/images/projects/'), reason: p.id);
      }
    }
  });

  test('every experience references projects that exist', () {
    final ids = PortfolioData.projects.map((p) => p.id).toSet();
    for (final e in PortfolioData.experiences) {
      expect(e.projectIds, isNotEmpty, reason: e.company);
      for (final id in e.projectIds) {
        expect(ids, contains(id), reason: '${e.company} -> $id');
      }
    }
  });
}
