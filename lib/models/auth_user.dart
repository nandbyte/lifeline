class AppUser {
  final String uid;
  AppUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String suger;
  final String coffeeMate;
  final int strength;

  UserData({
    this.uid,
    this.name,
    this.suger,
    this.coffeeMate,
    this.strength,
  });
}
