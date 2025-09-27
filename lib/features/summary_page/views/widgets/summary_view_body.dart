import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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
  final GlobalKey _summaryKey = GlobalKey();
  bool _markedAsPaid = false; 
  
void _showPaidAnimation(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent, // <-- No shady overlay
    builder: (context) {
      return Center(
        child: Lottie.asset(
          'assets/animations/Confetti - Full Screen.json',
          repeat: false,
          onLoaded: (composition) {
            Future.delayed(composition.duration, () {
              Navigator.of(context).pop();
            });
          },
        ),
      );
    },
  );
}

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
        markedAsPaid: _markedAsPaid,
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
            color: Colors.white, 
            child: RepaintBoundary(
              key: _summaryKey,
              child: Container(
                width: 400,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white, 
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Material(
                                  elevation: 8, // shadow
                                  borderRadius: BorderRadius.circular(12),
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                          _markedAsPaid = true;
                                        });
                                    _showPaidAnimation(context);
                                    },
                                    color: Color(0xfff00A63E),
                                    minWidth: 150,
                                    height: 50,
                                    shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                 children: [
                Icon(Icons.check_circle_rounded, color: Colors.white, size: 16),
                SizedBox(width: 7,),
                   const Text(
                     'Mark as Paid',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 14,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ],
                                    ),
                                  ),
                                ),
                SizedBox(width: 10,),
                      MaterialButton(
                       onPressed: () {
                         Navigator.pop(context);
                       },
                        color: Colors.white,
                        minWidth: 150,
                       height: 50,
                        shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(12),
                       ),
                       child: Text(
                         'Edit Order',
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 14,
                           fontWeight: FontWeight.bold,
                         ),
                       ), 
                      ),
                    ],
                  ),
                   SizedBox(height: 10,),

                      Padding(
                     padding: const EdgeInsets.only(top: 5,bottom: 5),
                     child: Material(
                  elevation: 8, // shadow
                  borderRadius: BorderRadius.circular(12),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst); 
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const BillSplitView()), 
                      );
                    },
                     color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Colors.black, 
                    minWidth: 320,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Start a New Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),),

                   SizedBox(height: 5,),
                 Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    child: Center(
                      child: Container(
                        width: 220,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff3a8b3c), Color(0xff38bdf8)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            await Future.delayed(Duration(milliseconds: 100));
                            await _shareSummaryImage();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.ios_share_outlined, color: Colors.white, size: 22),
                              SizedBox(width: 8),
                              Text(
                                'Share this Summary',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
//   String buildSummaryText(double grandTotal, double totalItemsSum, double tax, double tip, List<PersonSummary> personSummaries) {
//   StringBuffer buffer = StringBuffer();
//   buffer.writeln('Total Bill: \$${grandTotal.toStringAsFixed(2)}');
//   buffer.writeln('Subtotal: \$${totalItemsSum.toStringAsFixed(2)}');
//   buffer.writeln('Tax: \$${tax.toStringAsFixed(2)}');
//   buffer.writeln('Tip: \$${tip.toStringAsFixed(2)}\n');
//   for (var person in personSummaries) {
//     buffer.writeln('${person.name}: \$${person.total.toStringAsFixed(2)}');
//     for (var item in person.items) {
//       buffer.writeln('  - ${item['name']} (\$${item['splitPrice'].toStringAsFixed(2)})');
//     }
//     buffer.writeln('  Subtotal: \$${person.subtotal.toStringAsFixed(2)}');
//     buffer.writeln('  Tax share: \$${person.taxShare.toStringAsFixed(2)}');
//     buffer.writeln('  Tip share: \$${person.tipShare.toStringAsFixed(2)}\n');
//   }
//   return buffer.toString();
// }

Future<void> _shareSummaryImage() async {
  try {
    if (_summaryKey.currentContext == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Summary not ready to share')),
      );
      return;
    }
    RenderRepaintBoundary boundary =
        _summaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/summary.png').create();
    await file.writeAsBytes(pngBytes);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Check out our bill summary!',
      ),
    );
  } catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Failed to share image: $e')),
  );
}

}

}