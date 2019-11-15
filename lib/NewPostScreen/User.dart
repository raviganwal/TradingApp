class User {
  int userId;
  String firstName;
  String lastName;

  User({this.userId, this.firstName, this.lastName});

  static List<User> getUsers() {
    return <User>[
      User(userId: 1, firstName: "Aaron", lastName: "Jackson"),
      User(userId: 2, firstName: "Ben", lastName: "John"),
      User(userId: 3, firstName: "Carrie", lastName: "Brown"),
      User(userId: 4, firstName: "Deep", lastName: "Sen"),
      User(userId: 5, firstName: "Emily", lastName: "Jane"),
    ];
  }
}