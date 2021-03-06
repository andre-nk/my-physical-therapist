part of "../view.dart";

class ExercisesPage extends StatefulWidget {

  final GlobalKey<ScaffoldState> drawerKey;
  final void Function() callback;
  
  ExercisesPage(this.drawerKey, this.callback);

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {

  bool isMainPage = true;
  bool isPlaying = false;
  String title = "";
  String id = "";
  int reps = 0;
  int set = 0;
  int rest = 0;
  String comment = "";
  String videoURL = "";

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

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

        final authProvider = watch(authenticationProvider);
        final exerciseListProvider = watch(exercisesProvider);

        return Scaffold(
          floatingActionButton: isPlaying == true && isMainPage == false
          ? Padding(
              padding: EdgeInsets.only(bottom: MQuery.height(0.09, context)),
              child: FloatingActionButton(
                backgroundColor: Palette.primary,
                child: Icon(CupertinoIcons.checkmark_alt, color: Colors.white),
                onPressed: (){
                  if(id != ""){
                    watch(setExerciseCompleteProvider(id));
                    setState(() {
                      isMainPage = !isMainPage;                      
                    });
                  }
                },
              ),
            )
          : SizedBox(),
          bottomSheet: BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.fromLTRB(
                  MQuery.width(0.04, context),
                  MQuery.width(0.0125, context),
                  MQuery.width(0.03, context),
                  MQuery.width(0.01, context)
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Palette.secondary,
                ),
                height: MQuery.height(0.09, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.valueWrapper?.value,
                      builder: (context, snap) {
                        final value = snap.data!;
                        final displayTime = StopWatchTimer.getDisplayTime(value, hours: false, milliSecond: false);
                        return Font.out(
                          displayTime,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        );
                      }
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(CupertinoIcons.stop_fill, color: Colors.white),
                          onPressed: (){
                            if(isPlaying){
                              _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                              setState(() {
                                isPlaying = false;                                
                              });
                              widget.callback();
                            }
                          },
                        ),
                        SizedBox(width: MQuery.width(0.01, context)),
                        IconButton(
                          icon: isPlaying
                            ? Icon(CupertinoIcons.pause_fill, color: Colors.white)
                            : Icon(CupertinoIcons.play_fill, color: Colors.white),
                          onPressed: (){
                            if(isPlaying){
                              setState(() {
                                isPlaying = !isPlaying;                                
                              });
                              _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                              widget.callback();
                            } else {
                              setState(() {
                                isPlaying = !isPlaying;                                
                              });
                              _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                              widget.callback();
                            }       
                          }
                        )
                      ],
                    )
                  ],
                ),
              );
            },
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
                                  maxRadius: 25,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image(image: NetworkImage(authProvider.auth.currentUser!.photoURL ?? "")),
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
                                  "Today's Exercises",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 28,
                                  textAlign: TextAlign.start
                                ),
                                Font.out(
                                  DateFormat("dd MMMM yyyy").format(DateTime.now()),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 18,
                                  textAlign: TextAlign.left
                                ),
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
                                            set = value[index].sets;
                                            rest = value[index].rest;
                                            comment = value[index].comment;
                                            videoURL = value[index].videoURL;
                                            id = value[index].id;                                   
                                          });
                                        },
                                        isCompleted: value[index].isCompleted,
                                        title:  value[index].title,
                                        reps: value[index].reps,
                                        set: value[index].sets,
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
                                          Font.out(set.toString(), fontSize: 18, color: Palette.primary, fontWeight: FontWeight.bold),
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