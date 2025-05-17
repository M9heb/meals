import 'package:flutter/material.dart';
import 'package:test_app/data/dummy_data.dart';
import 'package:test_app/widgets/category_grid_item.dart';
import 'package:test_app/screens/meals.dart';
import 'package:test_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final filteredCategory = dummyMeals
        .where((item) => item.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredCategory,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick your category"),
      ),
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: (ctx) {
                _selectCategory(context, category);
              },
            )
        ],
      ),
    );
  }
}
