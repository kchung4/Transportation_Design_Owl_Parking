import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/lots_list_screen.dart';

void main() {
  runApp(const ParkingApp());
}

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Owl Parking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFFF00),
          onPrimary: Colors.black,
          secondary: Color(0xFFFFFF00),
          onSecondary: Colors.black,
          surface: Color(0xFF1A1A1A),
          onSurface: Colors.white,
          surfaceContainerHighest: Color(0xFF2C2C2C),
          outline: Color(0xFF555555),
        ),
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFFFFF00),
          scrolledUnderElevation: 1,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFFF00),
          ),
          iconTheme: IconThemeData(color: Color(0xFFFFFF00)),
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: Color(0xFFFFFF00),
          unselectedLabelColor: Colors.white54,
          indicatorColor: Color(0xFFFFFF00),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  late final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: [
          HomeScreen(onNavigateToParking: () => _onTabTapped(1)),
          const LotsListScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFFFFF00),
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_parking_rounded),
            label: 'Parking',
          ),
        ],
      ),
    );
  }
}
