part of "../view.dart";

class HomePage extends StatefulWidget {

  final GlobalKey<ScaffoldState> drawerKey;

  HomePage(this.drawerKey);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final authProvider = watch(authenticationProvider);
        String displayName = authProvider.auth.currentUser!.displayName!.split(" ")[0].toString().length > 14 
          ? authProvider.auth.currentUser!.displayName!.split(" ")[0].toString().substring(0, 14) + "!"
          :  authProvider.auth.currentUser!.displayName!.split(" ")[0].toString() + "!";

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MQuery.height(1.3, context),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Header(
                        content: Column(
                          children: [
                            AppBar(
                              leadingWidth: MQuery.width(0.025, context),
                              toolbarHeight: MQuery.height(0.08, context),
                              leading: IconButton(
                                icon : Icon(CupertinoIcons.line_horizontal_3, size: 24),
                                onPressed: (){
                                  widget.drawerKey.currentState!.openDrawer();
                                },
                              ),
                              actions: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 200
                                  ),
                                  child: CircleAvatar(
                                    radius: 22.5,
                                    child: ClipOval(
                                      child: Image.network(authProvider.auth.currentUser!.photoURL ?? "", fit: BoxFit.cover,)
                                    ),
                                    backgroundColor: Palette.secondary,
                                  ),
                                )
                              ],
                              backgroundColor: Colors.transparent,
                              elevation: 0
                            ),
                            Container(
                              height: 130,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Font.out(
                                    "hello,",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 28
                                  ),
                                  Font.out(
                                    displayName,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 36,
                                    textAlign: TextAlign.start
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: MQuery.height(0.035, context),
                          left: MQuery.height(0.04, context)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: MQuery.height(0.035, context)
                              ),
                              child: DefaultTile(
                                callback: (){
                                  Get.to(() => DashboardPage(), transition: Transition.cupertino);
                                },
                                title: "Dashboard",
                                width: double.infinity
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    right: MQuery.height(0.04, context)
                                  ),
                                  child: SubHeadingMore(
                                    title: "Today's exercises",
                                    callback: (){
                                     
                                    },
                                  ),
                                ),
                                Container(
                                  height: MQuery.height(0.2, context),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index){
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: MQuery.width(0.025, context)
                                        ),
                                        child: ExerciseCard(),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    right: MQuery.height(0.04, context)
                                  ),
                                  child: SubHeadingMore(
                                    title: "Today's schedule",
                                    callback: (){
                                      Get.to(() => EventPage(), transition: Transition.cupertino);
                                    },
                                  ),
                                ),
                                Container(
                                  height: MQuery.height(0.4, context),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: 3,
                                    itemBuilder: (context, index){
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: MQuery.width(0.025, context)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MQuery.height(0.025, context)
                                          ),
                                          child: EventTile(
                                            callback: (){
                                              Get.to(() => EventItemPage(
                                                title: "hiyah", 
                                                speaker: "Acme",
                                                platform: "Zoom",
                                                start: DateTime.now(),
                                                end: DateTime.now(),
                                              ));
                                            },
                                            title: "hiyah",
                                            start: DateTime.now(),
                                            end: DateTime.now()
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
        );
      }
    );
  }
}