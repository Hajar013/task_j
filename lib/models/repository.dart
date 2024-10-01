class RepositoryResponse {
  List<Item> items;

  RepositoryResponse({
    required this.items,
  });

  factory RepositoryResponse.fromJson(Map<String, dynamic> json) =>
      RepositoryResponse(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String name;
  int id ;
  Owner owner;
  String htmlUrl;
  String? description;

  DateTime createdAt;

  int stargazersCount;
  String? language;
  int forks;

  bool isFavorite;


  Item({
    required this.id,
    required this.name,
    required this.owner,
    required this.htmlUrl,
    required this.description,
    required this.createdAt,
    required this.stargazersCount,
    required this.language,
    required this.forks,
    this.isFavorite = false,

  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        owner: Owner.fromJson(json["owner"]),
        htmlUrl: json["html_url"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        stargazersCount: json["stargazers_count"],
        language: json["language"],
        forks: json["forks"],
        isFavorite: false,
      );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "owner": owner.toJson(),
    "html_url": htmlUrl,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "stargazers_count": stargazersCount,
    "language": language,
    "forks": forks,
    "isFavorite": isFavorite, // Add this to JSON output
  };
}

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