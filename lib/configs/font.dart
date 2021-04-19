part of "configs.dart";

class Font{
  static Text out(title, {int fontSize = 16, fontWeight, color, textAlign, family, bool overrideMaxline = false}){
    return Text(
      title ?? "",
      overflow: TextOverflow.visible,
      textAlign: textAlign ?? TextAlign.center,
      style: GoogleFonts.nunito(
        color: color,
        fontSize: fontSize.toDouble(),
        fontWeight: fontWeight ?? FontWeight.normal,
      )
    );
  }

  static TextStyle style({int fontSize = 16, Color? color, String? family, FontWeight? fontWeight}){
    return GoogleFonts.nunito(
      color: color,
      fontSize: fontSize.toDouble(),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}