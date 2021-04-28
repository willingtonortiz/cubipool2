bool isUsernameValid(String username) {
  final regex = RegExp(r"^(u|U)\w{9}$");
  return regex.hasMatch(username);
}
