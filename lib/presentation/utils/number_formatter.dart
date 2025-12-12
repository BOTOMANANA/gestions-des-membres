import 'package:intl/intl.dart';

class NumberFormatter {
  static final _integerFormatter = NumberFormat('#,##0', 'fr_FR');

  static final _decimalFormatter = NumberFormat.currency(
    locale: 'fr_FR',
    symbol: '',
    decimalDigits: 2,
  );

  static String formatAmount({required num amount, required String symbol}) {
    if (amount == amount.toInt()) {
      return _integerFormatter.format(amount) + symbol;
    }
    return _decimalFormatter.format(amount) + symbol;
  }
}
