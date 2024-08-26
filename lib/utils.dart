import 'package:intl/intl.dart';

String removeRupeeSymbol(String amountWithSymbol) {
  // Check if the string starts with the ₹ symbol
  if (amountWithSymbol.startsWith('₹')) {
    // Remove the ₹ symbol from the start of the string
    return amountWithSymbol.substring(1).trim();
  }
  // Return the original string if ₹ symbol is not found
  return amountWithSymbol;
}

String formatToIndianCurrency(double amount) {
  // Convert the double to an integer (remove decimal part)
  int roundedAmount = amount.toInt();

  // Create a NumberFormat instance for Indian currency
  final numberFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0, // No decimal points
  );

  // Format the integer amount
  return removeRupeeSymbol(numberFormat.format(roundedAmount));
}

String formatIndianCurrency(int amount) {
  final formatter = NumberFormat('#,##,###');
  return formatter.format(amount);
}
