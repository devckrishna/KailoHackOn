class User0 {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;
  String bio;
  int age;
  List posts;

  User0(
      {this.uid,
      this.name,
      this.email,
      this.username,
      this.profilePhoto,
      this.bio,
      this.age,
      this.posts});

  Map toMap(User0 user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data["profile_photo"] = user.profilePhoto;
    data["bio"] = user.bio;
    data["age"] = user.age;
    data["posts"] = [];
    return data;
  }

  // Named constructor
  User0.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.profilePhoto = mapData['profile_photo'];
    this.bio = mapData["bio"];
    this.age = mapData["age"];
    this.posts = mapData["posts"];
  }
}
