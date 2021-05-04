part of "../view.dart";

class ChatContactPage extends StatefulWidget {

  final NetworkImage avatar;
  final String name;
  final String uid;

  const ChatContactPage({Key? key, required this.avatar, required this.name, required this.uid}) : super(key: key);

  @override
  _ChatContactPageState createState() => _ChatContactPageState();
}

class _ChatContactPageState extends State<ChatContactPage> {

  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }


  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());
    double _height;

    if(MediaQuery.of(context).viewInsets.bottom == 0){
      _height = 0;
    } else {
      _height = MQuery.height(0.03, context);
    }

    return Consumer(
      builder: (context, watch, _){

        final authProvider = watch(authenticationProvider);
        final chatProvider = watch(chatListProvider(widget.uid));

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MQuery.height(0.1, context),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(CupertinoIcons.chevron_left, color: Colors.black),
              onPressed: (){
                Get.back();
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: CircleAvatar(
                      backgroundColor: Palette.primary,
                      backgroundImage: widget.avatar,
                    ),
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 13,
                  child: Font.out(widget.name,
                    fontSize: 18, fontWeight: FontWeight.bold, textAlign: TextAlign.left, color: Colors.black
                  )
                )
              ],
            ),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(
              MQuery.height(0.025, context),
              MQuery.height(0.03, context),
              MQuery.height(0.025, context),
              _height
            ),
            child: Column(
              children: [
                chatProvider.when(
                  data: (value){

                    value.sort((a, b) => a.dateTime.compareTo(b.dateTime));

                    return Expanded(
                      flex: 8,
                      child: ListView.builder( 
                        controller: scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: value.length,
                        itemBuilder: (context, index){
                          return BubbleMessage(
                            uid: value[index].uid,
                            message: value[index].message,
                            dateTime: DateFormat("dd MMMM yyyy HH:mm").format(value[index].dateTime).toString(),
                            byUser: value[index].senderUID == authProvider.auth.currentUser!.uid
                          );
                        },
                      )
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                  error: (_,__) => SizedBox(),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      // s
                    ),
                    child: TextField(
                      minLines: 1,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      controller: controller,
                      style: Font.style(
                        fontSize: 18
                      ),
                      decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send_rounded, color: Palette.primary),
                          onPressed: (){
                            if(controller.text != ""){
                              watch(addChatProvider(
                                ChatModel(
                                  uid: "mock",
                                  dateTime: DateTime.now(),
                                  message: controller.text,
                                  receiverUID: widget.uid,
                                  senderUID: authProvider.auth.currentUser!.uid
                                )
                              ));
                            }
                            controller.clear();
                          },
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.primary, width: 1.5),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 18),
                        hintText: "Type your message...",
                        fillColor: Colors.white70
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}