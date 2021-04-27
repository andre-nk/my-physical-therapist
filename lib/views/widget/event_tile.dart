part of "widget.dart";

class EventTile extends StatelessWidget {

  final String title;
  final DateTime start;
  final DateTime end;
  final void Function()? callback;

  EventTile({required this.title, required this.start, required this.end, this.callback});

  @override
  Widget build(BuildContext context) {

    String title2 = title.length > 24
      ? title.substring(0, 20) + "..."
      : title;

    final DateFormat formatter = DateFormat.Hm();

    return InkWell(
      onTap: callback ?? (){},
      child: Container(
        width: MQuery.width(1, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Font.out(
                formatter.format(start),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Palette.primary
              ),
            ),
            Spacer(),
            Expanded(
              flex: 10,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MQuery.height(0.015, context),
                  horizontal: MQuery.height(0.02, context)
                ),
                height: MQuery.height(0.1, context),
                decoration: BoxDecoration(
                  color: Palette.formColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5)
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Font.out(
                      title2,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                    Font.out(
                      formatter.format(start) + " - " + formatter.format(end),
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

