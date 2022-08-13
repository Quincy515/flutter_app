class VideoModel {
  String? title;
  String? path;
  String? url;
  String? type;
  String? category;
  String? describe;
  String? tag;
  String? author;
  String? hash;
  int? id;
  int? duration;

  VideoModel(
      {this.title,
      this.path,
      this.url,
      this.type,
      this.category,
      this.describe,
      this.tag,
      this.author,
      this.hash,
      this.id,
      this.duration});

  VideoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    path = json['path'];
    url = json['url'];
    type = json['type'];
    category = json['category'];
    describe = json['describe'];
    tag = json['tag'];
    author = json['author'];
    hash = json['hash'];
    id = json['id'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['path'] = path;
    data['url'] = url;
    data['type'] = type;
    data['category'] = category;
    data['describe'] = describe;
    data['tag'] = tag;
    data['author'] = author;
    data['hash'] = hash;
    data['id'] = id;
    data['duration'] = duration;
    return data;
  }
}
