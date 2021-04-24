part of "widget.dart";

class ExerciseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MQuery.height(0.3, context),
      width: MQuery.width(0.3, context),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(5)
        )
      ),
    );
  }
}