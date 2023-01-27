import 'package:intl/intl.dart';

class ConvertToCurrency{
  static convertCurrency(double price){
    final myCurrency=NumberFormat.simpleCurrency();
    return myCurrency.format(price);
  }
}