part of "../view.dart";

class ChatPage extends StatefulWidget {

  final GlobalKey<ScaffoldState> drawerKey;
  ChatPage(this.drawerKey);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final authProvider = watch(authenticationProvider);

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
                              height: 90,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Font.out(
                                    "Chats",
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
                        padding: EdgeInsets.fromLTRB(
                          MQuery.height(0.02, context),
                          MQuery.height(0.02, context),
                          MQuery.height(0.02, context),
                          MQuery.height(0.02, context)
                        ),
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: 20,
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemBuilder: (context, index){
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: MQuery.height(0.0025, context),
                                horizontal: MQuery.height(0.0175, context),
                              ),
                              child: ChatTile(
                                callback: (){
                                  Get.to(() => ChatContactPage(
                                    name: "Hanindya Hayunggi",
                                    avatar: NetworkImage("a"),
                                  ), transition: Transition.cupertino);
                                },
                                name: "Hanindya Hayunggi",
                                avatar: NetworkImage("a"),
                                message: "I’ve updated your contraindiaaaaaa",
                                dateTime: DateTime.now()
                              ),
                            );
                          },
                        )
                      )
                    )
                  ]
                )
              )
            )
          
        );
      }
    );
  }
}