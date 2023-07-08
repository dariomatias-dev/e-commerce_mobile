import 'package:intl/intl.dart';

String formatToReal(double price) {
  NumberFormat realFormat =
      NumberFormat.currency(locale: "pt_BR", symbol: "R\$");

  return realFormat.format(price);
}
