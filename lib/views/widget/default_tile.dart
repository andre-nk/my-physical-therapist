part of "widget.dart";

class DefaultTile extends StatelessWidget {

  final String title;
  final double? width;
  final double? height;
  final void Function() callback;
  DefaultTile({required this.title, this.width, this.height, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: width ?? MQuery.width(0.825, context),
        height: height ?? MQuery.height(0.085, context),
        padding: EdgeInsets.all(MQuery.height(0.025, context)),
        decoration: BoxDecoration(
          color: Palette.formColor,
          borderRadius: BorderRadius.all(
            Radius.circular(5)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Font.out(
              title,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            Icon(CupertinoIcons.chevron_right)
          ],
        ),
      ),
    );
  }
}