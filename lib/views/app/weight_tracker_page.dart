part of "../view.dart";

class WeightTrackerPage extends StatefulWidget {
  @override
  _WeightTrackerPageState createState() => _WeightTrackerPageState();
}

class _WeightTrackerPageState extends State<WeightTrackerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MQuery.height(1.3, context),
            child: Column(
              children: [
                Expanded(
                  flex: 15,
                  child: Header(
                    content: Column(
                      children: [
                        AppBar(
                          leadingWidth: MQuery.width(0.025, context),
                          toolbarHeight: MQuery.height(0.06, context),
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
                          padding: EdgeInsets.only(
                            top: MQuery.height(0.01, context)
                          ),
                          height: MQuery.height(0.425, context),
                          width: double.infinity,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Palette.tertiary.withOpacity(0.3),
                                    strokeWidth: 1,
                                  );
                                },
                                getDrawingVerticalLine: (value) {
                                  return FlLine(
                                    color: Palette.tertiary.withOpacity(0.3),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 22,
                                  getTextStyles: (value) =>
                                    Font.style(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                  getTitles: (value) {
                                    switch (value.toInt()) {
                                      case 3:
                                        return 'MAR';
                                      case 5:
                                        return 'JUN';
                                      case 8:
                                        return 'SEP';
                                      case 10:
                                        return 'SEP';
                                    }
                                    return '';
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
                              minX: 0,
                              maxX: 12,
                              minY: 0,
                              maxY: 9,
                              lineBarsData: [
                                LineChartBarData(
                                  colors: [
                                    Palette.primary
                                  ],
                                  spots: [
                                    FlSpot(0, 3), //(X, Y) => Y => VALUE || X => PARAM
                                    FlSpot(2.6, 2),
                                    FlSpot(4.9, 5),
                                    FlSpot(6.8, 3.1),
                                    FlSpot(8, 4),
                                    FlSpot(9.5, 3),
                                    FlSpot(11, 3.9),
                                    FlSpot(12, 4),
                                  ],
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
                  flex: 20,
                  child: Container(
                    padding: EdgeInsets.all(
                      MQuery.height(0.04, context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MQuery.height(0.3, context),
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
                                        70.toString(), //value
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
                                        "-" + 0.1.toString(), //value
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
                        Font.out(
                          "History",
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                        SizedBox(height: MQuery.height(0.02, context)),
                        Container(
                          height: MQuery.height(0.3, context),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: 5,
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
                                        "73 kg",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                      Font.out(
                                        DateFormat("dd MMMM").format(DateTime.now()),
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
                ),
              ]
            )
          )
        )
      )
    );
  }
}