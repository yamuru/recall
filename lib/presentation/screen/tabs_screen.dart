import 'package:flutter/material.dart';
import 'package:recallapp/presentation/screen/home_screen.dart';
import 'package:recallapp/presentation/screen/my_vocabulary_screen.dart';
import 'package:recallapp/presentation/screen/recall_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTabIndex = 0;

  void changeTab(index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedTabIndex,
          children: const [
            HomeScreen(),
            RecallScreen(),
            MyVocabularyScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => changeTab(index),
        currentIndex: _selectedTabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology_alt),
            label: 'Recall',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: 'Словарь',
          ),
        ],
      ),
    );
  }
}
