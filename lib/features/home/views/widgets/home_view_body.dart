import 'package:bitesplit/app/theme.dart';
import 'package:bitesplit/app/theme_toggle_button.dart';
import 'package:bitesplit/features/bill_split/views/bill_split_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:bitesplit/models/people_group.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // current theme
    // final colors = theme.colorScheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
             theme.brightness == Brightness.dark
                ? const Color(0xFF0D0D0D) // darker gradient
                : const Color(0xffeff7fe),
            theme.brightness == Brightness.dark
                ? const Color(0xFF1F1F1F)
                : const Color(0xffeffcf5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Main content centered
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 36, 
                    backgroundColor: Color(0xff2b7fff),
                    child: ClipOval(
                      child: Image.asset(
                       Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/Icon1_dark.png'
                        : 'assets/images/Icon1.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text('BiteSplit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  fontSize: 28),),
                   Text('Split bills fairly with friends',
                  style: TextStyle(fontWeight: FontWeight.bold,
                  color: Color(0xff9CA3AF ),
                  fontSize: 12
                  ),),
                  SizedBox(height: 10,),
                  Container(
                    width: 340,
                    height: 300,
                    
                     decoration: BoxDecoration(
                     color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Colors.white, 
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                        color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black54 
                        : Colors.black12, 
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/Icon2.png',
                              width: 70,
                              height: 70
                              ,
                            ),
                            Text("Add your friends names",
                             style: TextStyle(
                                fontWeight: FontWeight.w600,
                ),
                
                            )
                          
                          ],
                        ),
                         Row(
                          children: [
                          Image.asset(
                              'assets/images/Icon3.png',
                              width: 70,
                              height: 70
                              ,
                            ),
                            Text("Enter Items prices and taxes",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                ),)
                          
                          ],
                        ),
                         Row(
                          children: [
                           Image.asset(
                              'assets/images/Icon4.png',
                              width: 70,
                              height: 70
                              ,
                            ),
                            Text("Get fair split calculation",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                ),
                            )
                          
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  MaterialButton(
                    onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillSplitView(
                              initialPeople: [], 
                            ),
                          ),
                        );
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
                  SizedBox(height: 20,),
                   Align(
                    alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 20),
                       child: Text(
                        "Choose from your saved groups",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xff2b7fff),
                        ),
                        textAlign: TextAlign.right,
                                         ),
                     ),
                   ),
                  SizedBox(height: 20,),
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(

                       padding: const EdgeInsets.only(left: 20),
                      child: PeopleGroupWidget(),
                    )), 
                   
                   
                   
                ],
              ),
            ),
            // Toggle button 
            Positioned(
              top: 40,
              right: 20,
              child: ThemeToggleButton(
                isDarkMode: Provider.of<ThemeProvider>(context).isDarkMode,
                onToggle: (isOn) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(isOn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                                radius: 30,
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