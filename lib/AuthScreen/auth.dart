class LoggedUser {
  final int id;
  final String username;
  final String token;

  LoggedUser(this.id, this.username, this.token);

  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    // TODO: use json['error']
    if (json['username'] == null) {
      return null;
    }
    return LoggedUser(
      json['id'],
      json['username'],
      json['token'],
    );
  }
}
