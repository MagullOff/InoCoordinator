class Player {
  late final String name;
  late final String code;
  late final String id;

  Player(this.name, this.code, this.id);

  Player.fromJson(Map<String, dynamic> body) {
    name = body['name'];
    code = body['code'];
    id = body['id'];
  }
}
