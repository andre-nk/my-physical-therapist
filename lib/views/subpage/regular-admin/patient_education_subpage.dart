part of "../../view.dart";

class PatientEducationSubPage extends StatefulWidget {

  final String type;
  final String uid;
  PatientEducationSubPage(this.uid, this.type);

  @override
  _PatientEducationSubPageState createState() => _PatientEducationSubPageState();
}

class _PatientEducationSubPageState extends State<PatientEducationSubPage> {

  bool isImageViewActive = false;
  bool isEditing = false;
  TextEditingController editController = TextEditingController();

  File? _image;
  String? _contentPhotoURL;
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
        final content = watch(generalContentServiceProvider).generalContentModelGetter([widget.uid, widget.type.toLowerCase()]);

        if(_image != null && _contentPhotoURL == null){
          watch(generalContentServiceProvider).uploadContentPhotoURL(_image ?? File("")).then((value){
            setState(() {
              _contentPhotoURL = value;      
            });
          });
        }

        return Scaffold(
          floatingActionButton: isImageViewActive
            ? SizedBox()
            : isEditing
            ? StreamBuilder<GeneralContentModel>(
                stream: content,
                builder: (context, snapshot){
                  return FloatingActionButton(
                    backgroundColor: Palette.primary,
                    onPressed: (){
                      setState(() {
                        watch(generalContentServiceProvider)
                        .generalContentEditor(
                          GeneralContentModel(
                            text: editController.text == "" ? snapshot.data!.text : editController.text,
                            imageURL: _contentPhotoURL ?? snapshot.data!.imageURL
                          ),
                          widget.uid,
                          widget.type.toLowerCase()
                        );
                        isEditing = false;                
                      });
                    },
                    child: Icon(CupertinoIcons.checkmark_alt),
                  );
                }
              )
            : FloatingActionButton(
                backgroundColor: Palette.primary,
                onPressed: (){
                  setState(() {
                    isEditing = true;                
                  });
                },
                child: Icon(CupertinoIcons.pencil),
              ),
          body: isImageViewActive == true
            ? StreamBuilder<GeneralContentModel>(
                stream: content,
                builder: (context, snapshot){
                  return snapshot.hasData
                  ? GestureDetector(
                      onLongPress: (){
                        setState(() {
                          isImageViewActive = false;                     
                        });
                      },
                      child: Container(
                        child: PhotoView(
                          imageProvider: NetworkImage(snapshot.data!.imageURL ?? ""),
                        )
                      ),
                    )
                  : SizedBox();
                }
              )
            : isEditing
              ? SingleChildScrollView(
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
                            child: StreamBuilder<GeneralContentModel>(
                              stream: content,
                              builder: (context, snapshot){

                                print(snapshot.data);
                                editController.text = snapshot.data ==  null ? "" : snapshot.data!.text;
                                print(_image);

                                return snapshot.hasData
                                  ? Container(
                                    width: double.infinity,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                        GestureDetector(
                                          onTap: _pickedImage,
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
                                              child: _image == null
                                                ? Image.network(snapshot.data!.imageURL ?? "", fit: BoxFit.fill)
                                                : Image.file(_image ?? File(""), fit: BoxFit.fill)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: MQuery.height(0.025, context)),
                                        TextFormField(
                                          maxLines: 100,
                                          controller: editController,
                                          textAlign: TextAlign.start,
                                          style: Font.style(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : Container(
                                    width: double.infinity,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                      GestureDetector(
                                        onTap: _pickedImage,
                                        child: AspectRatio(
                                          aspectRatio: 4/3,
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(                                 
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20)
                                              ),
                                              color: Palette.secondary
                                            ),
                                            width: double.infinity,
                                            child: _image == null
                                              ? Image.network(snapshot.data == null ? "" : snapshot.data!.imageURL ?? "", fit: BoxFit.fill)
                                              : Image.file(_image ?? File(""), fit: BoxFit.fill),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: MQuery.height(0.025, context)),
                                      TextFormField(
                                        maxLines: 100,
                                        controller: editController,
                                        textAlign: TextAlign.start,
                                        style: Font.style(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Please pick an image first before writing the article here...",
                                          hintStyle: Font.style(
                                            color: Palette.minorTextColor,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            )
                          )
                        )
                      ]
                    )
                  )
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
                            child: StreamBuilder<GeneralContentModel>(
                              stream: content,
                              builder: (context, snapshot){
                                return snapshot.hasData
                                  ? Container(
                                    width: double.infinity,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                        snapshot.data!.imageURL != ""
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
                                                  child: Image.network(snapshot.data!.imageURL ?? "", fit: BoxFit.fill)
                                                ),
                                              ),
                                          ) 
                                        : SizedBox(),
                                        SizedBox(height: MQuery.height(0.025, context)),
                                        Linkify(
                                          text: snapshot.data!.text,
                                          textAlign: TextAlign.start,
                                          style: Font.style(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox();
                              }
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