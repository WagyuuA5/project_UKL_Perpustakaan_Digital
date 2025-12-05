class AuthController {
  static final List<Map<String, String>> _users = [
    {'email': 'whyuravi.2008@gmail.com', 'password': '123456', 'name': 'Wahyu ravi'},
    {'email': 'Siswa@Id.com', 'password': '123456', 'name': 'Zdne'},
  ];

  static Map<String, String>? authenticate(String email, String password) {
    for (var user in _users) {
      if (user['email'] == email && user['password'] == password) {
        return user;
      }
    }
    return null;
  }

  static bool register(String email, String password, String name) {
    final exist = _users.any((u) => u['email'] == email);
    if (exist) return false;

    _users.add({
      'email': email,
      'password': password,
      'name': name,
    });

    return true;
  }
}
