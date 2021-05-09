part of "../../view.dart";

class UserPatientEducationPage extends StatefulWidget {

  final UserModelSimplified userModelSimplified;

  const UserPatientEducationPage({Key? key, required this.userModelSimplified}) : super(key: key);

  @override
  _UserPatientEducationPageState createState() => _UserPatientEducationPageState();
}

class _UserPatientEducationPageState extends State<UserPatientEducationPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        String displayName = widget.userModelSimplified.name.length > 20 
          ? widget.userModelSimplified.name.substring(0, 20) + "..."
          : widget.userModelSimplified.name;

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
                                icon : Icon(CupertinoIcons.chevron_left, size: 24),
                                onPressed: (){
                                  Get.back();
                                },
                              ),
                              actions: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 200
                                  ),
                                  child: CircleAvatar(
                                    maxRadius: 25,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image(image: NetworkImage(widget.userModelSimplified.photoURL)),
                                    ),
                                  )   
                                ),
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
                                    "patient educations of",
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
                        padding: EdgeInsets.symmetric(
                          vertical: MQuery.height(0.035, context),
                          horizontal: MQuery.height(0.035, context)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DefaultTile(
                              icons: Icon(CupertinoIcons.xmark_circle, color: Palette.alert),
                              callback: (){
                                Get.to(() => PatientEducationSubPage(
                                  widget.userModelSimplified.uid,
                                  "Contraindications"
                                ), transition: Transition.cupertino);
                              },
                              title: "Contraindications",
                            ),
                            SizedBox(height: MQuery.height(0.025, context)),
                            DefaultTile(
                              icons: Icon(CupertinoIcons.exclamationmark_circle, color: Palette.warning),
                              callback: (){
                                Get.to(() => PatientEducationSubPage(
                                  widget.userModelSimplified.uid,
                                  "Precautions"
                                ), transition: Transition.cupertino);
                              },
                              title: "Precautions",
                            ),
                            SizedBox(height: MQuery.height(0.025, context)),
                            DefaultTile(
                              icons: Icon(CupertinoIcons.paperclip, color: Palette.primary),
                              callback: (){
                                Get.to(() => PatientEducationSubPage(
                                  widget.userModelSimplified.uid,
                                  "General Instructions"
                                ), transition: Transition.cupertino);
                                // Get.to(() => PatientEducationSubPage("General \nInstructions"), transition: Transition.cupertino);
                              },
                              title: "General Instructions",
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          
        );
      }
    );
  }
}