class PricingRepository {
  final double sixInchPrice;
  final double footlongPrice;

  const PricingRepository({
    this.sixInchPrice = 7.0,
    this.footlongPrice = 11.0,
  });

  /// Calculate total price for [quantity]. If [isFootlong] is true the
  /// footlong price is used, otherwise the six-inch price is used.
  double totalPrice({required int quantity, required bool isFootlong}) {
    if (quantity <= 0) return 0.0;
    final unit = isFootlong ? footlongPrice : sixInchPrice;
    return unit * quantity;
  }
}