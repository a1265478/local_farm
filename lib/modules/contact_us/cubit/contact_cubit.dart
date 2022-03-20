import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  //Status
  //0:init
  //1:sending
  //2:success
  //3:failure
  ContactCubit() : super(ContactInitial());
  void changeName(String value) => emit(state.copyWith(name: value));
  void changePhone(String value) => emit(state.copyWith(phone: value));
  void changeEmail(String value) => emit(state.copyWith(email: value));
  void changeMessage(String value) => emit(state.copyWith(message: value));
  void sendMail() async {
    emit(state.copyWith(status: 1));
    try {
      final statuscode =
          await sendEmail(state.name, state.email, state.message);
      if (statuscode != 200) throw Exception();
      emit(state.copyWith(status: 2));
    } catch (ex) {
      emit(state.copyWith(status: 3));
    } finally {
      emit(state.copyWith(status: 0));
    }
  }

  Future sendEmail(String name, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_jyyz4yc';
    const templateId = 'template_chixfkh';
    const userId = 'V-5lKhWrv99UAhXIV';
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message
          }
        }));
    return response.statusCode;
  }
}
