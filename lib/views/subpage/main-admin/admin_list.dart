part of '../../view.dart';

class AdminList extends StatefulWidget {
  @override
  _AdminListState createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final adminModelListProvider = watch(adminListProvider);
        final userModelListProvider = watch(userListProvider);

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
                                  "Admins List",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 28,
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
                      child: adminModelListProvider.when(
                        data: (value){
                          return ListView.separated(
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index){
                              return Divider();
                            },
                            itemCount: value.length,
                            itemBuilder: (context, index){

                              Admin selectedAdmin = value[index];

                              return watch(userHandledProvider(value[index].uid)).when(
                                data: (userHandleValue){
                                  return ListTile(
                                    onTap: (){
                                      userModelListProvider.whenData((userHandledListValue){
                                        Get.bottomSheet(
                                          BottomSheet(
                                            onClosing: (){},
                                            builder: (context){

                                              List<UserModelSimplified> filtered = [];

                                              userHandleValue.forEach((admin) {
                                                userHandledListValue.forEach((user) {
                                                  if(user.uid == admin.uid){
                                                    filtered.add(user);
                                                  }
                                                });
                                              });

                                              return Container(
                                                height: MQuery.height(0.5, context),
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
                                                          backgroundImage: NetworkImage(selectedAdmin.photoURL),
                                                        ),
                                                        SizedBox(width: MQuery.width(0.025, context)),
                                                        Font.out(
                                                          selectedAdmin.name,
                                                          fontSize: 20, fontWeight: FontWeight.bold, textAlign: TextAlign.left
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: MQuery.height(0.03, context)),
                                                    Font.out(
                                                      "User handled:",
                                                      fontSize: 16, fontWeight: FontWeight.normal, textAlign: TextAlign.left
                                                    ),
                                                    SizedBox(height: MQuery.height(0.005, context)),
                                                    Container(
                                                      height: MQuery.height(0.25, context),
                                                      child: ListView.separated(
                                                        separatorBuilder: (context, index){
                                                          return Divider();
                                                        },
                                                        itemCount: filtered.length,
                                                        itemBuilder: (context, index){
                                                          return ListTile(
                                                            contentPadding: EdgeInsets.symmetric(
                                                              vertical: MQuery.height(0.01, context)
                                                            ),
                                                            leading: Padding(
                                                              padding: const EdgeInsets.only(right: 8.0),
                                                              child: CircleAvatar(
                                                                backgroundColor: Palette.primary,
                                                                backgroundImage: NetworkImage(filtered[index].photoURL),
                                                              ),
                                                            ),
                                                            title: Font.out(
                                                              filtered[index].name.length >= 34
                                                                ? filtered[index].name.substring(0, 31) + "..."
                                                                : filtered[index].name,
                                                              fontSize: 18, fontWeight: FontWeight.w600, textAlign: TextAlign.left
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  ]          
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
                                    trailing: Font.out(
                                      userHandleValue.length.toString() + " users",
                                      fontSize: 16, fontWeight: FontWeight.normal, textAlign: TextAlign.left, color: Palette.minorTextColor
                                    ),
                                  );
                                },
                                loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                                error: (_,__) => SizedBox(),
                              );
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
      }
    );
  }
}