import 'package:closet_control/config/theme.dart';
import 'package:closet_control/features/calendar/calendar_page.dart';
import 'package:closet_control/features/closet/closet_page.dart';
import 'package:closet_control/features/home/home_page.dart';
import 'package:closet_control/features/profile/profile_page.dart';
import 'package:closet_control/providers/clothes_provider.dart';
import 'package:closet_control/providers/outfit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ClosetControl());
}

class ClosetControl extends StatefulWidget {
  const ClosetControl({super.key});

  static const List<Widget> pages = [
    HomePage(),
    ClosetPage(),
    CalendarPage(),
    ProfilePage()
  ];

  @override
  State<ClosetControl> createState() => _ClosetControlState();
}

class _ClosetControlState extends State<ClosetControl> {
  int _currentIndexNavBar = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClothesProvider()),
        ChangeNotifierProvider(create: (context) => OutfitProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  'ClosetControl',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.purple.shade200),
                ),
              ),
              body: Center(
                  child: ClosetControl.pages.elementAt(_currentIndexNavBar)),
              bottomNavigationBar: NavigationBarTheme(
                data: NavigationBarThemeData(
                    indicatorColor: Colors.purple.shade200),
                child: NavigationBar(
                    selectedIndex: _currentIndexNavBar,
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysHide,
                    backgroundColor: Colors.white,
                    onDestinationSelected: (index) =>
                        setState(() => _currentIndexNavBar = index),
                    destinations: const [
                      NavigationDestination(
                          icon: Icon(
                            Icons.home_outlined,
                            size: 32,
                          ),
                          selectedIcon: Icon(Icons.home, size: 32),
                          label: 'Home'),
                      NavigationDestination(
                          icon: Icon(
                            Icons.checkroom_outlined,
                            size: 32,
                          ),
                          selectedIcon: Icon(Icons.checkroom, size: 32),
                          label: 'Closet'),
                      NavigationDestination(
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            size: 32,
                          ),
                          selectedIcon: Icon(Icons.calendar_month, size: 32),
                          label: 'Calendar'),
                      NavigationDestination(
                          icon: Icon(
                            Icons.person_outline,
                            size: 32,
                          ),
                          selectedIcon: Icon(
                            Icons.person,
                            size: 32,
                          ),
                          label: 'Profile')
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
