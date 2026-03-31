class User {
  final int? id;
  final String username;
  final String password;
  final String rol;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.rol,
  });
}