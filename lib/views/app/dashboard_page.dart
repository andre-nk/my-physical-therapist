part of "../view.dart";

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final userModelGetter = watch(userModelProvider);

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
                    flex: 8,
                    child: userModelGetter.when(
                      data: (value){

                        print(value.ancilaryProcedure);
                        List<MedicationHistory> medsHistory = [];
                        List<AncilaryProcedure> ancilaryProcedures = [];

                        value.medicationHistory.forEach((element) {
                          medsHistory.add(MedicationHistory(
                              indications: element["indication"],
                              medications: element["medications"],
                              sideEffects: element["sideEffect"],
                              dosage: element["dosage"]
                            )
                          );
                        });

                        value.ancilaryProcedure.forEach((element) {
                          ancilaryProcedures.add(AncilaryProcedure(
                            date: element["date"],
                            ancilaryProcedure: element["ancilaryProcedure"],
                            findings: element["findings"]
                          ));
                        });

                        print(medsHistory[0].indications);

                        return Container(
                          padding: EdgeInsets.only(
                            left: MQuery.height(0.03, context),
                            right: MQuery.height(0.03, context),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: MQuery.height(0.625, context),
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    InformationTile(title: "Name", content: value.name, shrink: true),
                                    InformationTile(title: "Civil status", content: value.civilStatus, shrink: true),
                                    InformationTile(title: "Age", content: value.age.toString(), shrink: true),
                                    InformationTile(title: "Sex", content: value.sex, shrink: true),
                                    InformationTile(title: "Address", content: value.address, shrink: true),
                                    InformationTile(title: "Occupation", content: value.occupation, shrink: true),
                                    InformationTile(title: "Religion", content: value.religion, shrink: true),
                                    InformationTile(title: "Nationality", content: value.nationality, shrink: true),
                                    InformationTile(title: "Handedness", content: value.handedness, shrink: true),
                                    InformationTile(title: "Type of Patient", content: value.type, shrink: true),
                                    InformationTile(title: "Date of Admission", content: DateFormat("dd MMMM yyyy").format(value.admissionDate), shrink: true),
                                    InformationTile(title: "Date of IE", content: DateFormat("dd MMMM yyyy").format(value.ieDate), shrink: true),
                                    InformationTile(title: "Informant / Reliability", content: value.informant, shrink: false),
                                    InformationTile(title: "Diagnosis", content: value.diagnosis, shrink: false),
                                    InformationTile(title: "Chief Complaint", content: value.complaint, shrink: false),
                                    InformationTile(title: "Caregiver/Relatives Goal", content: value.caregiverGoal, shrink: false),
                                    InformationTile(title: "History Of Present Illness:", content: value.illnessHistory, shrink: false),
                                    SizedBox(height: MQuery.height(0.01, context)),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: MQuery.height(0.025, context),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Font.out(
                                            "Medications History",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),
                                          Container(
                                            height: MQuery.height(0.3, context),
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child: SingleChildScrollView(
                                                child: DataTable(                                            
                                                  columns: [
                                                    DataColumn(label: Font.out("Medications", fontWeight: FontWeight.bold)),
                                                    DataColumn(label: Font.out("Dosage", fontWeight: FontWeight.bold)),
                                                    DataColumn(label: Font.out("Indications", fontWeight: FontWeight.bold)),
                                                    DataColumn(label: Font.out("Side Effect", fontWeight: FontWeight.bold)),
                                                  ],
                                                  rows: medsHistory.map((value){
                                                    return DataRow(
                                                      cells: [
                                                        DataCell(Font.out(value.medications)),
                                                        DataCell(Font.out(value.dosage)),
                                                        DataCell(Font.out(value.indications)),
                                                        DataCell(Font.out(value.sideEffects)),
                                                      ]
                                                    );
                                                  }).toList().cast<DataRow>()
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: MQuery.height(0.01, context)),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: MQuery.height(0.025, context),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Font.out(
                                            "Ancilary Procedures",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),
                                          Container(
                                            height: MQuery.height(0.3, context),
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child: SingleChildScrollView(
                                                child: DataTable(
                                                  columns: [
                                                    DataColumn(label: Font.out("Ancilary Procedure", fontWeight: FontWeight.bold)),
                                                    DataColumn(label: Font.out("Date", fontWeight: FontWeight.bold)),
                                                    DataColumn(label: Font.out("Findings", fontWeight: FontWeight.bold)),
                                                  ],
                                                  rows: ancilaryProcedures.map((value){
                                                    return DataRow(
                                                      cells: [
                                                        DataCell(Font.out(value.ancilaryProcedure)),
                                                        DataCell(Font.out(value.date)),
                                                        DataCell(Font.out(value.findings)),
                                                      ]
                                                    );
                                                  }).toList().cast<DataRow>()
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: MQuery.height(0.01, context)),
                                    InformationTile(title: "Past Medical History:", content: value.pastMedicalHistory, shrink: false),
                                    InformationTile(title: "Past Family History:", content: value.familyHistory, shrink: false),
                                    InformationTile(title: "Personal, Social, and Environmental History:", content: value.environmentalHistory, shrink: false),
                                  ],
                                ),
                              )
                            ],
                          ),              
                        );
                      },
                      loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                      error: (_,__) => SizedBox(),
                    )
                  )
                ]
              ),
            )
          )
        );
      }
    );
  }
}