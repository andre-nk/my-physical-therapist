part of "../view.dart";

class HomePage extends StatefulWidget {

  final GlobalKey<ScaffoldState> drawerKey;
  final void Function() callback;

  HomePage(this.drawerKey, this.callback);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File? _image;
  String? _profilePictureURL;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Palette.secondary,
            content: Font.out(
              "No image selected",
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          )
        );
      }
    });
  }

  void _pickedImage() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          height: MQuery.height(0.3, context),
          width: MQuery.width(0.9, context),
          padding: EdgeInsets.all(MQuery.height(0.04, context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Font.out(
                "Choose profile picture via:",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Palette.primary
              ),
              SizedBox(height: MQuery.height(0.05, context)),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Button(
                      height: MQuery.height(0.015, context),
                      title: "Camera",
                      color: Palette.primary,
                      method: (){
                        getImage(ImageSource.camera);
                      },
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 6,
                    child: Button(
                      height: MQuery.height(0.015, context),
                      title: "Gallery",
                      color: Palette.primary,
                      method: (){
                        getImage(ImageSource.gallery);
                      },
                    ),
                  ),
                ],
              )
            ] 
          ),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final authProvider = watch(authenticationProvider);
        String displayName = authProvider.auth.currentUser!.displayName!.split(" ")[0].toString().length > 14 
          ? authProvider.auth.currentUser!.displayName!.split(" ")[0].toString().substring(0, 14) + "!"
          :  authProvider.auth.currentUser!.displayName!.split(" ")[0].toString() + "!";

        final exerciseListProvider = watch(exercisesProvider);
        final eventProvider = watch(eventListProvider);
        final userInstanceProvider = watch(userProvider);

        if(_image != null){
          watch(uploadUserPhoto(_image ?? File(""))).whenData((value){
            setState(() {
              _profilePictureURL = value;            
            });
          });

          userInstanceProvider.updateProfilePicture(
            authProvider.auth.currentUser!,
            _profilePictureURL ?? ""
          );     
        }

        print(authProvider.auth.currentUser!.photoURL);

        return Scaffold(
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
                                  child: GestureDetector(
                                    onTap: _pickedImage,
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
                                    "hello,",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 24
                                  ),
                                  Font.out(
                                    displayName,
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
                                      widget.callback();
                                    },
                                  ),
                                ),
                                exerciseListProvider.when(
                                  data: (value){
                                    return Container(
                                      height: MQuery.height(0.2, context),
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: value.length,
                                        itemBuilder: (context, index){
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              right: MQuery.width(0.025, context)
                                            ),
                                            child: ExerciseCard(
                                              imageURL: 'https://img.youtube.com/vi/${value[index].videoURL}/0.jpg',
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                                  error: (_,__) => SizedBox(),
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
                                eventProvider.when(
                                  data: (value){

                                    List<EventModel> filteredValue = [];

                                    value.forEach((element) {
                                      if(element.start.toString().substring(0, 10) == DateTime.now().toString().substring(0,10)){
                                        filteredValue.add(element);
                                      }
                                    });

                                    return filteredValue.length == 0
                                    ? Center(
                                      child: Font.out(
                                          "There are no events today",
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Palette.primary))
                                    : Container(
                                      height: MQuery.height(0.4, context),
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: filteredValue.length,
                                        itemBuilder: (context, index){
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              right: MQuery.width(0.025, context),
                                              bottom: MQuery.height(0.025, context)
                                            ),
                                            child: EventTile(
                                              callback: (){
                                                Get.to(() => EventItemPage(
                                                  title: filteredValue[index].title, 
                                                  speaker: filteredValue[index].speaker,
                                                  platform: filteredValue[index].media,
                                                  start: filteredValue[index].start,
                                                  end: filteredValue[index].end,
                                                  description: filteredValue[index].description,
                                                ));
                                              },
                                              title:  filteredValue[index].title,
                                              start: filteredValue[index].start,
                                              end: filteredValue[index].end,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                                  error: (_,__) => SizedBox(),
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
          
        );
      }
    );
  }
}