part of "../view.dart";

class EventAdder extends StatefulWidget {
  @override
  _EventAdderState createState() => _EventAdderState();
}

class _EventAdderState extends State<EventAdder> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController mediaController = TextEditingController();
  TextEditingController speakerController = TextEditingController();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  final format = DateFormat("dd MMMM yyyy HH:mm");

  @override
  Widget build(BuildContext context) {

    print(startTime);

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
        title: Font.out("Add new event", fontSize: 20, fontWeight: FontWeight.bold),
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
                  hintText: "Event's title",
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              TextFormField(
                maxLines: 5,
                controller: descriptionController,
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
                  hintText: "Event's description",
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              TextFormField(
                controller: speakerController,
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
                  hintText: "Event's speaker / host",
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              TextFormField(
                controller: mediaController,
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
                  hintText: "Event's media",
                ),
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              Font.out("Event's start time", fontSize: 18, fontWeight: FontWeight.bold),
              SizedBox(height: MQuery.height(0.0175, context)),
              DateTimeField(
                resetIcon: Icon(CupertinoIcons.clear),
                style: Font.style(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Palette.primary),
                decoration: InputDecoration(
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
                  hintText: "Event's start time",
                ),
                initialValue: startTime,
                format: format,
                onShowPicker: (context, currentValue) async {
                  await showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return BottomSheet(
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                constraints: BoxConstraints(maxHeight: 200),
                                child: CupertinoDatePicker(
                                  onDateTimeChanged: (DateTime date) {
                                    startTime = date;
                                  },
                                ),
                              ),
                              TextButton(onPressed: () => Navigator.pop(context), child: Font.out('Confirm', fontSize: 16)),
                            ],
                          ),
                          onClosing: () {},
                        );
                      });
                  setState(() {});
                  return startTime;
                },
              ),
              SizedBox(height: MQuery.height(0.025, context)),
              Font.out("Event's end time", fontSize: 18, fontWeight: FontWeight.bold),
              SizedBox(height: MQuery.height(0.0175, context)),
              DateTimeField(
                resetIcon: Icon(CupertinoIcons.clear),
                style: Font.style(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Palette.primary),
                decoration: InputDecoration(
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
                  hintText: "Event's end time",
                ),
                initialValue: endTime,
                format: format,
                onShowPicker: (context, currentValue) async {
                  await showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return BottomSheet(
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                constraints: BoxConstraints(maxHeight: 200),
                                child: CupertinoDatePicker(
                                  onDateTimeChanged: (DateTime date) {
                                    endTime = date;
                                  },
                                ),
                              ),
                              TextButton(onPressed: () => Navigator.pop(context), child: Font.out('Confirm', fontSize: 16)),
                            ],
                          ),
                          onClosing: () {},
                        );
                      });
                  setState(() {});
                  return endTime;
                },
              ),
              SizedBox(height: MQuery.height(0.05, context)),
              Consumer(
                builder: (context, watch, _){
                  return Button(
                    width: double.infinity,
                    method: (){
                      if(titleController.text != "" && descriptionController.text != ""
                        && mediaController.text != "" && speakerController.text != ""
                      ){
                        watch(eventAdderProvider(
                          EventModel(
                            end: endTime,
                            start: startTime,
                            speaker: speakerController.text,
                            media: mediaController.text,
                            title: titleController.text,
                            description: descriptionController.text
                          )
                        ));
                        Get.back();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Palette.alert,
                            content: Font.out(
                              "Please fill out all the forms above",
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        );
                      }
                    },
                    title: "Add event",
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