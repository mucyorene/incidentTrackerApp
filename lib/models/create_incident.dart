import 'package:hive/hive.dart';

part 'create_incident.g.dart';

@HiveType(typeId: 0)
class CreateIncident extends HiveObject {
  @HiveField(0)
  int? id; // Auto-incrementing ID

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String category;

  @HiveField(4)
  String location;

  @HiveField(5)
  String dateTime;

  @HiveField(6)
  String status;

  @HiveField(7)
  String? photo;

  CreateIncident({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.dateTime,
    required this.status,
    this.photo,
  });

  factory CreateIncident.fromJson(Map<String, dynamic> json) => CreateIncident(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    category: json["category"],
    location: json["location"],
    dateTime: json["dateTime"],
    status: json["status"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": category,
    "location": location,
    "dateTime": dateTime,
    "status": status,
    "photo": photo,
  };
}
