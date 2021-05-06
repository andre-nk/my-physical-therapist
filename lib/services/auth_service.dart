part of "service.dart";

class AuthenticationService with ChangeNotifier {
  AuthenticationService({required this.auth});
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoading = false;
  dynamic error;

  //GOOGLE
  Future<void> signUpWithGoogle() async {

      isLoading = true;
      notifyListeners();
      GoogleSignInAccount googleUser = (await googleSignIn.signIn())!;
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await auth.signInWithCredential(credentials);
      error = null;
      notifyListeners();
    
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
  Future<void> signUpWithEmailAndPassword(String email, String password, BuildContext context, SnackBar snackbar) async {
    isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
      .catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(
          snackbar
        );
      });
    error = null;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context, SnackBar snackbar) async {
    isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
      .catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(
          snackbar
        );
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
}
