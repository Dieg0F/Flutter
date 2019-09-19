class User {
  String uId;
  String name;
  String phoneNumber;
  String email;
  String photoUrl;
  String userFrom;

  User(
      {this.uId,
      this.name,
      this.phoneNumber,
      this.email,
      this.photoUrl,
      this.userFrom});

  factory User.fromFacebook(Map<String, dynamic> facebookUser) => User(
      uId: facebookUser['id'],
      name: facebookUser['name'],
      phoneNumber: "",
      email: facebookUser['email'],
      photoUrl: facebookUser['picture']['data']['url'],
      userFrom: "Facebook");
}
