import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm/const/const.dart';
import 'package:local_farm/core/firebase_repository.dart';

import 'cubit/contact_cubit.dart';

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final info = FirebaseRepository().info;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final ContactCubit cubit = ContactCubit();
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<ContactCubit, ContactState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == 3) {
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                content: Text("失敗"),
              ),
            );
          } else if (state.status == 2) {
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                content: Text("成功"),
              ),
            );
          }
        },
        child: Container(
          color: kPrimaryColor.withOpacity(0.1),
          padding:
              const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 100),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "聯絡我們",
                style: kTitle,
              ),
              const Divider(color: Colors.black, thickness: 3),
              const SizedBox(height: 10),
              const Text(
                "聯絡資訊",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              GridView.count(
                mainAxisSpacing: 10,
                shrinkWrap: true,
                crossAxisCount: _rwdCount(MediaQuery.of(context).size.width),
                childAspectRatio: 10,
                children: [
                  _infoListTile(Icons.phone, info.phone),
                  _infoListTile(Icons.phone_iphone, info.mobilePhone),
                  _infoListTile(Icons.mail, info.email),
                  _infoListTile(Icons.location_on_rounded, info.address),
                ],
              ),
              const Divider(color: Colors.black, thickness: 3),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: kDarkGreenColor, width: 3),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      color: kDarkGreenColor,
                      child: const Text(
                        "留言給我們",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "姓名",
                                  style: _labelTextStyle(),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: _decoration(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "請留下您的姓名";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => cubit.changeName(value),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "電話",
                                  style: _labelTextStyle(),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: _decoration(),
                                  onChanged: (value) =>
                                      cubit.changePhone(value),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Email",
                                  style: _labelTextStyle(),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: _decoration(),
                                  onChanged: (value) =>
                                      cubit.changeEmail(value),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "請留下您的Email";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "訊息",
                                  style: _labelTextStyle(),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  maxLines: 10,
                                  decoration: _decoration(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "請留下您想說的話";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) =>
                                      cubit.changeMessage(value),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: InkWell(
                        onTap: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          cubit.sendMail();
                        },
                        child: Container(
                          color: kDarkGreenColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 80),
                          child: const Text(
                            "送出",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _labelTextStyle() => const TextStyle(fontSize: 16);

  InputDecoration _decoration() => const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kDarkGreenColor, width: 2.0),
        ),
        border: OutlineInputBorder(),
      );

  int _rwdCount(double sizeWidth) {
    if (sizeWidth <= 800) return 1;
    if (sizeWidth <= 1355) return 2;
    return 4;
  }

  Widget _infoListTile(IconData icon, String info) => Builder(
        builder: (context) {
          return SizedBox(
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(
                  info,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      );
}
