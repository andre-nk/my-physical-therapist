part of "../../view.dart";

class UserHomePage extends StatefulWidget {

  final UserModelSimplified userModelSimplified;

  const UserHomePage({Key? key, required this.userModelSimplified}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController civilController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController handednessController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController complaintController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController illnessController = TextEditingController();
  TextEditingController medicalController = TextEditingController();
  TextEditingController historyController = TextEditingController();
  TextEditingController socialController = TextEditingController();
  DateTime? admissionDate;
  DateTime? ieDate;
  final format = DateFormat("dd MMMM yyyy");

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        String displayName = widget.userModelSimplified.name.length > 20 
          ? widget.userModelSimplified.name.substring(0, 20) + "..."
          : widget.userModelSimplified.name;

        final userModelGetter = watch(userModelProvider(widget.userModelSimplified.uid));

        print(userModelGetter);

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Palette.primary,
            onPressed: (){
              if(isEditing == true){
                watch(userProvider).updateUserGeneralInfo(
                  UserModel(
                    environmentalHistory: socialController.text,
                    ancilaryProcedure: [],
                    medicationHistory: [],
                    handedness: handednessController.text,
                    nationality: nationalityController.text,
                    religion: religionController.text,
                    adminHandler: "",
                    name: nameController.text,
                    civilStatus: civilController.text,
                    ieDate: ieDate ?? DateTime.now(),
                    admissionDate: admissionDate ?? DateTime.now(),
                    caregiverGoal: goalController.text,
                    familyHistory: historyController.text,
                    complaint: complaintController.text,
                    age: int.parse(ageController.text),
                    informant: infoController.text,
                    illnessHistory: illnessController.text,
                    diagnosis: diagnosisController.text,
                    sex: sexController.text,
                    occupation: occupationController.text,
                    type: typeController.text,
                    pastMedicalHistory: medicalController.text,
                    photoURL: "",
                    address: addressController.text
                  ),
                  widget.userModelSimplified.uid
                );
              }
              setState(() {
                isEditing = !isEditing;                
              });
            },
            child: isEditing ? Icon(CupertinoIcons.checkmark_alt) : Icon(CupertinoIcons.pencil),
          ),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
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
                                  "dashboard for user:",
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
                      padding: EdgeInsets.only(
                        top: MQuery.height(0.035, context),
                        left: MQuery.height(0.035, context),
                        right: MQuery.height(0.035, context),
                        bottom: MQuery.height(0.1, context),
                      ),
                      
