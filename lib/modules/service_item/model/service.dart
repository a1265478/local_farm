class Service {
  final String id;
  final String content;
  final String title;
  final String type;
  final int price;

  const Service({
    this.id = "",
    this.content = "",
    this.title = "",
    this.type = "",
    this.price = 0,
  });

  static const empty = Service();

  Service copyWith({
    String? id,
    String? content,
    String? title,
    String? type,
    int? price,
  }) {
    return Service(
      id: id ?? this.id,
      content: content ?? this.content,
      title: title ?? this.title,
      type: type ?? this.type,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'title': title,
      'type': type,
      'price': price,
    };
  }

  factory Service.fromJson(Map<String, dynamic> map) {
    return Service(
      id: map['id'] ?? "",
      content: map['content'] ?? "",
      title: map['title'] ?? "",
      type: map['type'] ?? "",
      price: map['price'] ?? 0,
    );
  }
}
