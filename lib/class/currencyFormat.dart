import 'package:intl/intl.dart';

class CurrencyFormat {
  static String format(int decimalDigit, double value) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(value);
  }
}
