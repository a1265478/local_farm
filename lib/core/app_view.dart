import 'package:flutter/material.dart';
import 'package:local_farm/core/firebase_repository.dart';
import '../modules/home/home_page.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
          future: FirebaseRepository().isSyncDataFromFirebase(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 955) {
                    return const HomePage(isDesktop: true);
                  } else {
                    return const HomePage(isDesktop: false);
                  }
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
