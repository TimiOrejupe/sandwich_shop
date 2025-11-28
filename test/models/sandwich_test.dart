import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    test('name getter returns expected display name for each type', () {
      final expectedNames = {
        SandwichType.veggieDelight: 'Veggie Delight',
        SandwichType.chickenTeriyaki: 'Chicken Teriyaki',
        SandwichType.tunaMelt: 'Tuna Melt',
        SandwichType.meatballMarinara: 'Meatball Marinara',
      };

      expectedNames.forEach((type, expected) {
        final sandwich = Sandwich(
          type: type,
          isFootlong: true,
          breadType: BreadType.white,
        );
        expect(sandwich.name, equals(expected));
      });
    });

    test('image getter returns correct asset path for footlong and six-inch', () {
      for (final type in SandwichType.values) {
        final footlong = Sandwich(
          type: type,
          isFootlong: true,
          breadType: BreadType.wheat,
        );
        expect(footlong.image, 'assets/images/${type.name}_footlong.png');

        final sixInch = Sandwich(
          type: type,
          isFootlong: false,
          breadType: BreadType.wheat,
        );
        expect(sixInch.image, 'assets/images/${type.name}_six_inch.png');
      }
    });
  });
}