                      child: userModelGetter.when(
                        data: (value){
                          List<MedicationHistory> medsHistory = [];
                          List<AncilaryProcedure> ancilaryProcedures = [];

                          value.medicationHistory.forEach((element) {
                            medsHistory.add(MedicationHistory(
                                indications: element["indication"] ?? "",
                                medications: element["medications"] ?? "",
                                sideEffects: element["sideEffect"] ?? "",
                                dosage: element["dosage"] ?? ""
                              )
                            );
                          });

                          value.ancilaryProcedure.forEach((element) {
                            ancilaryProcedures.add(AncilaryProcedure(
                              date: element["date"] ?? "",
                              ancilaryProcedure: element["ancilaryProcedure"] ?? "",
                              findings: element["findings"] ?? ""
                            ));
                          });

                          return isEditing
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: MQuery.height(0.525, context),
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    children: [
                                      InformationTile(controller: nameController, isEditing: isEditing, title: "Name", content: value.name, shrink: true),
                                      InformationTile(controller: civilController, isEditing: isEditing, title: "Civil status", content: value.civilStatus, shrink: true),
                                      InformationTile(controller: ageController, isEditing: isEditing, title: "Age", content: value.age.toString(), shrink: true),
                                      InformationTile(controller: sexController, isEditing: isEditing, title: "Sex", content: value.sex, shrink: true),
                                      InformationTile(controller: addressController, isEditing: isEditing, title: "Address", content: value.address, shrink: true),
                                      InformationTile(controller: occupationController, isEditing: isEditing, title: "Occupation", content: value.occupation, shrink: true),
                                      InformationTile(controller: religionController, isEditing: isEditing, title: "Religion", content: value.religion, shrink: true),
                                      InformationTile(controller: nationalityController, isEditing: isEditing, title: "Nationality", content: value.nationality, shrink: true),
                                      InformationTile(controller: handednessController, isEditing: isEditing, title: "Handedness", content: value.handedness, shrink: true),
                                      InformationTile(controller: typeController, isEditing: isEditing, title: "Type of Patient", content: value.type, shrink: true),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: MQuery.height(0.015, context)),
                                          Font.out(
                                            "Date of Admission",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.start
                                          ),
                                          SizedBox(height: MQuery.height(0.01, context)),
                                          DateTimeField(
                                            resetIcon: Icon(CupertinoIcons.clear),
                                            style: Font.style(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                vertical: MQuery.height(0.025, context),
                                                horizontal: MQuery.height(0.02, context)
                                              ),
                                              fillColor: Palette.formColor,
                                              focusColor: Palette.formColor,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Palette.secondaryBorder.withOpacity(0), width: 0
                                                )
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Palette.secondaryBorder.withOpacity(0), width: 0
                                                )
                                              ),
                                              filled: true,
                                              hintStyle: Font.style(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                              hintText: admissionDate == null ? format.format(value.admissionDate) : format.format(admissionDate!),
                                            ),
                                            initialValue: admissionDate == null ? value.admissionDate: admissionDate,
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
                                                                admissionDate = date;
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
                                              return admissionDate;
                                            },
                                          ),
                                          SizedBox(height: MQuery.height(0.015, context)),
                                          Font.out(
                                            "Date of IE",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.start
                                          ),
                                          SizedBox(height: MQuery.height(0.01, context)),
                                          DateTimeField(
                                            resetIcon: Icon(CupertinoIcons.clear),
                                            style: Font.style(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                vertical: MQuery.height(0.025, context),
                                                horizontal: MQuery.height(0.02, context)
                                              ),
                                              fillColor: Palette.formColor,
                                              focusColor: Palette.formColor,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Palette.secondaryBorder.withOpacity(0), width: 0
                                                )
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Palette.secondaryBorder.withOpacity(0), width: 0
                                                )
                                              ),
                                              filled: true,
                                              hintStyle: Font.style(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                              hintText: ieDate == null ? format.format(value.ieDate) : format.format(ieDate!),
                                            ),
                                            initialValue: ieDate == null ? value.ieDate : ieDate,
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
                                                                ieDate = date;
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
                                              return ieDate;
                                            },
                                          ),
                                        ],
                                      ),
                                      InformationTile(controller: infoController, isEditing: isEditing, title: "Informant / Reliability", content: value.informant, shrink: false),
                                      InformationTile(controller: diagnosisController, isEditing: isEditing, title: "Diagnosis", content: value.diagnosis, shrink: false),
                                      InformationTile(controller: complaintController, isEditing: isEditing, title: "Chief Complaint", content: value.complaint, shrink: false),
                                      InformationTile(controller: goalController, isEditing: isEditing, title: "Caregiver/Relatives Goal", content: value.caregiverGoal, shrink: false),
                                      InformationTile(controller: illnessController, isEditing: isEditing, title: "History Of Present Illness:", content: value.illnessHistory, shrink: false),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: MQuery.height(0.025, context),
                                        ),
                                        child: DefaultTile(
                                          callback: (){
                                            Get.to(() => EditablesPage(
                                              uid: widget.userModelSimplified.uid,
                                              source: medsHistory,
                                              type: "Medications History Editor"
                                            ), transition: Transition.cupertino);
                                          },
                                          title: "Medications History Editor",
                                          width: double.infinity
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: MQuery.height(0.025, context),
                                        ),
                                        child: DefaultTile(
                                          callback: (){
                                            Get.to(() => EditablesPage(
                                              uid: widget.userModelSimplified.uid,
                                              source: ancilaryProcedures,
                                              type: "Ancilary Procedures Editor"
                                            ), transition: Transition.cupertino);
                                          },
                                          title: "Ancilary Procedures Editor",
                                          width: double.infinity
                                        ),
                                      ),
                                      SizedBox(height: MQuery.height(0.01, context)),
                                      InformationTile(controller: medicalController, isEditing: isEditing,  title: "Past Medical History:", content: value.pastMedicalHistory, shrink: false),
                                      InformationTile(controller: historyController, isEditing: isEditing,  title: "Past Family History:", content: value.familyHistory, shrink: false),
                                      InformationTile(controller: socialController, isEditing: isEditing,  title: "Personal, Social, and Environmental History:", content: value.environmentalHistory, shrink: false),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: MQuery.height(0.525, context),
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                      InformationTile(controller: nameController, isEditing: isEditing, title: "Name", content: value.name, shrink: true),
                                      InformationTile(controller: civilController, isEditing: isEditing, title: "Civil status", content: value.civilStatus, shrink: true),
                                      InformationTile(controller: ageController, isEditing: isEditing, title: "Age", content: value.age.toString(), shrink: true),
                                      InformationTile(controller: sexController, isEditing: isEditing, title: "Sex", content: value.sex, shrink: true),
                                      InformationTile(controller: addressController, isEditing: isEditing, title: "Address", content: value.address, shrink: true),
                                      InformationTile(controller: occupationController, isEditing: isEditing, title: "Occupation", content: value.occupation, shrink: true),
                                      InformationTile(controller: religionController, isEditing: isEditing, title: "Religion", content: value.religion, shrink: true),
                                      InformationTile(controller: nationalityController, isEditing: isEditing, title: "Nationality", content: value.nationality, shrink: true),
                                      InformationTile(controller: handednessController, isEditing: isEditing, title: "Handedness", content: value.handedness, shrink: true),
                                      InformationTile(controller: typeController, isEditing: isEditing, title: "Type of Patient", content: value.type, shrink: true),
                                      Font.out(
                                        "Date of Admission",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.start
                                      ),
                                      SizedBox(height: MQuery.height(0.01, context)),
                                      DateTimeField(
                                        resetIcon: Icon(CupertinoIcons.clear),
                                        style: Font.style(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: MQuery.height(0.025, context),
                                            horizontal: MQuery.height(0.02, context)
                                          ),
                                          fillColor: Palette.formColor,
                                          focusColor: Palette.formColor,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.secondaryBorder.withOpacity(0), width: 0
                                            )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.secondaryBorder.withOpacity(0), width: 0
                                            )
                                          ),
                                          filled: true,
                                          hintStyle: Font.style(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                          hintText: admissionDate == null ? format.format(value.admissionDate) : format.format(admissionDate!),
                                        ),
                                        initialValue: admissionDate == null ? value.admissionDate: admissionDate,
                                        format: format,
                                        onShowPicker: (context, currentValue) async {
                                          
                                        },
                                      ),
                                      SizedBox(height: MQuery.height(0.015, context)),
                                      Font.out(
                                        "Date of IE",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.start
                                      ),
                                      SizedBox(height: MQuery.height(0.01, context)),
                                      DateTimeField(
                                        resetIcon: Icon(CupertinoIcons.clear),
                                        style: Font.style(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: MQuery.height(0.025, context),
                                            horizontal: MQuery.height(0.02, context)
                                          ),
                                          fillColor: Palette.formColor,
                                          focusColor: Palette.formColor,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.secondaryBorder.withOpacity(0), width: 0
                                            )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.secondaryBorder.withOpacity(0), width: 0
                                            )
                                          ),
                                          filled: true,
                                          hintStyle: Font.style(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                          hintText: ieDate == null ? format.format(value.ieDate) : format.format(ieDate!),
                                        ),
                                        initialValue: ieDate == null ? value.ieDate : ieDate,
                                        format: format,
                                        onShowPicker: (context, currentValue) async {
                                          
                                        },
                                      ),
                                      SizedBox(height: MQuery.height(0.015, context)),
                                      InformationTile(controller: infoController, isEditing: isEditing, title: "Informant / Reliability", content: value.informant, shrink: false),
                                      InformationTile(controller: diagnosisController, isEditing: isEditing, title: "Diagnosis", content: value.diagnosis, shrink: false),
                                      InformationTile(controller: complaintController, isEditing: isEditing, title: "Chief Complaint", content: value.complaint, shrink: false),
                                      InformationTile(controller: goalController, isEditing: isEditing, title: "Caregiver/Relatives Goal", content: value.caregiverGoal, shrink: false),
                                      InformationTile(controller: illnessController, isEditing: isEditing, title: "History Of Present Illness:", content: value.illnessHistory, shrink: false),
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
                                    InformationTile(controller: medicalController, isEditing: isEditing,  title: "Past Medical History:", content: value.pastMedicalHistory, shrink: false),
                                    InformationTile(controller: historyController, isEditing: isEditing,  title: "Past Family History:", content: value.familyHistory, shrink: false),
                                    InformationTile(controller: socialController, isEditing: isEditing,  title: "Personal, Social, and Environmental History:", content: value.environmentalHistory, shrink: false),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                        loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                        error: (_,__){
                          watch(userProvider).setUserGeneralInfo(
                            UserModel(
                              environmentalHistory: socialController.text,
                              ancilaryProcedure: [],
                              medicationHistory: [],
                              handedness: handednessController.text,
                              nationality: nationalityController.text,
                              religion: religionController.text,
                              adminHandler: "",
                              name: widget.userModelSimplified.name,
                              civilStatus: civilController.text,
                              ieDate: ieDate ?? DateTime.now(),
                              admissionDate: admissionDate ?? DateTime.now(),
                              caregiverGoal: goalController.text,
                              familyHistory: historyController.text,
                              complaint: complaintController.text,
                              age: 0,
                              informant: infoController.text,
                              illnessHistory: illnessController.text,
                              diagnosis: diagnosisController.text,
                              sex: sexController.text,
                              occupation: occupationController.text,
                              type: typeController.text,
                              pastMedicalHistory: medicalController.text,
                              photoURL: "",
                              address: addressController.text
                            ),
                            widget.userModelSimplified.uid
                          );
                          return SizedBox();
                        },
                      )      
                    ),
                  )
                ],
              ),
            ),
          )
        );
      }
    );
  }
}