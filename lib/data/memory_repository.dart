import 'dart:core';
import 'package:flutter/foundation.dart';

import 'repository.dart';
import 'models/models.dart';

class MemoryRepository extends Repository with ChangeNotifier {
  final List<Recipe> _currentRecipes = <Recipe>[];
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  @override
  List<Recipe> findAllRecipes() {
    return _currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    return _currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    final recipe =
        _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return recipeIngredients;
  }

    @override
  int insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    notifyListeners();
    return 0;
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);
      notifyListeners();
    }
    return <int>[];
  }

  @override
  Future init() => Future.value(null);

  @override
  void close() {}
}
