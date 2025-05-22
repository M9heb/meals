import 'package:flutter/material.dart';
import 'package:test_app/models/meal.dart';
import 'package:test_app/screens/categories.dart';
import 'package:test_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message, Meal) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _toggleFavoriteMeals(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
        _showInfoMessage("Deleted from favorites list.");
        _favoriteMeals.remove(meal);
      } else {
        _showInfoMessage("Successfully added to favorites list.");
        _favoriteMeals.add(meal);
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteMeals,
    );
    String activeScreenTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
          meals: _favoriteMeals, onToggleFavorite: _toggleFavoriteMeals);
      String activeScreenTitle = "Favorite meals";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          ]),
    );
  }
}
