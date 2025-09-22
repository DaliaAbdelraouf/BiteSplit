import 'package:bitesplit/features/summary_page/views/widgets/summary_view_body.dart';
import 'package:bitesplit/models/bill_item.dart';
import 'package:flutter/material.dart';

class SummaryView extends StatelessWidget {
  final List<BillItem> billItems;
  final double taxValue;
  final double tipValue;

   SummaryView({
    super.key,
    required this.billItems,
    required this.taxValue,
    required this.tipValue,
  });

  static const String id = 'SummaryView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SummaryViewBody(
        billItems: billItems,
        taxValue: taxValue,
        tipValue: tipValue,
      ),
    );
  }
}