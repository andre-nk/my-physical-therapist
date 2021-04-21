part of "../view.dart";

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {

      final authProvider = watch(authenticationProvider);

      return SafeArea(
        child: Scaffold(
          body: ElevatedButton(
            onPressed: () async {
              await authProvider.signOutWithEmailAndPassword()
                .whenComplete((){
                  Get.offAndToNamed("/auth");
                });
            },
            child: Text("Log out")),
        ),
      );
    });
  }
}
