part of "../view.dart";
class AuthPage extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    
    final authProvider = watch(authenticationProvider);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(
            MQuery.height(0.02, context)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 14,
                child: Container(
                  width: MQuery.width(0.45, context),
                  child: Image(
                    image: AssetImage("assets/logo.png"),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            customBorder: CircleBorder(),
                            onTap: () async {
                              await authProvider.signInWithFacebook(
                                context,
                                  SnackBar(
                                    backgroundColor: Palette.secondary,
                                    content: Font.out(
                                      "You've cancel the Facebook sign-in",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                              );
                            },
                            child:Image.asset("assets/facebook.png")
                          ),
                          InkWell(
                            customBorder: CircleBorder(),
                            onTap: () async {
                              await authProvider.signUpWithGoogle().whenComplete(() async {
                                Get.offAndToNamed("/home");     
                              });
                            },
                            child:Image.asset("assets/google.png")
                          ),
                          InkWell(
                            splashColor: Colors.red,
                            customBorder: CircleBorder(),
                            onTap: () {
                              print("a");
                            },
                            child:Image.asset("assets/apple.png")
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MQuery.width(0.19, context),
                            height: 1,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: MQuery.width(0.02, context)),
                            child: Font.out(
                              "or",
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Container(
                            width: MQuery.width(0.19, context),
                            height: 1,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    Button(
                      title: "Sign Up with E-mail",
                      color: Palette.primary,
                      method: (){
                        Get.to(() => SignUpPage(), transition: Transition.cupertino);
                      },
                    ),
                    SizedBox(height: MQuery.height(0.04, context)),
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
                    )
                  ],
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}