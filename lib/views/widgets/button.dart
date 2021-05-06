part of "widget.dart";

class Button extends StatelessWidget {
  final dynamic method;
  final String? title;
  final Color? color;
  final double? height;
  final double? width;

  const Button({this.method, this.title, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MQuery.height(0.08, context),
      width: width ?? MQuery.width(0.45, context),
      child: ElevatedButton(
        onPressed: this.method,
        child: Font.out(
          title,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
          )
        )
      ),
    );
  }
}