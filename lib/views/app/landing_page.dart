part of '../view.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  PageController _pageController = PageController();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {

      final authProvider = watch(authenticationProvider);
      final firestoreProvider = watch(firebaseFirestoreProvider);
      final adminDataProvider = watch(adminDataCreatorProvider);
      final eventProvider = watch(eventListProvider);
      final userModelListProvider = watch(userListProvider);

      final String uid = authProvider.auth.currentUser!.uid;

      firestoreProvider
        .collection('admins')
        .doc(uid)
        .get().then((value) async {
          if(!(value.exists)){
            await adminDataProvider.createAdminData(
              name: authProvider.auth.currentUser?.displayName ?? authProvider.auth.currentUser?.email ?? ""
            );
          }
        }
      );

      if(_image != null){
        watch(uploadAdminPhoto(_image ?? File(""))).whenData((value){
          setState(() {
            _profilePictureURL = value;            
          });
        });

      authProvider.updateProfilePicture(
          authProvider.auth.currentUser!,
          _profilePictureURL ?? ""
        );      
      }

      return uid == "HKXJ5P3m9qUFCiPZSN96TyMLGoy1"
        ? Scaffold(
            key: _drawerKey,
            drawer: Drawer(
              child: Container(
                height: MQuery.height(1, context),
                width: MQuery.width(0.4, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MQuery.height(0.3, context),
                      child: Image.asset("assets/logo.png", fit: BoxFit.contain,)
                    ),
                    ListTile(
                      onTap: () async {
                        await authProvider.signOutWithEmailAndPassword().whenComplete((){
                          Get.offAndToNamed("/auth");
                        });
                      },
                      enableFeedback: true,
                      leading: Icon(Icons.logout, color: Palette.alert),
                      title: Font.out(
                        "Log out",
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      )
                    )
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: MQuery.height(0.95, context),
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Header(
                        content: Column(
                          children: [
                            AppBar(
                              leadingWidth: MQuery.width(0.025, context),
                              toolbarHeight: MQuery.height(0.08, context),
                              leading: IconButton(
                                icon : Icon(CupertinoIcons.line_horizontal_3, size: 24),
                                onPressed: (){
                                  _drawerKey.currentState!.openDrawer();
                                },
                              ),
                              actions: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 200
                                  ),
                                  child: CircleAvatar(
                                    radius: 22.5,
                                    backgroundImage: NetworkImage(authProvider.auth.currentUser!.photoURL ?? ""),
                                    backgroundColor: Palette.secondary,
                                  ),
                                )
                              ],
                              backgroundColor: Colors.transparent,
                              elevation: 0
                            ),
                            Container(
                              height: MQuery.height(0.13, context),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Font.out(
                                    "welcome to the admin panel,",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 18
                                  ),
                                  Font.out(
                                    authProvider.auth.currentUser!.displayName ?? authProvider.auth.currentUser?.email ?? "",
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
                                  Get.to(() => UserAdminList(), transition: Transition.cupertino);
                                },
                                title: "User and Admin List",
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
                                    title: "Today's event",
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
                                                  uid: filteredValue[index].uid,
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
                      )
                    )
                  ],
                ),
              ),
            )
          )
        : Scaffold(
            key: _drawerKey,
            drawer: Drawer(
              child: Container(
                height: MQuery.height(1, context),
                width: MQuery.width(0.4, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MQuery.height(0.3, context),
                      child: Image.asset("assets/logo.png", fit: BoxFit.contain,)
                    ),
                    ListTile(
                      onTap: () async {
                        await authProvider.signOutWithEmailAndPassword().whenComplete((){
                          Get.offAndToNamed("/auth");
                        });
                      },
                      enableFeedback: true,
                      leading: Icon(Icons.logout, color: Palette.alert),
                      title: Font.out(
                        "Log out",
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      )
                    )
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: MQuery.height(0.95, context),
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Header(
                        content: Column(
                          children: [
                            AppBar(
                              leadingWidth: MQuery.width(0.025, context),
                              toolbarHeight: MQuery.height(0.08, context),
                              leading: IconButton(
                                icon : Icon(CupertinoIcons.line_horizontal_3, size: 24),
                                onPressed: (){
                                  _drawerKey.currentState!.openDrawer();
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
                                      radius: 22.5,
                                      backgroundImage: NetworkImage(authProvider.auth.currentUser!.photoURL ?? ""),
                                      backgroundColor: Palette.secondary,
                                    ),
                                  ),
                                )
                              ],
                              backgroundColor: Colors.transparent,
                              elevation: 0
                            ),
                            Container(
                              height: MQuery.height(0.13, context),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Font.out(
                                    "welcome to your panel,",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 18
                                  ),
                                  Font.out(
                                    authProvider.auth.currentUser!.displayName,
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
                        width: double.infinity,
                        height: MQuery.height(1, context),
                        padding: EdgeInsets.only(
                          top: MQuery.height(0.035, context),
                          left: MQuery.height(0.035, context),
                          right: MQuery.height(0.035, context)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userModelListProvider.when(
                              data: (value){

                                List<UserModelSimplified> userList = value.where((element) =>
                                  element.adminHandler == uid
                                ).toList();

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Font.out(
                                      "Users handled: (${userList.length} users)",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    Container(
                                      height: userList.length == 0 ? MQuery.height(0.075, context) : MQuery.height(0.275, context),
                                      child: userList.length == 0
                                      ? Center(
                                          child: Font.out(
                                            "No user handled",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Palette.minorTextColor
                                          ),
                                        )
                                      : ListView.separated(
                                        itemBuilder: (context, index){
                                          return ListTile(
                                            onTap: (){    
                                              
                                            },
                                            contentPadding: EdgeInsets.symmetric(
                                              vertical: MQuery.height(0.01, context)
                                            ),
                                            leading: Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: CircleAvatar(
                                                backgroundColor: Palette.primary,
                                                backgroundImage: NetworkImage(userList[index].photoURL),
                                              ),
                                            ),
                                            title: Font.out(
                                              userList[index].name.length >= 34
                                                ? userList[index].name.substring(0, 31) + "..."
                                                : userList[index].name,
                                              fontSize: 18, fontWeight: FontWeight.w600, textAlign: TextAlign.left
                                            ),
                                            trailing: Icon(CupertinoIcons.chevron_right)
                                          );
                                        },
                                        physics: BouncingScrollPhysics(),
                                        itemCount: userList.length,
                                        separatorBuilder: (context, index) {
                                          return Divider();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                              error: (_,__) => SizedBox(),
                            ),
                            SizedBox(height: MQuery.height(0.03, context)),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    right: MQuery.height(0.04, context)
                                  ),
                                  child: SubHeadingMore(
                                    title: "Today's event",
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
                                          color: Palette.minorTextColor))
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
                                                  uid: filteredValue[index].uid,
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
                        )
                      ),
                    ),
                ]
              )
            )
          )
        );
      }
    );
  }
}
