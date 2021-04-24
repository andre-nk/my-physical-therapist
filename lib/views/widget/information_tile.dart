part of "widget.dart";

class InformationTile extends StatelessWidget {

  final String title;
  final String content;

  const InformationTile({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MQuery.height(0.15, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Font.out(
            title,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.formColor,
              borderRadius: BorderRadius.all(
                Radius.circular(5)
              )
            ),
            padding: EdgeInsets.symmetric(
              vertical: MQuery.height(0.025, context),
              horizontal: MQuery.height(0.02, context)
            ),
            child: Font.out(
              content,
              overrideMaxline: true,
              textAlign: TextAlign.start,
              fontSize: 18,
              fontWeight: FontWeight.normal
            ),
          )
        ],
      ),
    );
  }
}