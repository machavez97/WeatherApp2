import 'package:caltrans/pages/accountPage.dart';
import 'package:caltrans/pages/calculatorPage.dart';
import 'package:caltrans/pages/savedPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  HomePage({Key key}) : super(key: key);
  
  @override 
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  List<Widget> screen = [CalculatorPage(),SavedPage(), AccountPage(),];

  int selectedIndex = 0;
  void onPageChanged(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  void itemTapped(int selectedIndex){
    pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        // accentColor: Colors.teal,
        // primaryTextTheme: Theme.of(context).textTheme.apply(
        //   bodyColor: Colors.white,
        //   displayColor: Colors.deepOrangeAccent,
        // ),
        // brightness: Brightness.dark,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: 
        PageView(
          controller: pageController,
          children: screen,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
          
        bottomNavigationBar: BottomNavigationBar(
          onTap: itemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: selectedIndex == 0 ? Colors.amber[900] : Colors.grey,
              ), 
              // ignore: deprecated_member_use
              title: Text(
                'Home',
                style: TextStyle(
                  color: selectedIndex == 0 ? Colors.amber[900] : Colors.grey,
                ),
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.save,
                  color: selectedIndex == 1 ? Colors.amber[900] : Colors.grey,
                ),
              // ignore: deprecated_member_use
              title: Text(
                'Saved',
                style: TextStyle(
                  color: selectedIndex == 1 ? Colors.amber[900] : Colors.grey,
                ),
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                  color: selectedIndex == 2 ? Colors.amber[900] : Colors.grey,
                ),
              // ignore: deprecated_member_use
              title: Text(
                'Account',
                style: TextStyle(
                  color: selectedIndex == 2 ? Colors.amber[900] : Colors.grey,
                ),  
              ),
            )
          ],

        ),
      ),
    );
  }
}