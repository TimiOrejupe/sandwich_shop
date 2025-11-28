import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

/// Simple cart model holding sandwich items and delegating pricing to
/// PricingRepository (single source of truth for prices).
class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({
    required this.sandwich,
    this.quantity = 1,
  });
}

class Cart {
  final PricingRepository pricingRepository;
  final List<CartItem> _items = [];

  Cart({PricingRepository? pricingRepository})
      : pricingRepository = pricingRepository ?? const PricingRepository();

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(Sandwich sandwich, [int quantity = 1]) {
    if (quantity <= 0) return;
    final idx = _items.indexWhere((it) =>
        it.sandwich.type == sandwich.type &&
        it.sandwich.isFootlong == sandwich.isFootlong &&
        it.sandwich.breadType == sandwich.breadType);
    if (idx >= 0) {
      _items[idx].quantity += quantity;
    } else {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
  }

  void removeItem(Sandwich sandwich, [int quantity = 1]) {
    if (quantity <= 0) return;
    final idx = _items.indexWhere((it) =>
        it.sandwich.type == sandwich.type &&
        it.sandwich.isFootlong == sandwich.isFootlong &&
        it.sandwich.breadType == sandwich.breadType);
    if (idx < 0) return;
    final item = _items[idx];
    if (item.quantity > quantity) {
      item.quantity -= quantity;
    } else {
      _items.removeAt(idx);
    }
  }

  void setQuantity(Sandwich sandwich, int quantity) {
    if (quantity < 0) return;
    final idx = _items.indexWhere((it) =>
        it.sandwich.type == sandwich.type &&
        it.sandwich.isFootlong == sandwich.isFootlong &&
        it.sandwich.breadType == sandwich.breadType);
    if (idx >= 0) {
      if (quantity == 0) {
        _items.removeAt(idx);
      } else {
        _items[idx].quantity = quantity;
      }
    } else if (quantity > 0) {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
  }

  void clear() => _items.clear();

  /// Calculate price for a single cart item by delegating to the
  /// PricingRepository (uses the sandwich size to pick unit price).
  double calculatePriceForItem(CartItem item) {
    return pricingRepository.totalPrice(
      quantity: item.quantity,
      isFootlong: item.sandwich.isFootlong,
    );
  }

  /// Calculate total price for the whole cart.
  double totalPrice() {
    return _items.fold<double>(
      0.0,
      (sum, item) => sum + calculatePriceForItem(item),
    );
  }