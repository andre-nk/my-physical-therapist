import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:my_physical_therapist/providers/provider.dart';
import 'package:my_physical_therapist/views/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Physical Therapist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Authenticator(),
    );
  }
}

class Authenticator extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {

    final authStateChanges = watch(authStateChangesProvider);

    return authStateChanges.when(
      data: (user){
        return user != null
          ? Text("signed")
          : AuthPage();
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: Text("error")
      ),
    );
  }

}
