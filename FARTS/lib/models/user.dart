class User {

  final String uid;

  User({ this.uid });

}

class UserData {

  final String uid;
  final List characters;
  final String email;
  final dynamic gmCampaigns;
  final String username;

  UserData({
    this.uid,
    this.characters,
    this.email,
    this.gmCampaigns,
    this.username
  });

}