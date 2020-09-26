import 'package:flutter/material.dart';
import 'package:test_flutter_application/homepage.dart';
import 'package:test_flutter_application/servicepage.dart';
import 'package:test_flutter_application/myinfopage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorDark: Colors.blue,
        accentColor: Colors.blueAccent,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.blue, selectedItemColor: Colors.white),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        primaryColorDark: Colors.blue,
        accentColor: Colors.blueAccent,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.blue, selectedItemColor: Colors.white),
        snackBarTheme: SnackBarThemeData(contentTextStyle: TextStyle(color: Colors.white), backgroundColor: Colors.black12, actionTextColor: Colors.blueAccent),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  var _pages = [ HomePage(), ServicePage(), MyInfoPage() ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo',),
        actions: <Widget>[ IconButton(icon: Icon(Icons.settings,), onPressed: () { print('Menu Pressed'); },), ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Important: Remove any padding from the ListView.
          children: <Widget>[
            DrawerHeader( child: Text('Drawer Header'), decoration: BoxDecoration(color: Colors.blue,),),
            ListTile( title: Text('Item 1'), onTap: () { }, ),
            ListTile( title: Text('Item 2'), onTap: () { }, ),
          ],
        ),
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){ setState(() {_index = index;}); },
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem( title: Text("Home"), icon: Icon(Icons.home), ),
          BottomNavigationBarItem( title: Text("Service"), icon: Icon(Icons.assignment), ),
          BottomNavigationBarItem( title: Text("My Info"), icon: Icon(Icons.account_circle), ),
        ],
      ),
    );
  }
}


