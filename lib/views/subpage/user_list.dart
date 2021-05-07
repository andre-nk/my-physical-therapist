part of "../view.dart";

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final userModelListProvider = watch(userListProvider);
        final adminModelListProvider = watch(adminListProvider); 

        return Scaffold(
          body: SingleChildScrollView(
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
                            toolbarHeight: MQuery.height(0.065, context),
                            leading: IconButton(
                              icon: Icon(CupertinoIcons.chevron_left, size: 24),
                              onPressed: (){
                                Get.back();
                              },
                            ),
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
                                  "Users List",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 28,
                                  textAlign: TextAlign.start
                                ),
                                Font.out(
                                  "assign a user to their admin handler",
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
                    child: Padding(
                      padding: EdgeInsets.all(
                        MQuery.height(0.025, context)
                      ),
                      child: userModelListProvider.when(
                        data: (value){
                          return ListView.separated(
                            itemBuilder: (context, index){
                              return ListTile(
                                onTap: (){    
                                  String selectedUserUID = value[index].uid;
                                  watch(adminProvider(value[index].adminHandler)).whenData((adminData){
                                    Get.bottomSheet(
                                      BottomSheet(
                                        onClosing: (){},
                                        builder: (context){
                                          return Container(
                                            height: MQuery.height(0.9, context),
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MQuery.height(0.025, context),
                                              vertical: MQuery.height(0.03, context)
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Palette.primary,
                                                      backgroundImage: NetworkImage(value[index].photoURL),
                                                    ),
                                                    SizedBox(width: MQuery.width(0.025, context)),
                                                    Font.out(
                                                      value[index].name,
                                                      fontSize: 20, fontWeight: FontWeight.bold, textAlign: TextAlign.left
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: MQuery.height(0.03, context)),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Font.out(
                                                      "Current admin handler:",
                                                      fontSize: 16, fontWeight: FontWeight.normal, textAlign: TextAlign.left
                                                    ),
                                                    SizedBox(height: MQuery.height(0.015, context)),
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor: Palette.primary,
                                                          backgroundImage: NetworkImage(adminData.photoURL),
                                                        ),
                                                        SizedBox(width: MQuery.width(0.025, context)),
                                                        Font.out(
                                                          adminData.name,
                                                          fontSize: 20, fontWeight: FontWeight.bold, textAlign: TextAlign.left
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: MQuery.height(0.03, context)),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Font.out(
                                                      "Change admin handler:",
                                                      fontSize: 16, fontWeight: FontWeight.normal, textAlign: TextAlign.left
                                                    ),
                                                    SizedBox(height: MQuery.height(0.015, context)),
                                                    adminModelListProvider.when(
                                                      data: (adminValue){

                                                        adminValue.removeWhere((element) => element.uid == "HKXJ5P3m9qUFCiPZSN96TyMLGoy1");

                                                        return Container(
                                                          height: MQuery.height(0.25, context),
                                                          child: ListView.separated(
                                                            physics: BouncingScrollPhysics(),
                                                            itemCount: adminValue.length,
                                                            separatorBuilder: (context, index){
                                                              return Divider();
                                                            },
                                                            itemBuilder: (context, index){
                                                              return ListTile(
                                                                onTap: (){
                                                                  Get.dialog(
                                                                    Dialog(
                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                      child: Container(
                                                                        height: MQuery.height(0.35, context),
                                                                        width: MQuery.width(0.9, context),
                                                                        padding: EdgeInsets.all(MQuery.height(0.04, context)),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children:[
                                                                            Font.out(
                                                                              "Change admin handler for ${value[index].name} to ${adminValue[index].name}?",
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Palette.primary
                                                                            ),
                                                                            SizedBox(height: MQuery.height(0.05, context)),
                                                                            Button(
                                                                              height: MQuery.height(0.015, context),
                                                                              title: "Confirm",
                                                                              color: Palette.primary,
                                                                              method: (){

                                                                                print(selectedUserUID);

                                                                                watch(userProvider).updateUserAdminHandler(
                                                                                  selectedUserUID,
                                                                                  adminValue[index].uid
                                                                                );
                                                                                Get.back();
                                                                              },
                                                                            )
                                                                          ] 
                                                                        ),
                                                                      )
                                                                    )
                                                                  );
                                                                },
                                                                contentPadding: EdgeInsets.symmetric(
                                                                  vertical: MQuery.height(0.01, context)
                                                                ),
                                                                leading: Padding(
                                                                  padding: const EdgeInsets.only(right: 8.0),
                                                                  child: CircleAvatar(
                                                                    backgroundColor: Palette.primary,
                                                                    backgroundImage: NetworkImage(adminValue[index].photoURL),
                                                                  ),
                                                                ),
                                                                title: Font.out(
                                                                  value[index].name.length >= 34
                                                                    ? adminValue[index].name.substring(0, 31) + "..."
                                                                    : adminValue[index].name,
                                                                  fontSize: 18, fontWeight: FontWeight.w600, textAlign: TextAlign.left
                                                                ),
                                                                trailing: Icon(CupertinoIcons.chevron_right)
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                                                      error: (_,__) => SizedBox(),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          );
                                        }
                                      )
                                    );
                                  });
                                },
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: MQuery.height(0.01, context)
                                ),
                                leading: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Palette.primary,
                                    backgroundImage: NetworkImage(value[index].photoURL),
                                  ),
                                ),
                                title: Font.out(
                                  value[index].name.length >= 34
                                    ? value[index].name.substring(0, 31) + "..."
                                    : value[index].name,
                                  fontSize: 18, fontWeight: FontWeight.w600, textAlign: TextAlign.left
                                ),
                                trailing: Icon(CupertinoIcons.chevron_right)
                              );
                            },
                            physics: BouncingScrollPhysics(),
                            itemCount: value.length,
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          );
                        },
                        loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                        error: (_,__) => SizedBox(),
                      ),
                    )
                  )
                ]
              )
            )
          ),
        );
      },
    );
  }
}