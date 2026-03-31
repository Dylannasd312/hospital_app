import '../../../core/database/database_helper.dart';

class AuthService {

  Future<bool> login(String username, String password) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      'usuarios',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }
}