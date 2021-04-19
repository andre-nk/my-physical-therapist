part of "configs.dart";

class MQuery{
  static double height(double multiplier, BuildContext context){
    return MediaQuery.of(context).size.height * multiplier;
  }

  static double width(double multiplier, BuildContext context){
    return MediaQuery.of(context).size.height * multiplier;
  }
}