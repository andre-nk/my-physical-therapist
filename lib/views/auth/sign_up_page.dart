part of "../view.dart";

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Consumer(
      builder: (context, watch, _){
        
        final authProvider = watch(authenticationProvider);
        final userFirestoreProvider = watch(userProvider);
        
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(MQuery.height(0.02, context)),
              height: MQuery.height(1, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 2),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: MQuery.height(0.06, context)
                      ),
                      width: double.infinity,
                      child: Font.out("Sign up",
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Palette.primary,
                          textAlign: TextAlign.center),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: LocalForm(
                      emailController: emailController,
                      passwordController: passwordController,
                    ) 
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Button(
                          title: "Sign up",
                          color: Palette.primary,
                          width: MQuery.width(0.475, context),
                          method: (){
                            if(emailController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Palette.secondary,
                                  content: Font.out(
                                    "Please fill out the e-mail form firstly",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              );
                            } else if (passwordController.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Palette.secondary,
                                  content: Font.out(
                                    "Please fill out the password form",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              );
                            } else {
                              authProvider.signUpWithEmailAndPassword(
                                emailController.text, 
                                passwordController.text,
                                context,
                                SnackBar(
                                  backgroundColor: Palette.secondary,
                                  content: Font.out(
                                    "Something wrong is happened, please retry.",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ).whenComplete(() async {
                                if(authProvider.auth.currentUser?.uid != null){
                                   await userFirestoreProvider.createUserData(
                                    authProvider.auth.currentUser?.uid ?? "",
                                    name:  authProvider.auth.currentUser?.displayName ?? ""
                                  );
                                }
                                Get.offAndToNamed("/home");     
                              });
                            }
                          }                   
                        ),
                        SizedBox(height: MQuery.height(0.03, context)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Font.out(
                              "Have an account?",
                              fontSize: 18,
                            ),
                            InkWell(
                              child: Font.out(
                                  " Login!",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              onTap: (){
                                Get.to(() => SignInPage(), transition: Transition.cupertino);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 8,
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
