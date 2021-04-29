part of "../view.dart";

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();

    return Consumer(
      builder: (context, watch, _){
        
        final authProvider = watch(authenticationProvider);
        
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
                      child: Font.out("Forgot password?",
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Palette.primary,
                          textAlign: TextAlign.center),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: Palette.primary,
                      style: Font.style(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Palette.primary),
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MQuery.width(0.03, context),
                          horizontal: MQuery.width(0.03, context),
                        ),
                        fillColor: Palette.formColor.withOpacity(0.3),
                        focusColor: Palette.formColor,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Palette.secondaryBorder, width: 1.25),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        enabledBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Palette.secondaryBorder, width: 1.25),
                            borderRadius:BorderRadius.all(Radius.circular(10))),
                        filled: true,
                        hintStyle: Font.style(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Palette.primary),
                        hintText: "Fill your e-mail address",
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Button(
                          title: "Send reset password link",
                          color: Palette.primary,
                          width: MQuery.width(0.475, context),
                          method: (){
                            if(emailController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Palette.secondary,
                                  content: Font.out(
                                    "Please fill out the e-mail to find your account",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              );
                            } else {
                              authProvider.sendForgotPasswordHelper(
                                emailController.text, context,
                                SnackBar(
                                  backgroundColor: Palette.secondary,
                                  content: Font.out(
                                      "We're sorry, something wrong is happened",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                )
                                .whenComplete((){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Palette.secondary,
                                      content: Font.out(
                                        "The password reset e-mail has been sent to your account",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  );
                                  Get.back();
                                });
                            }
                          }                   
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
