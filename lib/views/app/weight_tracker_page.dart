part of "../view.dart";

class WeightTrackerPage extends StatefulWidget {
  @override
  _WeightTrackerPageState createState() => _WeightTrackerPageState();
}

class _WeightTrackerPageState extends State<WeightTrackerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final weightValuesProvider = watch(weightTrackerProvider);

        return weightValuesProvider.when(
          data: (value){
            List<WeightValue> _value = value.where((element){
              return (element.dateTime.month == DateTime.now().month);
            }).toList();

            List<int> _valueDay = [];

            _value.sort((a,b) {
                return b.dateTime.compareTo(a.dateTime);
            });

            _value.forEach((element) {
              _valueDay.add(int.parse(DateFormat("dd").format(element.dateTime)));
            });

            print(_valueDay);

            List<FlSpot> spots = [];
            _value.forEach((element) {
              spots.add(
                FlSpot(
                  double.parse(DateFormat("dd").format(element.dateTime)),
                  element.value
                )
              );
            });

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Palette.primary,
                onPressed: (){
                  Get.bottomSheet(
                    BottomSheet(
                      onClosing: (){},
                      builder: (context){
                        TextEditingController controller = TextEditingController();
                        return Container(
                          height: MQuery.height(0.3, context),
                          padding: EdgeInsets.all(
                            MQuery.height(0.025, context)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children:[
                                  Expanded(
                                    flex: 9,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
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
                                            color: Palette.primary),
                                        hintText: "Weight value...",
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        0
                                      ),
                                      child: Font.out(
                                        "kg",
                                        fontWeight: FontWeight.bold, fontSize: 16, color: Palette.primary
                                      )
                                    ),
                                  )
                                ],
                              ),
                              Button(
                                color: Palette.primary,
                                height: MQuery.height(0.075, context),
                                width: double.infinity,
                                title: "Submit weight record",
                                method: (){
                                  if(controller.text != ""){
                                    watch(weightRecordAdderProvider(
                                      [double.parse(controller.text), DateFormat("dd MMMM yyyy HH:mm").format(DateTime.now())]
                                    ));
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      }
                    )
                  );
                },
                child: Container(
                  height: MQuery.height(0.1, context),
                  child: Icon(CupertinoIcons.add, color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(
                        child: Container(
                          height: MQuery.height(1.3, context),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 16,
                                child: Header(
                                  content: Column(
                                    children: [
                                      AppBar(
                                        leadingWidth: MQuery.width(0.025, context),
                                        toolbarHeight: MQuery.height(0.05, context),
                                        leading: IconButton(
                                          icon: Icon(CupertinoIcons.chevron_left, size: 24),
                                          onPressed: (){
                                            Get.back();
                                          },
                                        ),
                                        title: Font.out(
                                          DateFormat("MMMM").format(DateTime.now()),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold, color: Colors.white
                                        ),
                                        centerTitle: true,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: MQuery.height(0.01, context)
                                        ),
                                        height: MQuery.height(0.41, context),
                                        width: double.infinity,
                                        child: LineChart(
                                          LineChartData(
                                            gridData: FlGridData(
                                              show: true,
                                              drawVerticalLine: true,
                                              getDrawingHorizontalLine: (value) {
                                                return FlLine(
                                                  color: Palette.tertiary.withOpacity(0.15),
                                                  strokeWidth: 1,
                                                );
                                              },
                                              getDrawingVerticalLine: (value) {
                                                return FlLine(
                                                  color: Palette.tertiary.withOpacity(0.15),
                                                  strokeWidth: 1,
                                                );
                                              },
                                            ),
                                            titlesData: FlTitlesData(
                                              show: true,
                                              bottomTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 22,
                                                getTextStyles: (value) => Font.style(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                                getTitles: (value) {
                                                  return value.toInt().isEven && value.toInt() != 0
                                                    ? (value.toInt()).toString()
                                                    : "";
                                                },
                                                margin: 8,
                                              ),
                                              leftTitles: SideTitles(
                                                showTitles: false,
                                                getTextStyles: (value) => 
                                                  Font.style(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                                getTitles: (value) {
                                                  switch (value.toInt()) {
                                                    case 1:
                                                      return '10k';
                                                    case 3:
                                                      return '30k';
                                                    case 5:
                                                      return '50k';
                                                  }
                                                  return '';
                                                },
                                                reservedSize: 28,
                                                margin: 12,
                                              ),
                                            ),
                                            borderData: FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
                                            minX: 1,
                                            maxX: _valueDay[0] <= 15
                                              ? 15
                                              : _valueDay[0] <= 30
                                                ? 30
                                                : 90,
                                            minY: 0,
                                            maxY: 250,
                                            lineBarsData: [
                                              LineChartBarData(
                                                colors: [
                                                  Palette.primary
                                                ],
                                                spots: spots,
                                                isCurved: true,
                                                barWidth: 3,
                                                isStrokeCapRound: true,
                                                dotData: FlDotData(
                                                  show: true,
                                                ),                        
                                                belowBarData: BarAreaData(
                                                  colors: [
                                                    Palette.secondary.withOpacity(0.75)
                                                  ],
                                                  show: true,
                                                ),
                                              ),
                                            ],
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 21,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                    MQuery.height(0.04, context),
                                    MQuery.height(0.01, context),
                                    MQuery.height(0.04, context),
                                    MQuery.height(0.04, context),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: MQuery.height(0.325, context),
                                        child: GridView.count(
                                          childAspectRatio: 1/1.25,
                                          primary: false,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                          crossAxisCount: 2,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Palette.formColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10)
                                                  )
                                                ),
                                                padding: EdgeInsets.all(MQuery.height(0.025, context)),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Font.out(
                                                      value[0].value.toInt().toString(), //value
                                                      fontSize: 28,
                                                      fontWeight: FontWeight.bold,
                                                      textAlign: TextAlign.start,
                                                      color: Palette.primary
                                                    ),
                                                    Font.out(
                                                      "Current Weight (kg)",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      textAlign: TextAlign.start,
                                                      color: Palette.primary
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Palette.formColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10)
                                                  )
                                                ),
                                                padding: EdgeInsets.all(MQuery.height(0.025, context)),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Font.out(
                                                      (value[0].value - value[value.length - 1].value).toString().length > 4
                                                        ? "-" + (value[0].value - value[value.length - 1].value).toString().substring(0,4)
                                                        : (value[0].value - value[value.length - 1].value).toString(),
                                                      fontSize: 28,
                                                      fontWeight: FontWeight.bold,
                                                      textAlign: TextAlign.start,
                                                      color: Palette.primary
                                                    ),
                                                    Font.out(
                                                      "Weight Loss (kg)",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      textAlign: TextAlign.start,
                                                      color: Palette.primary
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ]
                                        ),
                                      ),
                                      SizedBox(height: MQuery.height(0.01, context)),
                                      Font.out(
                                        "History",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                      SizedBox(height: MQuery.height(0.01, context)),
                                      Container(
                                        height: MQuery.height(0.3, context),
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: value.length,
                                          itemBuilder: (context, index){
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MQuery.height(0.015, context)
                                              ),
                                              child: ListTile(                                
                                                contentPadding: EdgeInsets.symmetric(
                                                  vertical: MQuery.height(0.005, context),
                                                  horizontal: MQuery.width(0.03, context),
                                                ),
                                                tileColor: Palette.formColor,
                                                title: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Font.out(
                                                      value[index].value.toString() + " kg",
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                    Font.out(
                                                      DateFormat("dd MMMM").format(value[index].dateTime),
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.normal
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                )
                              )
                            ]
                          )
                        ),
                      )
                    );
        },
        loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
        error: (_,__) => SizedBox(),
      );
    });
  }
}