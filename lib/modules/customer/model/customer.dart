class Customer {
  final String id;
  final String name;
  final String webUrl;
  final String brandIntroduction;
  final String designIntroduction;

  const Customer({
    this.id = "",
    this.name = "",
    this.webUrl = "",
    this.brandIntroduction = "",
    this.designIntroduction = "",
  });

  static const empty = Customer();
  Customer copyWith({
    String? id,
    String? name,
    String? webUrl,
    String? brandIntroduction,
    String? designIntroduction,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      webUrl: webUrl ?? this.webUrl,
      brandIntroduction: brandIntroduction ?? this.brandIntroduction,
      designIntroduction: designIntroduction ?? this.designIntroduction,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'webUrl': webUrl,
      'brandIntroduction': brandIntroduction,
      'designIntroduction': designIntroduction,
    };
  }

  factory Customer.fromJson(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as String,
      name: map['name'] as String,
      webUrl: map['webUrl'] as String,
      brandIntroduction: map['brandIntroduction'] as String,
      designIntroduction: map['designIntroduction'] as String,
    );
  }
}
