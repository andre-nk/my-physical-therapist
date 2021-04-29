part of "../view.dart";

class ChatContactPage extends StatefulWidget {

  final NetworkImage avatar;
  final String name;

  const ChatContactPage({Key? key, required this.avatar, required this.name}) : super(key: key);

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
            Expanded(
              flex: 8,
              child: ListView.builder( 
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index){
                  return index.isEven 
                  ? BubbleMessage(
                      uid: "1",
                      message: "Even Till I love You wasted" + index.toString(),
                      dateTime: "28 April 2021 16:58",
                      byUser: false
                    )
                  : BubbleMessage(
                      uid: "2",
                      message: "Odd This Isn't Supposed To Be Happened" + index.toString(),
                      dateTime: "28 April 2021 16:58",
                      byUser: true
                    );
                },
              )
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
                        print(controller.text);
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
}