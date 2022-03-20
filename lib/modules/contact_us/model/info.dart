class Info {
  final String address;
  final String phone;
  final String mobilePhone;
  final String email;
  final String sendEmail;

  const Info({
    this.address = "",
    this.phone = "",
    this.mobilePhone = "",
    this.email = "",
    this.sendEmail = "",
  });
  static const empty = Info();

  Info copyWith({
    String? address,
    String? phone,
    String? mobilePhone,
    String? email,
    String? sendEmail,
  }) {
    return Info(
      address: address ?? this.address,
      phone: phone ?? this.phone,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      email: email ?? this.email,
      sendEmail: sendEmail ?? this.sendEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'phone': phone,
      'mobilePhone': mobilePhone,
      'email': email,
      'sendEmail': sendEmail,
    };
  }

  factory Info.fromJson(Map<String, dynamic> map) {
    return Info(
      address: map['address'] ?? "",
      phone: map['phone'] ?? "",
      mobilePhone: map['mobilePhone'] ?? "",
      email: map['email'] ?? "",
      sendEmail: map['sendEmail'] ?? "",
    );
  }
}
