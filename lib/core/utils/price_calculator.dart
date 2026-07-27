class PriceCalculator {
  PriceCalculator._();

  static double taxi(double km) {
    return 2500 + (km * 500);
  }

  static double tuk(double km) {
    return 1500 + (km * 350);
  }
}