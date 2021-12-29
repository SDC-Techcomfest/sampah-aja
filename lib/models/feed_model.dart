class FeedModel {
  FeedModel({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.source,
    this.url,
  });

  String? id;
  String? title;
  String? description;
  String? imageUrl;
  String? source;
  String? url;

  factory FeedModel.fromJson(Map<String, dynamic> json, String id) => FeedModel(
    id: id,
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    source: json["source"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "imageUrl": imageUrl,
    "source": source,
    "url": url,
  };
}
