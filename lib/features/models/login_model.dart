//Login için kullanılacak model
class LoginModel {
  final String userName;
  final String password;

  LoginModel(this.userName, this.password);

  //Proje test olduğu için mock user datası eklendi.
  static LoginModel get mockUser {
    return LoginModel("demo", "12345");
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginModel && other.userName == userName && other.password == password;
  }

  @override
  int get hashCode => userName.hashCode ^ password.hashCode;
}
