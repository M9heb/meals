import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/providers/favorites_provider.dart';
// import 'package:test_app/data/dummy_data.dart';
// import 'package:test_app/models/meal.dart';
// import 'package:test_app/providers/meals_provider.dart';
import 'package:test_app/screens/categories.dart';
import 'package:test_app/screens/filters.dart';
import 'package:test_app/screens/meals.dart';
import 'package:test_app/widgets/main_drawer.dart';
import 'package:test_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];

  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void _toggleFavoriteMeals(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);
  //   setState(() {
  //     if (isExisting) {
  //       _showInfoMessage("Deleted from favorites list.");
  //       _favoriteMeals.remove(meal);
  //     } else {
  //       _showInfoMessage("Successfully added to favorites list.");
  //       _favoriteMeals.add(meal);
  //     }
  //   });
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context)
          .push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) {
        return const FiltersScreen(
            // currentFilters: _selectedFilters,
            );
      }));
      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(
      // onToggleFavorite: _toggleFavoriteMeals,
      availableMeals: availableMeals,
    );
    String activeScreenTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleFavoriteMeals,
      );
      activeScreenTitle = "Favorite meals";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
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
