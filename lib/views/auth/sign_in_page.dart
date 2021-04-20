part of "../view.dart";

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
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
                Spacer(flex: 1),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: MQuery.height(0.06, context)
                    ),
                    width: double.infinity,
                    child: Font.out("Sign in",
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
                  flex: 5,
                  child: Column(
                    children: [
                      Button(
                        title: "Sign in",
                        color: Palette.primary,
                        width: MQuery.width(0.475, context),
                        method: (){
                          print("a");
                        },
                      ),
                      SizedBox(height: MQuery.height(0.03, context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Font.out(
                            "Forgot password?",
                            fontSize: 18,
                          ),
                          InkWell(
                            child: Font.out(
                                " Let us help!",
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
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MQuery.width(0.2, context),
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
                        width: MQuery.width(0.2, context),
                        height: 1,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
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
                Spacer(
                  flex: 6,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
