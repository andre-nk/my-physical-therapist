part of "../view.dart";

class PatientEducationSubPage extends StatefulWidget {

  final String type;
  PatientEducationSubPage(this.type);

  @override
  _PatientEducationSubPageState createState() => _PatientEducationSubPageState();
}

class _PatientEducationSubPageState extends State<PatientEducationSubPage> {

  bool isImageViewActive = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){
        print(isImageViewActive);
        final content = watch(generalContentProvider(widget.type.toLowerCase()));

        return Scaffold(
          body: isImageViewActive == true
            ? content.when(
                data: (value) => GestureDetector(
                  onLongPress: (){
                    setState(() {
                      isImageViewActive = false;                     
                    });
                  },
                  child: Container(
                    child: PhotoView(
                      imageProvider: NetworkImage(value.imageURL ?? ""),
                    )
                  ),
                ),
                loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                error: (_,__) => SizedBox(),
              )
            : SingleChildScrollView(
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
                                    widget.type,
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
                      child: Container(
                        padding: EdgeInsets.only(
                          left: MQuery.height(0.03, context),
                          right: MQuery.height(0.03, context),
                          top: MQuery.height(0.03, context),
                          bottom: 0,
                        ),
                        child: content.when(
                          data: (content){
                            return Container(
                              width: double.infinity,
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  content.imageURL != ""
                                  ? GestureDetector(
                                      onTap: (){
                                        print("clc");
                                        setState(() {
                                          isImageViewActive = true;                     
                                        });
                                      },
                                      child: AspectRatio(
                                          aspectRatio: 4/3,
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(                                 
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20)
                                              )
                                            ),
                                            width: double.infinity,
                                            child: Image.network(content.imageURL ?? "", fit: BoxFit.fill)
                                          ),
                                        ),
                                    ) 
                                  : SizedBox(),
                                  SizedBox(height: MQuery.height(0.025, context)),
                                  Linkify(
                                    text: content.text,
                                    textAlign: TextAlign.start,
                                    style: Font.style(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
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
          );
      }
    );
  }
}