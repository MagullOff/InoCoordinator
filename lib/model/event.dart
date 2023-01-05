class Event {
  late final String name;
  late final String id;

  Event({required this.id, required this.name});

  Event.fromJson(Map<String, dynamic> body) {
    name = body['name'];
    id = body['id'];
  }
}
