import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final double total;
  final double subtotal;
  final double taxShare;
  final double tipShare;
  final List<Map<String, dynamic>> items;

  const PersonCard({
    super.key,
    required this.name,
    required this.total,
    required this.subtotal,
    required this.taxShare,
    required this.tipShare,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['splitCount'] > 1
                          ? "${item['name']} (split ${item['splitCount']} ways)"
                          : item['name'],
                      style: TextStyle(fontSize: 15,color: Colors.black),
                    ),
                    Text(
                      "\$${item['splitPrice'].toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 15,color: Colors.black),
                    ),
                  ],
                ),
              )),
              Divider(color: Colors.grey[300],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal", style: TextStyle(color: Colors.black54)),
                  Text("\$${subtotal.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tax share", style: TextStyle(color: Colors.black54)),
                  Text("\$${taxShare.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tip share", style: TextStyle(color: Colors.black54)),
                  Text("\$${tipShare.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}