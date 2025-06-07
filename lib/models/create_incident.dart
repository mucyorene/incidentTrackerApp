class CreateIncident {
  String title;
  String description;
  String category;
  String location;
  String dateTime;
  String status;
  String? photo;

  CreateIncident({
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.dateTime,
    required this.status,
    this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "category": category,
      "location": location,
      "dateTime": dateTime,
      "status": status,
      "photo": photo,
    };
  }
}
