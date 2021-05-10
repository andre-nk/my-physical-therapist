part of "../../view.dart";

class EditablesPage extends StatefulWidget {

  final String type;
  final String uid;
  final List source;

  EditablesPage({required this.uid, required this.type, required this.source});

  @override
  _EditablesPageState createState() => _EditablesPageState();
}

class _EditablesPageState extends State<EditablesPage> {
  
  final _editableKey = GlobalKey<EditableState>();

  List rows = [];
  List cols = [];
  List out = [];

  @override
  Widget build(BuildContext context) {
    if(rows.length < 1){
      if(widget.type == "Medications History Editor"){
        widget.source.forEach((element) {
          rows.add({
            "medications": element.medications,
            "dosage": element.dosage,
            "indications": element.indications,
            "sideEffects": element.sideEffects
          });
        });

        cols = [
          {"title": 'Medications', 'widthFactor': 0.4, 'key': 'medications'},
          {"title": 'Dosage', 'widthFactor': 0.4, 'key': 'dosage'},
          {"title": 'Indications', 'widthFactor': 0.4, 'key': 'indications'},
          {"title": 'Side Effects', 'widthFactor': 0.4, 'key': 'sideEffects'},
        ];
      } else if (widget.type == "Ancilary Procedures Editor"){
        widget.source.forEach((element) {
          rows.add({
            "ancilaryProcedure": element.ancilaryProcedure,
            "date": element.date,
            "findings": element.findings,
          });
        });

        cols = [
          {"title": 'Ancilary Procedure', 'widthFactor': 0.8, 'key': 'ancilaryProcedure'},
          {"title": 'Date', 'widthFactor': 0.4, 'key': 'date'},
          {"title": 'Findings', 'widthFactor': 0.4, 'key': 'findings'},
        ];
      }
    }

    print(rows);

    return Consumer(
      builder: (context, watch, _){

        final userServiceProvider = watch(userProvider);

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Palette.primary,
            onPressed: (){
              if(widget.type == "Medications History Editor"){
                userServiceProvider.updateUserMedicationHistory(rows, widget.uid);
              } else if (widget.type == "Ancilary Procedures Editor"){
                userServiceProvider.updateUserAncilaryProcedures(rows, widget.uid);
              }
            },
            child: Icon(CupertinoIcons.checkmark_alt)
          ),
          appBar: AppBar(
            backgroundColor: Palette.primary,
            toolbarHeight: MQuery.height(0.08, context),
            leading: IconButton(
              icon: Icon(CupertinoIcons.chevron_left, color: Colors.white),
              onPressed: (){
                Get.back();
              },
            ),
            title: Font.out(widget.type, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          body: Editable(
            key: _editableKey,
            columns: cols,
            rows: rows,
            zebraStripe: false,
            onRowSaved: (value) {
              rows.removeLast();
              rows.add(value);
              setState((){});
            },
            onSubmitted: (value) {
              print(value);
            },
            borderColor: Colors.blueGrey,
            tdStyle: Font.style(fontSize: 16, fontWeight: FontWeight.w600),
            trHeight: 60,
            columnRatio: 0.3,
            thStyle: Font.style(fontSize: 18, fontWeight: FontWeight.bold),
            thAlignment: TextAlign.center,
            thVertAlignment: CrossAxisAlignment.end,
            thPaddingBottom: 3,
            showSaveIcon: true,
            saveIconColor: Colors.black,
            showCreateButton: true,
            tdAlignment: TextAlign.left,
            tdEditableMaxLines: 100, // don't limit and allow data to wrap
            tdPaddingTop: 0,
            tdPaddingBottom: 14,
            tdPaddingLeft: 10,
            tdPaddingRight: 8,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.primary),
              borderRadius: BorderRadius.all(Radius.circular(0))
            ),
          ),
        );
      }
    );
  }
}