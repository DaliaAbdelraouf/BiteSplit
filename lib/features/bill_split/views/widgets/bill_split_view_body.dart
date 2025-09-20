import 'dart:developer';

import 'package:bitesplit/features/splash/views/widgets/person_widget.dart';
import 'package:bitesplit/models/bill_item.dart';
import 'package:bitesplit/models/person.dart';
import 'package:flutter/material.dart';

class BillSplitViewBody extends StatefulWidget {
  const BillSplitViewBody({super.key});

  @override
  State<BillSplitViewBody> createState() => _BillSplitViewBodyState();
}

class _BillSplitViewBodyState extends State<BillSplitViewBody> {
   final TextEditingController _personNameController = TextEditingController();
    final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController(); 
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _tipPriceController = TextEditingController();
   List<Person> _people = [];
   List<BillItem> _billItems = [];
   double? taxValue;
   double? tipValue;

  void _addPerson() {
    if (_personNameController.text.isNotEmpty) {
      setState(() {
        _people.add(Person(
          name: _personNameController.text,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        ));
        _personNameController.clear();
      });
    }
  }
  
  void _removePerson(String personName) {
    setState(() {
      _people.removeWhere((person) => person.name == personName);
      
      // Remove person from all bill items
      for (BillItem item in _billItems) {
        item.assignedTo.remove(personName);
      }
    });
  }


    void _addItem() {
    if (_itemNameController.text.isNotEmpty && _itemPriceController.text.isNotEmpty) {
      final price = double.tryParse(_itemPriceController.text);
      if (price != null) {
        setState(() {
          _billItems.add(BillItem(
            name: _itemNameController.text,
            price: price,
            assignedTo: [],
          ));
          _itemNameController.clear();
          _itemPriceController.clear();

        });
      }
    }
  }
  void _removeItem(BillItem item) {
  setState(() {
    _billItems.remove(item);
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, // No shadow
        centerTitle: true,
        title: Image.asset(
                  'assets/images/Logo.png', 
                  width: 120,
                  height: 120,
                ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                      "Welcome to BiteSplit \nNo more bill drama, just good food & fair splits! 🍔🥤",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff9CA3AF)
                      ),
                    ),
                    SizedBox(height: 15,),
                Card(
                 elevation: 5, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color.fromARGB(255, 233, 233, 233), 
                      width: 1.5,
                    ),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people_outlined, color: Colors.blueGrey[700]),
                            const SizedBox(width: 10),
                             Text(
                              "Add People (${_people.length})",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _personNameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter person name',
                                   focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Color(0xff2b7fff), // Blue focus border
                                        width: 2,
                                      ),
                                    ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                onSubmitted: (_) => _addPerson(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: _addPerson,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.all(12),
                                backgroundColor: Color(0xff171717)
                              ),
                              child: const Icon(Icons.add,
                              color: Colors.white,
                             
                              ),
                            ),
                          ],
                        ),
                        if (_people.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Wrap(
                            children: _people.map((person) {
                              return PersonWidget(
                                name: person.name,
                                onDelete: () => _removePerson(person.name),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,), // Add some space between the cards
                Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Color.fromARGB(255, 233, 233, 233),
              width: 1.5,
            ),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.attach_money_outlined, color: Colors.blueGrey[700]),
                    const SizedBox(width: 10),
                     Text(
                      'Items (${_billItems.length})',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _itemNameController,
                        
                        decoration: InputDecoration(
                          hintText: 'Item Name',
                          focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Color(0xff2b7fff), // Blue focus border
                                        width: 2,
                                      ),
                                    ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _itemPriceController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Item Price',
                          focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Color(0xff2b7fff), // Blue focus border
                                        width: 2,
                                      ),
                                    ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _addItem,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(12),
                        backgroundColor: Color(0xff171717),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
            
                if (_billItems.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Column(
                    children: _billItems.map((item) => Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(item.name,style: TextStyle(fontWeight: FontWeight.w400),),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('\$${item.price.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(width: 8),
                              IconButton(
                                iconSize: 19,
                                icon: Icon(Icons.remove, color: Colors.redAccent),
                                onPressed: () => _removeItem(item),
                                tooltip: 'Delete item',
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.only(right: 0, left: 0), 
                        ),
                        if (_people.isNotEmpty) ...[
                          Wrap(
                            spacing: 8,
                            children: _people.map((person) {
                              final isAssigned = item.assignedTo.contains(person.name);
                              return ChoiceChip(
                                label: Text(person.name,
                                  style: TextStyle(
                                    color: isAssigned ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                checkmarkColor: Colors.white,
                                selected: isAssigned,
                                selectedColor: Color(0xff171717),
                                backgroundColor: Color(0xfff3f6fa),
                                 shape: RoundedRectangleBorder( 
                                  borderRadius: BorderRadius.circular(16), 
                                ),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      item.assignedTo.add(person.name);
                                    } else {
                                      item.assignedTo.remove(person.name);
                                    }
                                    //Debuggging 
                                    for (var item in _billItems) {
                                    log('Item: ${item.name}, Assigned to: ${item.assignedTo.join(", ")}');
                                  }
                                 });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
              ],
            ),
          ),
              ),
               Card(
                 elevation: 5, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color.fromARGB(255, 233, 233, 233), 
                      width: 1.5,
                    ),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people_outlined, color: Colors.blueGrey[700]),
                            const SizedBox(width: 10),
                             Text(
                              "Tax & Tip",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                Row(
                  children: [
            
                    Expanded(
                      child: TextField(
                        controller: _taxController,
                        decoration: InputDecoration(
                          hintText: 'Enter Tax',
                          labelText: 'Taxs',
                          focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Color(0xff2b7fff), // Blue focus border
                                        width: 2,
                                      ),
                                    ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) {
                              setState(() {
                                taxValue = double.tryParse(value);
                              });
                            },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _tipPriceController,
                        decoration: InputDecoration(
                          labelText: "Tips",
                          hintText: 'Enter Tip',
                          focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Color(0xff2b7fff), 
                                        width: 2,
                                      ),
                                    ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      setState(() {
                        tipValue = double.tryParse(value);
                        // log("${taxValue}");
                        // log("${tipValue}");
                      });
                      
                    },
                      ),
                    ),
                  
                  
                  ],
                ),
                       
                      ],
                    ),
                  ),
                ),
             
               Padding(
                 padding: const EdgeInsets.only(top: 20,bottom: 20),
                 child: MaterialButton(
                  onPressed: () {
                      //  Navigator.pushNamed(context, BillSplitView.id);
                  },
                   color: Color(0xff2b7fff),
                  minWidth: 320,
                  height: 50,
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Start New Order',
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