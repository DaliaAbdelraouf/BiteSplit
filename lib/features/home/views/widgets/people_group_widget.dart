import 'package:bitesplit/features/bill_split/views/bill_split_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:bitesplit/models/people_group.dart';

class PeopleGroupWidget extends StatelessWidget {
  const PeopleGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box<PeopleGroup>>(
      future: Hive.openBox<PeopleGroup>('groups'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SizedBox();
        final box = snapshot.data!;
        if (box.values.isEmpty) return SizedBox();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: box.values.map((group) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillSplitView(
                          initialPeople: group.people, 
                        ),
                      ),
                    );
},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Color.fromARGB(255, 160, 170, 185), Color(0xff66a6ff)],
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 27,
                                backgroundColor: Colors.white,
                                child: Text(
                                  group.name[0].toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 1,
                              right: 2,
                              child: GestureDetector(
                                onTap: () async {
                                  final box = Hive.box<PeopleGroup>('groups');
                                  await box.delete(group.key); // Remove group 
                                  (context as Element).markNeedsBuild(); 
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffEF4444),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          group.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          "${group.people.length} member${group.people.length == 1 ? '' : 's'}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}