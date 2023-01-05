class Point {
  late final String name;
  late final String code;
  late final String id;

  Point(this.code, this.id, this.name);

  Point.fromJson(Map<String, dynamic> body) {
    name = body['name'];
    code = body['code'];
    id = body['id'];
  }
}
