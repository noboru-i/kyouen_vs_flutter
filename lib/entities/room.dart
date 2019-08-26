class Room {
  final DateTime createdAt;
  final int numberOfPlayer;

  Room({this.createdAt, this.numberOfPlayer});

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'numberOfPlayer': numberOfPlayer,
    };
  }
}
