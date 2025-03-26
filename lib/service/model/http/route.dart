import 'dart:convert';

class Route {
  final int id;
  final String name;

  Route({
    required this.id, 
    required this.name
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

Route routeModelFromJson(String str) => Route.fromJson(json.decode(str));

String routeModelToJson(Route route) => json.encode(route.toJson());

