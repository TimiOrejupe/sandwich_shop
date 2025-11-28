import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('Cart model', () {
    late Sandwich footlongTuna;
    late Sandwich sixInchVeggie;

    setUp(() {
      footlongTuna = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.white,
      );
      sixInchVeggie = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
    });

    test('addItem adds new item and increments existing quantity', () {
      final cart = Cart();
      cart.addItem(footlongTuna);
      expect(cart.items.length, 1);
      expect(cart.items.first.sandwich.type, SandwichType.tunaMelt);
      expect(cart.items.first.quantity, 1);

      cart.addItem(footlongTuna, 2);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 3);
    });

    test('removeItem decreases quantity and removes item when zero', () {
      final cart = Cart();
      cart.addItem(footlongTuna, 3);
      expect(cart.items.first.quantity, 3);

      cart.removeItem(footlongTuna, 2);
      expect(cart.items.first.quantity, 1);

      cart.removeItem(footlongTuna, 1);
      expect(cart.items.isEmpty, isTrue);
    });

    test('setQuantity updates, adds, and removes items correctly', () {
      final cart = Cart();

      // set quantity for an item not present -> adds it
      cart.setQuantity(sixInchVeggie, 2);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 2);

      // update existing item
      cart.setQuantity(sixInchVeggie, 5);
      expect(cart.items.first.quantity, 5);

      // set to zero -> removes
      cart.setQuantity(sixInchVeggie, 0);
      expect(cart.items.isEmpty, isTrue);
    });

    test('calculatePriceForItem and totalPrice use PricingRepository rates', () {
      final cart = Cart(); // uses default PricingRepository (6"=7.0, footlong=11.0)

      cart.addItem(footlongTuna, 2); // 2 * 11.0 = 22.0
      cart.addItem(sixInchVeggie, 3); // 3 * 7.0 = 21.0

      final itemPrices = cart.items.map(cart.calculatePriceForItem).toList();
      expect(itemPrices.length, 2);
      expect(itemPrices[0], 22.0);
      expect(itemPrices[1], 21.0);

      expect(cart.totalPrice(), 43.0);
    });

    test('Cart accepts custom PricingRepository', () {
      final customPricing = PricingRepository(sixInchPrice: 5.0, footlongPrice: 10.0);
      final cart = Cart(pricingRepository: customPricing);

      cart.addItem(footlongTuna, 1); // 10.0
      cart.addItem(sixInchVeggie, 2); // 2 * 5.0 = 10.0

      expect(cart.totalPrice(), 20.0);
    });

    test('addItem with non-positive quantity does nothing', () {
      final cart = Cart();
      cart.addItem(footlongTuna, 0);
      expect(cart.items, isEmpty);
      cart.addItem(footlongTuna, -3);
      expect(cart.items, isEmpty);
    });

    test('removeItem with non-positive quantity does nothing', () {
      final cart = Cart();
      cart.addItem(footlongTuna, 2);
      cart.removeItem(footlongTuna, 0);
      expect(cart.items.first.quantity, 2);
      cart.removeItem(footlongTuna, -1);
      expect(cart.items.first.quantity, 2);
    });
  });
}
```// filepath: c:\FlutterProjects\sandwich_shop\test\models\cart_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('Cart model', () {
    late Sandwich footlongTuna;
    late Sandwich sixInchVeggie;

    setUp(() {
      footlongTuna = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.white,
      );
      sixInchVeggie = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
    });

    test('addItem adds new item and increments existing quantity', () {
      final cart = Cart();
      cart.addItem(footlongTuna);
      expect(cart.items.length, 1);
      expect(cart.items.first.sandwich.type, SandwichType.tunaMelt);
      expect(cart.items.first.quantity, 1);

      cart.addItem(footlongTuna, 2);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 3);
    });

    test('removeItem decreases quantity and removes item when zero', () {
      final cart = Cart();
      cart.addItem(footlongTuna, 3);
      expect(cart.items.first.quantity, 3);

      cart.removeItem(footlongTuna, 2);
      expect(cart.items.first.quantity, 1);

      cart.removeItem(footlongTuna, 1);
      expect(cart.items.isEmpty, isTrue);
    });

    test('setQuantity updates, adds, and removes items correctly', () {
      final cart = Cart();

      // set quantity for an item not present -> adds it
      cart.setQuantity(sixInchVeggie, 2);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 2);

      // update existing item
      cart.setQuantity(sixInchVeggie, 5);
      expect(cart.items.first.quantity, 5);

      // set to zero -> removes
      cart.setQuantity(sixInchVeggie, 0);
      expect(cart.items.isEmpty, isTrue);
    });

    test('calculatePriceForItem and totalPrice use PricingRepository rates', () {
      final cart = Cart(); // uses default PricingRepository (6"=7.0, footlong=11.0)

      cart.addItem(footlongTuna, 2); // 2 * 11.0 = 22.0
      cart.addItem(sixInchVeggie, 3); // 3 * 7.0 = 21.0

      final itemPrices = cart.items.map(cart.calculatePriceForItem).toList();
      expect(itemPrices.length, 2);
      expect(itemPrices[0], 22.0);
      expect(itemPrices[1], 21.0);

      expect(cart.totalPrice(), 43.0);
    });

    test('Cart accepts custom PricingRepository', () {
      final customPricing = PricingRepository(sixInchPrice: 5.0, footlongPrice: 10.0);
      final cart = Cart(pricingRepository: customPricing);

      cart.addItem(footlongTuna, 1); // 10.0
      cart.addItem(sixInchVeggie, 2); // 2 * 5.0 = 10.0

      expect(cart.totalPrice(), 20.0);
    });

    test('addItem with non-positive quantity does nothing', () {
      final cart = Cart();
      cart.addItem(footlongTuna, 0);
      expect(cart.items, isEmpty);
      cart.addItem(footlongTuna, -3);
      expect(cart.items, isEmpty);
    });

    test('removeItem with non-positive quantity does nothing', () {
      final cart = Cart();
      cart.addItem(footlongTuna, 2);
      cart.removeItem(footlongTuna, 0);
      expect(cart.items.first.quantity, 2);
      cart.removeItem(footlongTuna, -1);
      expect(cart.items.first.quantity, 2);
    });