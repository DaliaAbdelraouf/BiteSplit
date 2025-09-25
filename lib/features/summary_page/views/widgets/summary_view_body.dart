import 'package:bitesplit/features/bill_split/views/bill_split_view.dart';
import 'package:bitesplit/features/summary_page/views/widgets/person_Summary_Card.dart';
import 'package:bitesplit/features/summary_page/views/widgets/person_summary_details.dart';
import 'package:bitesplit/models/bill_item.dart';
import 'package:flutter/material.dart';

class SummaryViewBody extends StatefulWidget {
  final List<BillItem> billItems;
  final double taxValue;
  final double tipValue;

  const SummaryViewBody({
    super.key,
    required this.billItems,
    required this.taxValue,
    required this.tipValue,
  });

  @override
  State<SummaryViewBody> createState() => _SummaryViewBodyState();
}

class _SummaryViewBodyState extends State<SummaryViewBody> {
  @override
  Widget build(BuildContext context) {
    double totalItemsSum = BillSummaryCalculator.getTotalItemsSum(widget.billItems);
    double grandTotal = totalItemsSum + widget.taxValue + widget.tipValue;

    List<PersonSummary> personSummaries = BillSummaryCalculator.getPersonSummaries(
      widget.billItems,
      widget.taxValue,
      widget.tipValue,
    );

    List<Widget> personCards = personSummaries.map((summary) {
      return PersonCard(
        name: summary.name,
        total: summary.total,
        subtotal: summary.subtotal,
        taxShare: summary.taxShare,
        tipShare: summary.tipShare,
        items: summary.items,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Bill Summary'),
        

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                          color: Color.fromARGB(255, 233, 233, 233), width: 1.7),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Bill",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400,color: Colors.grey),
                          ),
                          Text(
                            "\$ ${grandTotal.toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff22C55E)),
                          ),
                          Row(
                            children: [
                              Text(
                                "Subtotal:\$ ${totalItemsSum.toStringAsFixed(2)} ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 0.6)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Tax:\$ ${widget.taxValue.toStringAsFixed(2)} ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 0.6)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Tip:\$ ${widget.tipValue.toStringAsFixed(2)} ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 0.6)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: personCards,
                ),
              Padding(
                 padding: const EdgeInsets.only(top: 5,bottom: 5),
                 child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                   color: Colors.white,
                  minWidth: 320,
                  height: 50,
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Edit Order',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                 ),
               ),
               SizedBox(height: 10,),

                  Padding(
                 padding: const EdgeInsets.only(top: 5,bottom: 5),
                 child: MaterialButton(
                  onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst); 
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const BillSplitView()), 
                  );
                  },
                   color: Colors.black,
                  minWidth: 320,
                  height: 50,
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Start a New Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                 ),
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}