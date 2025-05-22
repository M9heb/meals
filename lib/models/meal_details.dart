import 'package:flutter/material.dart';
import 'package:test_app/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                onToggleFavorite(meal);
              },
              icon: Icon(Icons.star))
        ],
      ),
      body: ListView(
        children: [
          Hero(
            tag: meal.imageUrl,
            child: Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 320,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text(
                  "Ingredients",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                for (final ingredient in meal.ingredients)
                  Text(
                    ingredient,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Steps",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                for (final steps in meal.steps)
                  Text(
                    steps,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
