import 'package:flutter/material.dart';
import 'package:t2p/main.dart';
import 'package:t2p/screen/homepage.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> buildTabBar = <Widget>[
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 48,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/logo.png', scale: 15),
            SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tastes2Plate",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 3),
                Text(
                  "Intercity Food Delivery",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.account_balance_wallet)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
        ],
      ),
      drawer: Drawer(
        child: ListView(),
      ),
      body: buildTabBar.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/menu1-s.png')),
              label: "Deals",
              tooltip: 'Deals'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/menu2-s.png')),
              label: "City",
              tooltip: 'City'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/menu3-s.png')),
              label: "Brands",
              tooltip: 'Brands'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/menu5-s.png')),
              label: "Category",
              tooltip: 'Category'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/cuisine_30x30_ios.png')),
              label: "Cuisine",
              tooltip: 'Cuisine'),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(
          size: 16,
          color: reddish
        ),
        unselectedIconTheme: IconThemeData(
            size: 16,
            color: reddish
        ),
        selectedItemColor: reddish,
        unselectedItemColor: reddish,
      ),
    );
  }
}
