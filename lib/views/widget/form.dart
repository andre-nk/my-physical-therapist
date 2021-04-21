part of "widget.dart";

class LocalForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LocalForm({
    required this.emailController,
    required this.passwordController,
  });

  @override
  _LocalFormState createState() => _LocalFormState();
}

class _LocalFormState extends State<LocalForm> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    double height = MQuery.height(0.0975, context);

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: height,
              child: TextField(
                controller: widget.emailController,
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
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  filled: true,
                  hintStyle: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Palette.primary),
                  hintText: "E-mail",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height - 3.75),
              child: TextFormField(
                controller: widget.passwordController,
                obscureText: isObscured,
                cursorColor: Palette.primary,
                style: Font.style(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Palette.primary),
                decoration: new InputDecoration(
                  suffixIcon: Padding(
                    padding:
                        EdgeInsets.only(right: MQuery.width(0.01, context)),
                    child: IconButton(
                      icon: isObscured == true
                          ? Icon(CupertinoIcons.eye_fill)
                          : Icon(CupertinoIcons.eye_slash_fill),
                      color: Palette.primary,
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MQuery.width(0.03, context),
                    horizontal: MQuery.width(0.03, context),
                  ),
                  fillColor: Palette.formColor.withOpacity(0.3),
                  focusColor: Palette.formColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  enabledBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  filled: true,
                  hintStyle: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Palette.primary),
                  hintText: "Password",
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
