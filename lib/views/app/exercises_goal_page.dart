part of '../view.dart';

class ExercisesGoalPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {

    List<Map<String, dynamic>> tabData = [
      {
        "icon": Icon(MyPhysicalTherapist.meal, color: Palette.primary),
        "iconTransfer": Icon(MyPhysicalTherapist.meal, color: Colors.white, size: 24),
        "string": "Nutrition Meals"
      },
      {
        "icon": Icon(MyPhysicalTherapist.barbell_filled, color: Palette.primary, size: 28),
        "iconTransfer": Icon(MyPhysicalTherapist.barbell_filled, color: Colors.white, size: 28),
        "string": "WOD Goals"
      },
      {
        "icon": Icon(MyPhysicalTherapist.vector, color: Palette.primary),
        "iconTransfer": Icon(MyPhysicalTherapist.vector, color: Colors.white, size: 24),
        "string": "Weight Goals"
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MQuery.height(0.95, context),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
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
                          height: 110,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Font.out(
                                "Exercises Goals",
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
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: MQuery.height(0.03, context),
                      right: MQuery.height(0.03, context),
                      top: MQuery.height(0.03, context),
                      bottom: 0,
                    ),
                    child: GridView.count(
                      childAspectRatio: 1/1.25,
                      primary: false,
                      padding: EdgeInsets.all(MQuery.height(0.015, context)
                      ),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      children: tabData.map((data){
                        return GestureDetector(
                          onTap: (){
                            Get.to(() => ExercisesGoalDetailedPage(
                              title: data["string"],
                              icon: data["iconTransfer"],
                            ));
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
                                data["icon"],
                                Font.out(
                                  data["string"],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                  color: Palette.primary
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList().cast<Widget>()
                    )
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}