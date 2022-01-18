import 'package:binance_mobile/views/account_view.dart';
import 'package:binance_mobile/views/coins_view.dart';
import 'package:binance_mobile/views/home_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _views = [HomeView(), CoinsView(), AccountView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Koin Listesi"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Hesabım"),
        ],
        currentIndex: _selectedIndex,
        onTap: (e) => setState(() {
          _selectedIndex = e;
        }),
      ),
    );
  }
}
