part of "../../view.dart";

class UserGoalPage extends StatefulWidget {

  final UserModelSimplified userModelSimplified;

  UserGoalPage(this.userModelSimplified);

  @override
  _UserGoalPageState createState() => _UserGoalPageState();
}

class _UserGoalPageState extends State<UserGoalPage> {
  @override
  Widget build(BuildContext context) {
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
                          icon : Icon(CupertinoIcons.chevron_left, size: 24),
                          onPressed: (){
                            Get.back();
                          },
                        ),
                        actions: [
                          Container(
                            height: MQuery.height(0.1, context),
                            margin: EdgeInsets.only(
                              left: 200
                            ),
                            child: CircleAvatar(
                                maxRadius: 25,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image(image: NetworkImage(widget.userModelSimplified.photoURL)),
                                ),
                              )   
                          )
                        ],
                        backgroundColor: Colors.transparent,
                        elevation: 0
                      ),
                      Container(
                        height: MQuery.height(0.15, context),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Font.out(
                              "goal for user:",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 24
                            ),
                            Font.out(
                              widget.userModelSimplified.name,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 28,
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
                  padding: EdgeInsets.all(
                    MQuery.height(0.04, context)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DefaultTile(
                        icons: Icon(MyPhysicalTherapist.barbell_outlined, color: Palette.primary, size: 28),
                        callback: (){
                          Get.to(() => ExercisesGoalPage(
                            uid: widget.userModelSimplified.uid
                          ), transition: Transition.cupertino);
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
                          Get.to(() => PainScalePage(
                            uid: widget.userModelSimplified.uid
                          ), transition: Transition.cupertino);
                        },
                        title: "Pain Scale",
                      ),
                      SizedBox(height: MQuery.height(0.025, context)),
                      DefaultTile(
                        icons: Icon(MyPhysicalTherapist.doc, color: Palette.primary, size: 20),
                        callback: (){
                          Get.to(() => PatientEducationSubPage(widget.userModelSimplified.uid ,"Outcome Measurement"), transition: Transition.cupertino);
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
}