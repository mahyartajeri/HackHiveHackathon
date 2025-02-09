class Macros {
  double carbs;
  double protein;
  double fat;
  double fibre;
  double calories;

  Macros({
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.fibre,
    required this.calories,
  });

  toJson() {
    return {
      "Carbs": carbs,
      "Protein": protein,
      "Fats": fat,
      "Fibre": fibre,
      "Calories": calories,
    };
  }
}

// USER_REQUEST = {
//   "Calories": 1000,
//     "Carbs": 50,
//     "Protein": 50,
//     "Fats": 15,
//     "Fibre": 10
// }
