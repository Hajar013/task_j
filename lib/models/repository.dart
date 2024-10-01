class RepositoryResponse {
  List<Item> items;

  RepositoryResponse({
    required this.items,
  });

  factory RepositoryResponse.fromJson(Map<String, dynamic> json) =>
      RepositoryResponse(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  String name;

  Owner owner;
  String htmlUrl;
  String? description;

  DateTime createdAt;

  int stargazersCount;
  String? language;
  int forks;

  Item({
    required this.name,
    required this.owner,
    required this.htmlUrl,
    required this.description,
    required this.createdAt,
    required this.stargazersCount,
    required this.language,
    required this.forks,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        owner: Owner.fromJson(json["owner"]),
        htmlUrl: json["html_url"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        stargazersCount: json["stargazers_count"],
        language: json["language"],
        forks: json["forks"],
      );
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
}