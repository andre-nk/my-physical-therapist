part of "widget.dart";

class BubbleMessage extends ConsumerWidget {
  final String uid;
  final String message;
  final String dateTime;
  final bool byUser; //SAMPLE

  BubbleMessage(
      {required this.uid,
      required this.message,
      required this.dateTime,
      required this.byUser});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final authModel = watch(authModelProvider);
    // final dbModel = watch(databaseProvider);
    // 
    DateFormat format = new DateFormat("dd MMMM yyyy");
    DateFormat format2 = new DateFormat("yMd");
    var formattedDate = format.parse(dateTime);

    DateTime globalScheduleToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    String messageTimeDisplayer() {
      return formattedDate.isAtSameMomentAs(globalScheduleToday)
          ? dateTime.substring(dateTime.length - 5, dateTime.length)
          : format2.format(formattedDate) +
              ", " +
              dateTime.substring(dateTime.length - 5, dateTime.length);
    }


    return byUser
        ? Padding(
            padding:
                EdgeInsets.symmetric(vertical: MQuery.height(0.02, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MQuery.height(0.09, context),
                    minWidth: MQuery.width(0.2, context),
                    maxWidth: MQuery.width(0.35, context),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MQuery.height(0.02, context),
                        vertical: MQuery.height(0.015, context)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Palette.tertiary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Linkify(
                          text: message,
                          textAlign: TextAlign.end,
                          style: Font.style(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: MQuery.height(0.01, context)),
                        Font.out(messageTimeDisplayer(),
                            color: Colors.black.withOpacity(0.5), fontSize: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : /*StreamBuilder<OtherUser>(
          stream: dbModel.otherUserProfile(uid),
          builder: (context, snapshot) {
            OtherUser? otherUser = snapshot.data;
            return*/
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: MQuery.height(0.02, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MQuery.height(0.09, context),
                    minWidth: MQuery.width(0.2, context),
                    maxWidth: MQuery.width(0.35, context),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MQuery.height(0.02, context),
                        vertical: MQuery.height(0.015, context)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Palette.formColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Linkify(
                          text: message,
                          textAlign: TextAlign.start,
                          style: Font.style(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: MQuery.height(0.0025, context)),
                        Font.out(messageTimeDisplayer(),
                            color: Colors.black.withOpacity(0.5), fontSize: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
