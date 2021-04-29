part of "../view.dart";

class ExercisesPage extends StatefulWidget {

  final GlobalKey<ScaffoldState> drawerKey;
  ExercisesPage(this.drawerKey);

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {

  bool isMainPage = true;
  String title = "";
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

    return Consumer(
      builder: (context, watch, _){

        final authProvider = watch(authenticationProvider);

        return Scaffold(
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
                            _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                          },
                        ),
                        SizedBox(width: MQuery.width(0.01, context)),
                        IconButton(
                          icon: _stopWatchTimer.isRunning
                            ? Icon(CupertinoIcons.play_fill, color: Colors.white)
                            : Icon(CupertinoIcons.pause_fill, color: Colors.white),
                          onPressed: (){
                            _stopWatchTimer.isRunning
                            ? _stopWatchTimer.onExecute.add(StopWatchExecute.stop)
                            : _stopWatchTimer.onExecute.add(StopWatchExecute.start);
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
                                  "Today's Exercises",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 32,
                                  textAlign: TextAlign.start
                                ),
                                Font.out(
                                  DateFormat("dd MMMM yyyy").format(DateTime.now()),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 20,
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
                      child: Column(
                        children: [
                          SizedBox(height: MQuery.height(0.01, context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Font.out("Exercises", fontWeight: FontWeight.bold, fontSize: 18),     
                              Font.out("0/10", fontWeight: FontWeight.bold, fontSize: 18),
                            ],
                          ),
                          Container(
                            height: MQuery.height(0.425, context),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemExtent: MQuery.height(0.125, context),
                              itemCount: 10, //TBA
                              itemBuilder: (context, index){
                                return Container(
                                  child: ExerciseTile(
                                    callback: (){
                                      setState(() {
                                        isMainPage = !isMainPage;     
                                        title = "Goblet Squat"; //TBA, JADI NANTI INI DIISI OLEH DATANYA VIDEO YANG AKAN DI INJECT
                                        reps = 1;
                                        set = 2;
                                        rest = 3;
                                        comment = "You got this!";
                                        videoURL = "X0qC1k0Zi6k";                                     
                                      });
                                    },
                                    isCompleted: false,
                                    title: "Goblet Squat",
                                    reps: 15,
                                    set: 1,
                                    rest: 60,
                                    imageURL: "imago mundi",
                                  ),
                                );
                              },
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
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 8,
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
                        flex: 13,
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
                                height: MQuery.height(0.09, context),
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
                                        Font.out("sets", fontSize: 16)
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Font.out(reps.toString(), fontSize: 18, color: Palette.primary, fontWeight: FontWeight.bold),
                                        Font.out("reps", fontSize: 16)
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Font.out(rest.toString(), fontSize: 18, color: Palette.primary, fontWeight: FontWeight.bold),
                                        Font.out("rest", fontSize: 16)
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
                              SingleChildScrollView(
                                child: Linkify(
                                  text: comment,
                                  textAlign: TextAlign.start,
                                  style: Font.style(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 0),
                        //   child: StreamBuilder<int>(
                        //     stream: _stopWatchTimer.rawTime,
                        //     initialData: _stopWatchTimer.rawTime.valueWrapper?.value,
                        //     builder: (context, snap) {
                        //       final value = snap.data!;
                        //       final displayTime = StopWatchTimer.getDisplayTime(value,
                        //           hours: false, milliSecond: false);
                        //       return Column(
                        //         children: <Widget>[
                        //           Padding(
                        //             padding: const EdgeInsets.all(8),
                        //             child: Text(
                        //               displayTime,
                        //               style: const TextStyle(
                        //                   fontSize: 40,
                        //                   fontFamily: 'Helvetica',
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ),
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // ),
                      ),
                      /// Button
                      // Padding(
                      //   padding: const EdgeInsets.all(2),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Padding(
                      //         padding: const EdgeInsets.only(bottom: 0),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: <Widget>[
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               // ignore: deprecated_member_use
                      //               child: RaisedButton(
                      //                 padding: const EdgeInsets.all(4),
                      //                 color: Colors.lightBlue,
                      //                 shape: const StadiumBorder(),
                      //                 onPressed: () async {
                      //                   _stopWatchTimer.onExecute
                      //                       .add(StopWatchExecute.start);
                      //                 },
                      //                 child: const Text(
                      //                   'Start',
                      //                   style: TextStyle(color: Colors.white),
                      //                 ),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               // ignore: deprecated_member_use
                      //               child: RaisedButton(
                      //                 padding: const EdgeInsets.all(4),
                      //                 color: Colors.green,
                      //                 shape: const StadiumBorder(),
                      //                 onPressed: () async {
                      //                   _stopWatchTimer.onExecute
                      //                       .add(StopWatchExecute.stop);
                      //                 },
                      //                 child: const Text(
                      //                   'Stop',
                      //                   style: TextStyle(color: Colors.white),
                      //                 ),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               // ignore: deprecated_member_use
                      //               child: RaisedButton(
                      //                 padding: const EdgeInsets.all(4),
                      //                 color: Colors.red,
                      //                 shape: const StadiumBorder(),
                      //                 onPressed: () async {
                      //                   _stopWatchTimer.onExecute
                      //                       .add(StopWatchExecute.reset);
                      //                 },
                      //                 child: const Text(
                      //                   'Reset',
                      //                   style: TextStyle(color: Colors.white),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
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