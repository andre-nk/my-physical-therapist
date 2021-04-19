part of "../view.dart";

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
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
                            onTap: () {},
                            child:Image.asset("assets/facebook.png")
                          ),
                          InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {},
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
                              "atau",
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
                        print("a");
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
                            // Get.to(() => SignInPage(viewModel: authModel), transition: Transition.cupertino);
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