import 'package:bitesplit/app/theme.dart';
import 'package:bitesplit/app/theme_toggle_button.dart';
import 'package:bitesplit/features/bill_split/views/bill_split_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

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
                         Navigator.pushNamed(context, BillSplitView.id);
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
                ],
              ),
            ),
            // Toggle button in top right
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