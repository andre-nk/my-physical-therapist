part of '../view.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  PageController _pageController = PageController();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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

      final String uid = authProvider.auth.currentUser!.uid;

      firestoreProvider
        .collection('admins')
        .doc(uid)
        .get().then((value) async {
          if(!(value.exists)){
            await adminDataProvider.createAdminData(
              name:  authProvider.auth.currentUser?.displayName ?? ""
            );
          }
        }
      );

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
        : Text("Not admin");
    });
  }
}
