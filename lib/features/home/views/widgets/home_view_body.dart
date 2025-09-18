import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffeff7fe),
              Color(0xffeffcf5)
            ],
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36, 
              backgroundColor: Color(0xff2b7fff),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/Icon1.png',
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
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
                        width: 50,
                        height: 50
                        ,
                      ),
                      Text("Add your friends names",
                  
                      )
                    
                    ],
                  ),
                   Row(
                    children: [
                      // Image.asset(
                      //   ''
                      // ),
                      Text("Enter Items,prices and taxes")
                    
                    ],
                  ),
                   Row(
                    children: [
                      // Image.asset(
                      //   ''
                      // ),
                      Text("Get fair split calculation")
                    
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            MaterialButton(
              onPressed: () {
                  //  Navigator.pushNamed(context, HomeView.id);
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
    );
  }
}