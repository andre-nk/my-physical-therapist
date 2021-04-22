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
      final firestoreProvider = watch(firebaseFirestoreProvider);
      final userFirestoreProvider = watch(userProvider);

      firestoreProvider
        .collection('users')
        .doc(authProvider.auth.currentUser?.uid)
        .get().then((value) async {
          if(!(value.exists)){
            await userFirestoreProvider.createUserData(
              authProvider.auth.currentUser?.uid ?? "",
              name:  authProvider.auth.currentUser?.displayName ?? ""
            );
          } else {
            print(value.data()?.entries);
          }
        });

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
