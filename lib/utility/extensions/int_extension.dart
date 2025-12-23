import 'package:intl/intl.dart';

extension IntExtension on int {
  String toRupiah() {
    try {
      final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
      return formatCurrency.format(this);
    } catch (e) {
      return toString();
    }
  }
}

extension DoubleExtension on double {
  String toRupiah() {
    try {
      final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
      return formatCurrency.format(this);
    } catch (e) {
      return toString();
    }
  }
}

extension NumExtension on num {
  String get toRupiah {
    try {
      final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
      return formatCurrency.format(this);
    } catch (e) {
      return toString();
    }
  }
}