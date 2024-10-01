class Owner {
  String login;
  String avatarUrl;
  Owner({
    required this.login,
    required this.avatarUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    login: json["login"],
    avatarUrl: json["avatar_url"],
  );
  Map<String, dynamic> toJson() => {
    "login": login,
    "avatar_url": avatarUrl,
  };

}