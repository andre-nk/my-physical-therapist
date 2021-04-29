part of "../view.dart";

class GoalPage extends StatefulWidget {

  final GlobalKey<ScaffoldState> drawerKey;

  GoalPage(this.drawerKey);

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final authProvider = watch(authenticationProvider);

        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MQuery.height(0.9, context),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
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
                                height: MQuery.height(0.1, context),
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
                            height: 110,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Font.out(
                                  "Progress and Goal",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 32,
                                  textAlign: TextAlign.start
                                ),
                                Font.out(
                                  "track progress, goal and result",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 20,
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
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.all(
                        MQuery.height(0.04, context)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DefaultTile(
                            icons: Icon(MyPhysicalTherapist.barbell_outlined, color: Palette.primary, size: 28),
                            callback: (){
                              Get.to(() => ExercisesGoalPage(), transition: Transition.cupertino);
                            },
                            title: "Exercise Goal",
                          ),
                          SizedBox(height: MQuery.height(0.025, context)),
                          DefaultTile(
                            icons: Icon(MyPhysicalTherapist.vector, color: Palette.primary, size: 20),
                            callback: (){
                              Get.to(() => WeightTrackerPage(), transition: Transition.cupertino);
                            },
                            title: "Weight Tracker",
                          ),
                          SizedBox(height: MQuery.height(0.025, context)),
                          DefaultTile(
                            icons: Icon(CupertinoIcons.smiley, color: Palette.primary, size: 26),
                            callback: (){
                              Get.to(() => PainScalePage(), transition: Transition.cupertino);
                            },
                            title: "Pain Scale",
                          ),
                          SizedBox(height: MQuery.height(0.025, context)),
                          DefaultTile(
                            icons: Icon(MyPhysicalTherapist.doc, color: Palette.primary, size: 20),
                            callback: (){
                              Get.to(() => PatientEducationSubPage("Outcome Measurement"), transition: Transition.cupertino);
                            },
                            title: "Outcome Measurement",
                          ),
                          SizedBox(height: MQuery.height(0.025, context)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        );
      }
    );
  }
}