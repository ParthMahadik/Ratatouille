import 'package:ratatouille/models/networking.dart';

class IngredientData {
  Future<dynamic> postIngredientData(String url, List<String> ingredients) async {
    NetworkHelper networkHelper = NetworkHelper(url: url);
    await networkHelper.postData(ingredients);
  }
}
