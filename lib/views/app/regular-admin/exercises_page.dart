part of "../../view.dart";

class ExercisesPage extends StatefulWidget {

  final UserModelSimplified userModelSimplified;
  
  ExercisesPage(this.userModelSimplified);

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {

  bool isMainPage = true;
  bool isPlaying = false;
  String title = "";
  String id = "";
  int reps = 0;
  int sets = 0;
  int rest = 0;
  String comment = "";
  String videoURL = "";


  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoURL,
      params: YoutubePlayerParams( // Defining custom playlist
          showControls: true,
          showFullscreenButton: true,
          desktopMode: Platform.isWindows || Platform.isMacOS ? true : false
      ),
    );

    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };

    _controller.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        _controller.play();
      });
      Future.delayed(const Duration(seconds: 5), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
    };

    _controller.setLoop(true);

    return Consumer(
      builder: (context, watch, _){

        final exerciseListProvider = watch(exercisesProvider(widget.userModelSimplified.uid));

        return Scaffold(
          floatingActionButton: isMainPage
          ? FloatingActionButton(
              onPressed: (){
                Get.to(() => ExerciseEditor(
                  widget.userModelSimplified.uid
                ), transition: Transition.cupertino);
              },
              child: const Icon(CupertinoIcons.add),
            )
          : ExpandableFab(
              distance: MQuery.height(0.1, context),
              children: [
                ActionButton(
                  onPressed: (){
                    Get.dialog(
                      Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Container(
                          height: MQuery.height(0.25, context),
                          width: MQuery.width(0.9, context),
                          padding: EdgeInsets.all(MQuery.height(0.04, context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Font.out(
                                "Delete this exercise?",
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Palette.primary
                              ),
                              SizedBox(height: MQuery.height(0.025, context)),
                              Button(
                                height: MQuery.height(0.015, context),
                                title: "Confirm",
                                color: Palette.primary,
                                method: (){
                                  watch(exercisesServiceProvider).deleteExercise(
                                    uid: widget.userModelSimplified.uid,
                                    id: id
                                  );
                                  Get.back();
                                  setState(() {
                                    isMainPage = !isMainPage;                                   
                                  });
                                },
                              )
                            ] 
                          ),
                        )
                      )
                    );
                  },
                  icon: const Icon(CupertinoIcons.trash, size: 20),
                ),
                ActionButton(
                  onPressed: (){
                    Get.to(() => ExerciseEditor(
                      widget.userModelSimplified.uid,
                      title: title,
                      uid: id,
                      video: videoURL,
                      comment: comment,
                      rest: rest,
                      reps: reps,
                      sets: sets
                    ), transition: Transition.cupertino);
                  },
                  icon: const Icon(CupertinoIcons.pencil),
                ),
              ],
            ),
          body: isMainPage
          ? SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: MQuery.height(0.95, context),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Header(
                      content: Column(
                        children: [
                          AppBar(
                            leadingWidth: MQuery.width(0.025, context),
                            toolbarHeight: MQuery.height(0.08, context),
                            leading: IconButton(
                              icon : Icon(CupertinoIcons.chevron_back, size: 24),
                              onPressed: (){
                                Get.back();
                              },
                            ),
                            actions: [
                              Container(
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
                                  backgroundColor: Palette.primary,
                                ),
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
                                  "today's exercises for user:",
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
                    flex: 11,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        MQuery.height(0.025, context),
                        MQuery.height(0.02, context),
                        MQuery.height(0.025, context),
                        MQuery.height(0.04, context),
                      ),
                      child: exerciseListProvider.when(
                        data: (value){

                          int isCompletedCount = 0;
                          value.forEach((element) {
                            if(element.isCompleted){
                              isCompletedCount++;
                            }
                          });

                          return Column(
                            children: [
                              SizedBox(height: MQuery.height(0.01, context)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Font.out("Exercises", fontWeight: FontWeight.bold, fontSize: 18),     
                                  Font.out("$isCompletedCount / ${value.length}", fontWeight: FontWeight.bold, fontSize: 18),
                                ],
                              ),
                              Container(
                                height: MQuery.height(0.5, context),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemExtent: MQuery.height(0.125, context),
                                  itemCount: value.length, //TBA
                                  itemBuilder: (context, index){
                                    return Container(
                                      child: ExerciseTile(
                                        callback: (){
                                          setState(() {
                                            isMainPage = !isMainPage;     
                                            title = value[index].title;
                                            reps = value[index].reps;
                                            sets = value[index].sets;
                                            rest = value[index].rest;
                                            comment = value[index].comment;
                                            videoURL = value[index].videoURL;
                                            id = value[index].id;                                   
                                          });
                                        },
                                        isCompleted: value[index].isCompleted,
                                        title:  value[index].title,
                                        reps: value[index].reps,
                                        sets: value[index].sets,
                                        rest: value[index].rest,
                                        imageURL: 'https://img.youtube.com/vi/${value[index].videoURL}/0.jpg',
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                        error: (_,__) => SizedBox(),
                      )
                    )
                  )
                ]
              )
            )
          )
          : Consumer(
            builder: (context, watch, _) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(icon: Icon(CupertinoIcons.chevron_left), onPressed: (){
                    setState(() {
                      isMainPage = !isMainPage;                      
                    });
                  }),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    height: MQuery.height(0.95, context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Container(
                            width: double.infinity,
                            child: YoutubePlayerControllerProvider( // Provides controller to all the widget below it.
                              controller: _controller,
                              child: YoutubePlayerIFrame(
                                aspectRatio: 16 / 9,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(MQuery.height(0.03, context)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Font.out(
                                  title,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: MQuery.height(0.02, context)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MQuery.height(0.05, context),
                                    vertical: MQuery.height(0.01, context)
                                  ),
                                  height: MQuery.height(0.1, context),
                                  decoration: BoxDecoration(
                                    color: Palette.formColor,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Font.out(sets.toString(), fontSize: 18, color: Palette.primary, fontWeight: FontWeight.bold),
                                          Font.out("sets", fontSize: 14)
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Font.out(reps.toString(), fontSize: 18, color: Palette.primary, fontWeight: FontWeight.bold),
                                          Font.out("reps", fontSize: 14)
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Font.out(rest.toString(), fontSize: 18, color: Palette.primary, fontWeight: FontWeight.bold),
                                          Font.out("rest", fontSize: 14)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: MQuery.height(0.04, context)),
                                Font.out(
                                  "Comment",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: MQuery.height(0.01, context)),
                                Container(
                                  height: MQuery.height(0.275, context),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Linkify(
                                      text: comment,
                                      textAlign: TextAlign.start,
                                      style: Font.style(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          )
        );
      } 
    );
  }
}