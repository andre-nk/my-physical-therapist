part of "widget.dart";

class ExerciseTile extends StatelessWidget {
  final bool isCompleted;
  final String title;
  final String imageURL;
  final int set;
  final int reps;
  final int rest;
  final void Function() callback;

  const ExerciseTile({
    required this.isCompleted,
    required this.title,
    required this.imageURL,
    required this.set,
    required this.reps,
    required this.rest,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MQuery.height(0.01, context)
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: isCompleted
                  ? Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      color: Palette.safe,
                    )
                  : Icon(
                      CupertinoIcons.check_mark_circled,
                      color: Colors.grey,
                    )),
          Spacer(),
          Expanded(
            flex: 20,
            child: InkWell(
              onTap: callback,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MQuery.height(0.005, context),
                  horizontal: MQuery.width(0.015, context)
                ),
                decoration: BoxDecoration(
                    color: Palette.formColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          height: double.infinity,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.red,
                          ),
                          child: Image(
                            errorBuilder: (context, _, __) {
                              return Container(color: Palette.primary);
                            },
                            image: NetworkImage(imageURL),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Font.out(title,
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              SizedBox(height: 2.5),
                              Container(
                                width: MQuery.width(0.225, context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Font.out("sets: $set",
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    Font.out("reps: $reps",
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    Font.out("rest: $rest",
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Icon(CupertinoIcons.chevron_right),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
