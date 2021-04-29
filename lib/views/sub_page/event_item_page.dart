part of "../view.dart";

class EventItemPage extends ConsumerWidget {

  final String title;
  final DateTime start;
  final DateTime end;
  final String platform;
  final String speaker;

  EventItemPage({required this.title, required this.start, required this.end, required this.platform, required this.speaker});

  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MQuery.height(0.95, context),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Header(
                  content: Column(
                    children: [
                      AppBar(
                        leadingWidth: MQuery.width(0.025, context),
                        toolbarHeight: MQuery.height(0.065, context),
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.chevron_left, size: 24),
                          onPressed: (){
                            Get.back();
                          },
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0
                      ),
                      Container(
                        height: 90,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Font.out(
                              title,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 32,
                              textAlign: TextAlign.start
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MQuery.height(0.03, context),
                    right: MQuery.height(0.03, context),
                    top: MQuery.height(0.03, context),
                    bottom: 0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                          MQuery.height(0.02, context)
                        ),
                        height: MQuery.height(0.15, context),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Palette.formColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5)
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Font.out("speaker", fontSize: 16, color: Palette.minorTextColor),
                                SizedBox(width: MQuery.width(0.015, context)),
                                Font.out(speaker, fontSize: 18, fontWeight: FontWeight.bold, color: Palette.primary)
                              ],
                            ),
                            Row(
                              children: [
                                Font.out("platform", fontSize: 16, color: Palette.minorTextColor),
                                SizedBox(width: MQuery.width(0.015, context)),
                                Font.out(platform, fontSize: 18, fontWeight: FontWeight.bold, color: Palette.primary)
                              ],
                            ),
                            Row(
                              children: [
                                Font.out("showtime", fontSize: 16, color: Palette.minorTextColor),
                                SizedBox(width: MQuery.width(0.015, context)),
                                Font.out(DateFormat("HH:mm").format(start) + " - " + DateFormat("HH:mm").format(end),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.primary
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: MQuery.height(0.03, context)),
                      Linkify(
                        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vel nulla massa. Fusce arcu elit, porta in gravida eu, tincidunt sed est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas sit amet nisl eget arcu lacinia tempor. Sed condimentum lacus vitae odio elementum luctus. Pellentesque mattis pellentesque blandit. Fusce non viverra quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed faucibus felis eget magna mattis bibendum. Morbi aliquet finibus tristique.",
                        textAlign: TextAlign.start,
                        style: Font.style(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}