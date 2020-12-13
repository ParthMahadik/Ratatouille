import 'package:ratatouille/models/networking.dart';

class DishData {
  Future<dynamic> getDishData(String url) async {
    NetworkHelper networkHelper = NetworkHelper(url: url);

    var dishData = await networkHelper.getData();
    return dishData;
  }
}
