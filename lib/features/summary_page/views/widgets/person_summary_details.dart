import 'package:bitesplit/models/bill_item.dart';

class PersonSummary {
  final String name;
  final double subtotal;
  final double taxShare;
  final double tipShare;
  final double total;
  final List<Map<String, dynamic>> items;

  PersonSummary({
    required this.name,
    required this.subtotal,
    required this.taxShare,
    required this.tipShare,
    required this.total,
    required this.items,
  });
}

class BillSummaryCalculator {
  static double getTotalItemsSum(List<BillItem> billItems) {
    double sum = 0;
    for (var item in billItems) {
      sum += item.price;
    }
    return sum;
  }

  static List<PersonSummary> getPersonSummaries(
    List<BillItem> billItems,
    double taxValue,
    double tipValue,
  ) {
    double totalItemsSum = getTotalItemsSum(billItems);
    final people = <String>{};
    for (var item in billItems) {
      people.addAll(item.assignedTo);
    }

    List<PersonSummary> summaries = [];
    for (var person in people) {
      List<BillItem> assignedItems = billItems
          .where((item) => item.assignedTo.contains(person))
          .toList();

      double personSubtotal = 0;
      List<Map<String, dynamic>> itemDetails = [];
      for (var item in assignedItems) {
        int splitCount = item.assignedTo.length;
        double splitPrice = item.price / splitCount;
        personSubtotal += splitPrice;
        itemDetails.add({
          'name': item.name,
          'splitCount': splitCount,
          'splitPrice': splitPrice,
        });
      }

      double taxShare = totalItemsSum == 0 ? 0 : personSubtotal / totalItemsSum * taxValue;
      double tipShare = totalItemsSum == 0 ? 0 : personSubtotal / totalItemsSum * tipValue;
      double personTotal = personSubtotal + taxShare + tipShare;

      summaries.add(PersonSummary(
        name: person,
        subtotal: personSubtotal,
        taxShare: taxShare,
        tipShare: tipShare,
        total: personTotal,
        items: itemDetails,
      ));
    }
    return summaries;
  }
}