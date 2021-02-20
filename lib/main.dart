import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_flutter_application/homepage.dart';
import 'package:test_flutter_application/bodyfatpage.dart';
import 'package:test_flutter_application/stopwatchpage.dart';
import 'package:test_flutter_application/todopage.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.blue,),);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _focusNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){_focusNode.unfocus();},
      child: FocusScope(
        node: _focusNode,
        child: MaterialApp(
          title: 'Flutter Demo Application',
          theme: ThemeData(
            primaryColor: Colors.blue,
            primaryColorDark: Colors.blue,
            accentColor: Colors.blueAccent,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.blue, selectedItemColor: Colors.white, type: BottomNavigationBarType.fixed, ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.blue,
            primaryColorDark: Colors.blue,
            accentColor: Colors.blueAccent,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.blue, selectedItemColor: Colors.white, type: BottomNavigationBarType.fixed, ),
            snackBarTheme: SnackBarThemeData(contentTextStyle: TextStyle(color: Colors.white), backgroundColor: Colors.black26, actionTextColor: Colors.blueAccent),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainPage(),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  final List<Text> _title = [Text('Home Page'),Text('Body Fat Page'),Text('StopWatch Page'),Text('To Do Page'),];
  final List<Widget> _pages = <Widget>[HomePage(), BodyFatPage(), StopWatchPage(), ToDoPage(), ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title[_index],
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
      body: IndexedStack(index: _index, children: _pages,),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (_index){ setState(() {this._index = _index;}); FocusScope.of(context).unfocus(); }, //{pageController.jumpToPage(_index);},
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem( title: Text("Home"), icon: Icon(Icons.home), ),
          BottomNavigationBarItem( title: Text("Body Fat"), icon: Icon(Icons.accessibility), ),
          BottomNavigationBarItem( title: Text("StopWatch"), icon: Icon(Icons.timer), ),
          BottomNavigationBarItem( title: Text("To Do"), icon: Icon(Icons.assignment), ),
        ],
      ),
    );
  }
}


