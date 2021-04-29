part of "../view.dart";

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
                        height: MQuery.height(0.17, context),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Font.out(
                              "Dashboard",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 28,
                              textAlign: TextAlign.start
                            ),
                            Font.out(
                              "find your personal informations here",
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 20,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MQuery.height(0.55, context),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index){
                            return InformationTile(
                              title: "Name",
                              content: "Hanindya Hayunggi",
                            );
                          },
                        ),
                      )
                    ],
                  ),              
                )
              )
            ]
          ),
        )
      )
    );
  }
}