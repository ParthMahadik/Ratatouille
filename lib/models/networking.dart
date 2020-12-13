import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({this.url});

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future postData(List<String> ingredients) async {
    http.Response response =
        await http.post(url, body: jsonEncode({'ingredients': ingredients}));
    if (response.statusCode == 200) {
      print('List posted successfully');
    } else {
      print('List post failed');
    }
  }
}
