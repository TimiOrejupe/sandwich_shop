// ...new file...
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    test('default prices - six-inch single', () {
      const repo = PricingRepository();
      expect(repo.totalPrice(quantity: 1, isFootlong: false), equals(7.0));
    });

    test('default prices - footlong single', () {
      const repo = PricingRepository();
      expect(repo.totalPrice(quantity: 1, isFootlong: true), equals(11.0));
    });

    test('quantity multiplies price', () {
      const repo = PricingRepository();
      expect(repo.totalPrice(quantity: 3, isFootlong: false), equals(21.0));
      expect(repo.totalPrice(quantity: 4, isFootlong: true), equals(44.0));
    });

    test('zero quantity returns zero', () {
      const repo = PricingRepository();
      expect(repo.totalPrice(quantity: 0, isFootlong: true), equals(0.0));
      expect(repo.totalPrice(quantity: 0, isFootlong: false), equals(0.0));
    });

    test('supports custom prices via constructor', () {
      const repo = PricingRepository(sixInchPrice: 5.5, footlongPrice: 9.25);
      expect(repo.totalPrice(quantity: 2, isFootlong: false), equals(11.0));
      expect(repo.totalPrice(quantity: 3, isFootlong: true), equals(27.75));
    });
  });
}
// ...new file...