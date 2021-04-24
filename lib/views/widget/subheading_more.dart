part of 'widget.dart';

class SubHeadingMore extends StatelessWidget {

  final String title;
  final void Function() callback;

  SubHeadingMore({required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: MQuery.height(0.1, context),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Font.out(
              title,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MQuery.width(0.05, context)
              ),
              child: Icon(CupertinoIcons.chevron_right),
            )
          ],
        ),
      ),
    );
  }
}