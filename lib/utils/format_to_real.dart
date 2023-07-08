import 'package:intl/intl.dart';

String formatToReal(value) {
  NumberFormat realFormat =
      NumberFormat.currency(locale: "pt_BR", symbol: "R\$");

  double price = double.parse(value);

  return realFormat.format(price);
}
