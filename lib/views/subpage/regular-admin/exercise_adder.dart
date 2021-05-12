part of "../../view.dart";

class ExerciseEditor extends StatefulWidget {

  final String? userUID;
  final String? uid;
  final String? title;
  final String? comment;
  final String? video;
  final int? reps;
  final int? sets;
  final int? rest;
  final bool? isCompleted;

  ExerciseEditor(this.userUID, {this.uid, this.title, this.comment, this.video, this.reps, this.sets, this.rest, this.isCompleted});

  @override
  _ExerciseEditorState createState() => _ExerciseEditorState();
}

class _ExerciseEditorState extends State<ExerciseEditor> {

  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  TextEditingController restController = TextEditingController();
  TextEditingController setsController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  bool isCompleted = false;

  @override
  void initState() { 
    super.initState();
    titleController.text = widget.title ?? "";
    commentController.text = widget.comment ?? "";
    videoController.text = widget.video == null ? "" : "https://youtu.be/${widget.video}";
    restController.text = widget.rest == null ? 0.toString() : widget.rest.toString();
    repsController.text = widget.reps == null ? 0.toString() : widget.reps.toString();
    setsController.text = widget.sets == null ? 0.toString() : widget.sets.toString();
    isCompleted = widget.isCompleted == null ? false : widget.isCompleted!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        toolbarHeight: MQuery.height(0.08, context),
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_left, color: Colors.white),
          onPressed: (){
            Get.back();
          },
        ),
        title: Font.out("Add new exercise", fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MQuery.height(0.0255, context),
            vertical: MQuery.height(0.03, context)
          ),
          height: MQuery.height(1.1, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                cursorColor: Palette.primary,
                style: Font.style(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Palette.primary),
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MQuery.width(0.03, context),
                    horizontal: MQuery.width(0.03, context),
                  ),
                  fillColor: Palette.formColor.withOpacity(0.3),
                  focusColor: Palette.formColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                  hintStyle: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Palette.primary),
                  hintText: "Exercise's name"
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              TextFormField(
                maxLines: 5,
                controller: commentController,
                cursorColor: Palette.primary,
                style: Font.style(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Palette.primary),
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MQuery.width(0.03, context),
                    horizontal: MQuery.width(0.03, context),
                  ),
                  fillColor: Palette.formColor.withOpacity(0.3),
                  focusColor: Palette.formColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                  hintStyle: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Palette.primary),
                  hintText: "Exercise's comment",
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.number,
                controller: videoController,
                cursorColor: Palette.primary,
                style: Font.style(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Palette.primary),
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MQuery.width(0.03, context),
                    horizontal: MQuery.width(0.03, context),
                  ),
                  fillColor: Palette.formColor.withOpacity(0.3),
                  focusColor: Palette.formColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                  hintStyle: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Palette.primary),
                  hintText: "Exercise's Video URL (YouTube)",
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.number,
                controller: repsController,
                cursorColor: Palette.primary,
                style: Font.style(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Palette.primary),
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MQuery.width(0.03, context),
                    horizontal: MQuery.width(0.03, context),
                  ),
                  fillColor: Palette.formColor.withOpacity(0.3),
                  focusColor: Palette.formColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                  hintStyle: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Palette.primary),
                  hintText: "Exercise's reps",
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.number,
                controller: setsController,
                cursorColor: Palette.primary,
                style: Font.style(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Palette.primary),
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MQuery.width(0.03, context),
                    horizontal: MQuery.width(0.03, context),
                  ),
                  fillColor: Palette.formColor.withOpacity(0.3),
                  focusColor: Palette.formColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                  hintStyle: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Palette.primary),
                  hintText: "Exercise's sets",
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.number,
                controller: restController,
                cursorColor: Palette.primary,
                style: Font.style(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Palette.primary),
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MQuery.width(0.03, context),
                    horizontal: MQuery.width(0.03, context),
                  ),
                  fillColor: Palette.formColor.withOpacity(0.3),
                  focusColor: Palette.formColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.secondaryBorder, width: 1.25),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                  hintStyle: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Palette.primary),
                  hintText: "Exercise's rest",
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              widget.title == null ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Font.out(
                    "Exercise Completed?",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Palette.primary
                  ),
                  Switch(
                    activeColor: Palette.primary,
                    activeTrackColor: Palette.secondary,
                    inactiveThumbColor: Palette.primary,
                    inactiveTrackColor: Palette.minorTextColor,
                    value: isCompleted,
                    onChanged: (value){
                      setState(() {
                        isCompleted = value;                        
                      });
                    },
                  )
                ],
              ) : SizedBox(),
              SizedBox(height: MQuery.height(0.05, context)),
              Consumer(
                builder: (context, watch, _){
                  return Button(
                    width: double.infinity,
                    method: (){
                      if(titleController.text != "" && videoController.text != ""){
                        if(widget.title == null){
                          watch(exercisesServiceProvider).addExercise(
                            uid: widget.userUID ?? "",
                            isCompleted: isCompleted,
                            videoURL: videoController.text,
                            comment: commentController.text,
                            rest: restController.text == "" ? 0 : int.parse(restController.text),
                            reps: repsController.text == "" ? 0 : int.parse(repsController.text),
                            sets: setsController.text == "" ? 0 : int.parse(setsController.text),
                            title: titleController.text
                          );

                          Get.back();
                        } else {  
                          watch(exercisesServiceProvider).updateExercise(
                            uid: widget.userUID ?? "",
                            id: widget.uid ?? "",
                            isCompleted: widget.isCompleted ?? false,
                            videoURL: videoController.text,
                            comment: commentController.text,
                            rest: restController.text == "" ? 0 : int.parse(restController.text),
                            reps: repsController.text == "" ? 0 : int.parse(repsController.text),
                            sets: setsController.text == "" ? 0 : int.parse(setsController.text),
                            title: titleController.text
                          );

                          Get.back();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Palette.alert,
                            content: Font.out(
                              "Please fill out the necessary forms above",
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        );
                      }
                    },
                    title: widget.title != null ? "Edit exercise" : "Add exercise",
                    color: Palette.primary,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}