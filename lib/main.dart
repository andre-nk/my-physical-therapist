import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:my_physical_therapist_admin/providers/provider.dart';
import 'package:my_physical_therapist_admin/views/view.dart';

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

  final Map<int, Color> color =
  {
  50:Color(0xff2B4784),
  100:Color(0xff2B4784),
  200:Color(0xff2B4784),
  300:Color(0xff2B4784),
  400:Color(0xff2B4784),
  500:Color(0xff2B4784),
  600:Color(0xff2B4784),
  700:Color(0xff2B4784),
  800:Color(0xff2B4784),
  900:Color(0xff2B4784),
  };

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Physical Therapist Admin',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff2B4784, color),
        primaryColor: MaterialColor(0xff2B4784, color),
      ),
      home: Authenticator(),
      routes: {
        '/home': (context) => LandingPage(),
        '/auth': (context) => AuthPage(),
      },
    );
  }
}

class Authenticator extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {

    final authStateChanges = watch(authStateChangesProvider);

    return authStateChanges.when(
      data: (user){
        return user != null
          ? LandingPage()
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
