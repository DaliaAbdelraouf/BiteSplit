import 'package:bitesplit/features/bill_split/views/widgets/bill_split_view_body.dart';
import 'package:flutter/material.dart';

class BillSplitView extends StatelessWidget {
  final List<String>? initialPeople;
  const BillSplitView({super.key, this.initialPeople});

  static const String id = 'BillSplitView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BillSplitViewBody(initialPeople: initialPeople),
    );
  }
}