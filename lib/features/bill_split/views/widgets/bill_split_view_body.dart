import 'dart:developer';
import 'package:bitesplit/features/summary_page/views/summary_view.dart';
import 'package:bitesplit/models/bill_item.dart';
import 'package:bitesplit/models/people_group.dart';
import 'package:bitesplit/models/person.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BillSplitViewBody extends StatefulWidget {
  final List<String>? initialPeople;
  const BillSplitViewBody({super.key, this.initialPeople});

  @override
  State<BillSplitViewBody> createState() => _BillSplitViewBodyState();
}

class _BillSplitViewBodyState extends State<BillSplitViewBody> {
   final TextEditingController _personNameController = TextEditingController();
    final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController(); 
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _tipPriceController = TextEditingController();
   late List<Person> _people;
   final List<BillItem> _billItems = [];
  double taxValue = 0.0;
  double tipValue = 0.0;
 
 bool _saveAsGroup = false;
final TextEditingController _groupNameController = TextEditingController();


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
            count: 1
          ));
          _itemNameController.clear();
          _itemPriceController.clear();
         logItems();
        
        });
      }

    }
  }
  Future<void> saveGroup(String name, List<String> people) async {
  final box = Hive.box<PeopleGroup>('groups');
  final group = PeopleGroup(name: name, people: people);
  await box.add(group);
}
void logGroups() async {
  final box = Hive.box<PeopleGroup>('groups');
  for (var group in box.values) {
    log('Group: ${group.name}, People: ${group.people.join(", ")}');
  }
}

  void _removeItem(BillItem item) {
  setState(() {
    _billItems.remove(item);
  });
}

  void logItems() {
    for (var item in _billItems) {
      log('Item: ${item.name}, Price: ${item.price}, Count: ${item.count}, Assigned to: ${item.assignedTo.join(", ")}');
    }
  }
  @override
  void initState() {
    super.initState();
    _people = widget.initialPeople != null
        ? widget.initialPeople!
            .map((name) => Person(name: name, id: DateTime.now().millisecondsSinceEpoch.toString()))
            .toList()
        : [];

      
  }

  @override
  Widget build(BuildContext context) {
   // You can remove this line later
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, // No shadow
        centerTitle: true,
        title: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/logo_dark.png'
                        : 'assets/images/Logo.png',
                  width: 120,
                  height: 120,
                ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
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
                       color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Colors.white,
                      width: 1.5,
                    ),
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people_outlined, 
                             color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.blueGrey[700],
                            ),
                            const SizedBox(width: 10),
                             Text(
                              "Add People (${_people.length})",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
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
                                        color: Color(0xff2b7fff), 
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
                            spacing: 8,
                            children: _people.map((person) {
                              return Chip(
                                label: Text(
                                  person.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: Color(0xffededed),
                                shape: StadiumBorder(),
                                deleteIcon: Icon(Icons.close, size: 18),
                                deleteIconColor: Colors.black,
                                onDeleted: () {
                                  setState(() {
                                    _people.remove(person);
                                  });
                                },
                                // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              );
                            }).toList(),
                          ),
                        ],
                        Row(
                          children: [
                            Switch(
                              value: _saveAsGroup,
                              onChanged: (val) {
                                setState(() {
                                  _saveAsGroup = val;
                                });
                              },
                              activeColor: Color(0xff2b7fff),
                            ),
                            Text(
                              "Save as Group",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            if (_saveAsGroup) ...[
                              SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _groupNameController,
                                  decoration: InputDecoration(
                                    hintText: 'Group Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,), 
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
             color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Colors.white,
              width: 1.5,
            ),
          ),
          color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.attach_money_outlined, 
                   color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.blueGrey[700],
                    ),
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
                                        color: Color(0xff2b7fff), 
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
                                        color: Color(0xff2b7fff), 
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
                          title: Text(item.name,style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),),
                          
                          trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                         IconButton(
                          iconSize: 19,
                          icon: Icon(Icons.remove, color: Colors.redAccent),
                          onPressed: () {
                            setState(() {
                              if (item.count > 1) {
                                item.count -= 1;
                              } else {
                                _billItems.remove(item);
                              }
                            });
                          },
                          tooltip: 'Remove item',
                        ),
                        
                        Text(
                          'x${item.count}',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(width: 8),
                       IconButton(
                          icon: Icon(Icons.add, color: Colors.green),
                          tooltip: 'Duplicate item',
                          onPressed: () {
                            setState(() {
                              item.count += 1;
                              logItems();
                            });
                          },
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
                     color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Colors.white,
                      width: 1.5,
                    ),
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people_outlined, 
                       color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.blueGrey[700],
                            ),
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
                                 taxValue = double.tryParse(value) ?? 0.0;
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
                        tipValue = double.tryParse(value) ?? 0.0;
                        log("$taxValue");
                        log("$tipValue");
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
                  onPressed: () async {
                 if (_people.isEmpty || _billItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter all required data',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          backgroundColor: Color(0xffEF4444),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (!_billItems.every((item) => item.assignedTo.isNotEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please assign every item to at least one person',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              backgroundColor: Color(0xffEF4444),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          // Save group if toggled and valid
                          if (_saveAsGroup && _groupNameController.text.isNotEmpty && _people.isNotEmpty) {
                            await saveGroup(
                              _groupNameController.text,
                              _people.map((p) => p.name).toList(),
                            );
                             logGroups();
                            _groupNameController.clear();
                            setState(() {
                              _saveAsGroup = false;
                            });
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SummaryView(
                                billItems: _billItems,
                                taxValue: taxValue,
                                tipValue: tipValue,
                              ),
                            ),
                          );
                        }
                      },
                   color: Color(0xff2b7fff),
                  minWidth: 320,
                  height: 50,
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'View Summary',
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