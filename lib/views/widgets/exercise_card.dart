part of "widget.dart";

class ExerciseCard extends StatelessWidget {

  final String imageURL;

  const ExerciseCard({Key? key, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16/9,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: MQuery.height(0.3, context),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(10)
          )
        ),
        child: Image.network(imageURL, fit: BoxFit.fill,),
      ),
    );
  }
}