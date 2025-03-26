import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:michicolle/service/model/http/route.dart';
import 'package:http/http.dart' as http;

class HttpStore {
  static Future<List<Route>> getRouteList() async {
    final url = Uri.parse('${dotenv.get('API_SERVER')}/routes');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        print(body['routes']);
        return List<Route>.from(
            body['routes'].map((routeJson) => Route.fromJson(routeJson))
        );
      } else {
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      rethrow;
    }
  }
}