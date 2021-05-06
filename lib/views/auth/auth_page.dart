part of "../view.dart";
class AuthPage extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    
    final authProvider = watch(authenticationProvider);

    final String googleAssetName = 'assets/google.svg';
    final Widget googleSVG = SvgPicture.asset(
      googleAssetName,
      height: MQuery.height(0.05, context),
      semanticsLabel: 'Acme Logo'
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(
          MQuery.height(0.0325, context)
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MQuery.height(0.065, context),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                            right: MQuery.width(0.025, context)
                          ),
                          primary: Palette.secondary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)
                          )
                        ),
                        onPressed: () async {
                          await authProvider.signUpWithGoogle();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            googleSVG,
                            SizedBox(width: MQuery.width(0.03, context),),
                            Font.out(
                              "Google",
                              fontSize: 22, fontWeight: FontWeight.bold
                            )
                          ],
                        ),
                      ),         
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
                    width: MQuery.width(0.465, context),
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
    );
  }
}