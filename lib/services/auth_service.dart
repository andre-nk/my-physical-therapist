part of "service.dart";

class AuthenticationService with ChangeNotifier {
  AuthenticationService({required this.auth});
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookLogin();
  bool isLoading = false;
  dynamic error;

  //GOOGLE
  Future<void> signUpWithGoogle() async {
    try {
      isLoading = true;
      notifyListeners();
      GoogleSignInAccount googleUser = (await googleSignIn.signIn())!;
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await auth.signInWithCredential(credentials);
      error = null;
      notifyListeners();
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      isLoading = true;
      notifyListeners();
      await googleSignIn.disconnect().whenComplete(() async {
        await auth.signOut();
      });
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  //E-MAIL
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
      .catchError((e){
        print(e);
      });
    error = null;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
      .catchError((e){
        print(e);
      });
    error = null;
    notifyListeners();
  }

  Future<void> signOutWithEmailAndPassword() async {
    try{
      isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance
        .signOut();
      error = null;
      notifyListeners();
    } catch(e) {
      print(e);
    }
  }

  Future<void> sendForgotPasswordHelper(
    String email,
    BuildContext context,
    SnackBar snackbar
  ) async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email)
      .catchError((onError)=>{
        ScaffoldMessenger.of(context).showSnackBar(
          snackbar
        )
      });
  }

  //FACEBOOK
  Future<void> signInWithFacebook() async {
    final result = await facebookSignIn.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (result.status) {
      case FacebookLoginStatus.success:
        await signInWithFacebookHandler(result);
        break;
      case FacebookLoginStatus.cancel:
        Get.snackbar("title", "cancelled");
        break;
      case FacebookLoginStatus.error:
        Get.snackbar("title", "error");
        break;
    }
  }

  Future signInWithFacebookHandler(FacebookLoginResult _result) async {
    isLoading = true;
    notifyListeners();
      FacebookAccessToken? _accessToken = _result.accessToken;
      AuthCredential _credential = FacebookAuthProvider.credential(_accessToken?.token ?? "");
      await FirebaseAuth.instance.signInWithCredential(_credential);
    isLoading = false;
    notifyListeners();
  }
}
