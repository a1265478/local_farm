part of 'contact_cubit.dart';

class ContactState extends Equatable {
  const ContactState({
    this.name = "",
    this.phone = "",
    this.email = "",
    this.message = "",
    this.status = 0,
  });
  final String name;
  final String phone;
  final String email;
  final String message;
  final int status;

  ContactState copyWith({
    String? name,
    String? phone,
    String? email,
    String? message,
    int? status,
  }) {
    return ContactState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, phone, email, message, status];
}

class ContactInitial extends ContactState {}
