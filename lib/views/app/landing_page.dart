part of '../view.dart';

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {

  PageController _pageController = PageController();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {

      final authProvider = watch(authenticationProvider);
      final firestoreProvider = watch(firebaseFirestoreProvider);
      final userFirestoreProvider = watch(userProvider);

      firestoreProvider
        .collection('admins')
        .doc(authProvider.auth.currentUser?.uid)
        .get().then((value) async {
          if(!(value.exists)){
            await userFirestoreProvider.createUserData(
              name:  authProvider.auth.currentUser?.displayName ?? ""
            );
          }
        }
      );

      return Scaffold(
        key: _drawerKey,
        body: ListTile(
          onTap: () async {
            await authProvider.signOutWithEmailAndPassword().whenComplete((){
              Get.offAndToNamed("/auth");
            });
          },
          enableFeedback: true,
          leading: Icon(Icons.logout, color: Palette.alert),
          title: Font.out(
            "Log out",
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w600,
            fontSize: 18
          )
        )
      );
    });
  }
}
