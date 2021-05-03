part of "../view.dart";

class PainScalePage extends StatefulWidget {
  @override
  _PainScalePageState createState() => _PainScalePageState();
}

class _PainScalePageState extends State<PainScalePage> {

  double _value = 0;
  List<String> _emojis = ['😃','😃','😟','😟','😞','😞','🥺','🥺','😫','😫','🤕','🤕'];
  double _height = 17.5;
  bool overrideFirestoreValue = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                            "Pain Scale",
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
              flex: 8,
              child: Consumer(
                builder: (context, watch, _){

                  final sliderValues = watch(userScaleProvider);

                  print(sliderValues);

                  return sliderValues.when(
                    data: (value){
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MQuery.height(0.03, context),
                          vertical: MQuery.height(0.04, context)
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Font.out(
                                "How would you rate your pain right now?",
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              SizedBox(height: _height),
                              Container(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    valueIndicatorColor: Colors.transparent,
                                    valueIndicatorTextStyle: Font.style(
                                      fontSize: 24
                                    )
                                  ),
                                  child: Slider(
                                    label: _emojis[_value.toInt()],
                                    value: overrideFirestoreValue ? _value : value[0],
                                    min: 0.0,
                                    max: 10.0,
                                    onChangeStart: (double value) {
                                      setState(() {
                                        overrideFirestoreValue = true;
                                        _height = MQuery.height(0.06, context);

                                      });
                                      print('Start value is ' + value.toString());
                                    },
                                    onChangeEnd: (double value) {
                                      setState(() {
                                        watch(userScaleSetterProvider(["painScale", value]));
                                        _height = 17.5;                                  
                                      });
                                      print('Finish value is ' + value.toString());
                                    },
                                    onChanged: (double value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                                    activeColor: Palette.primary,
                                    inactiveColor: Palette.tertiary,
                                    divisions: 10,
                                  ),
                                ),
                              ),
                              SizedBox(height: MQuery.height(0.025, context)),
                              Font.out(
                                "How would you describe this pain feeling?",
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              SizedBox(height: MQuery.height(0.02, context)),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                maxLines: 5,
                                controller: controller,
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
                                    color: Palette.primary
                                  ),
                                  hintText: value[1],
                                ),
                                onEditingComplete: (){
                                  if(controller.text != ""){
                                    watch(userPainDescriptionSetter(controller.text));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Palette.secondary,
                                        content: Font.out(
                                          "Your pain record has been recorded",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                    error: (_,__) => SizedBox(),
                  );
                }
              ),
            ),
          ])
        )
      )
    );
  }
}