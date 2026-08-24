import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/theme/editorial_type.dart';

void main() {
  test('scale clamps below the small breakpoint', () {
    expect(EditorialType.scale(390, min: 64, max: 160), 64);
  });

  test('scale clamps above the large breakpoint', () {
    expect(EditorialType.scale(1920, min: 64, max: 160), 160);
  });

  test('scale interpolates linearly between breakpoints', () {
    // midpoint of 900..1440 is 1170
    expect(EditorialType.scale(1170, min: 64, max: 160), closeTo(112, 0.01));
  });
}
