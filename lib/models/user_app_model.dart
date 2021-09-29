class UserApp {
  final String? id;
  final String? lastname;
  final String? firstname;
  final String? username;
  final String? email;
  final String? roles;
  final String? accessToken;

  UserApp({
    this.id,
    this.lastname,
    this.firstname,
    this.username,
    this.email,
    this.roles,
    this.accessToken,
  });

  factory UserApp.fromJson(Map<String, dynamic> json) {
    return UserApp(
      id: json['id'].toString(),
      email: json['email'].toString(),
      firstname: json['firstname'].toString(),
      lastname: json['lastname'].toString(),
      username: json['username'].toString(),
      accessToken: json['accessToken'].toString(),
      roles: json['roles'][0].toString(),
    );
  }

  @override
  String toString() {
    return '{ ${this.email},${this.lastname},${this.username}, ${this.roles}}';
  }
}
