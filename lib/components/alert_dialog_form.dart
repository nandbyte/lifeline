import 'package:flutter/material.dart';
import 'package:lifeline/components/custom_dropdown_menu.dart';
import 'package:lifeline/components/custom_text_field.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:lifeline/services/EHR.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AlertDialogForm extends StatefulWidget {
  final BuildContext context;

  AlertDialogForm({
    @required this.context,
  });

  @override
  _AlertDialogFormState createState() => _AlertDialogFormState();
}

class _AlertDialogFormState extends State<AlertDialogForm> {
  bool loadingIndicator = false;
  bool active = true;
  String type = '';
  TextEditingController problemController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  final ehrDatabase = new EHR(uid: Auth().getUID());

  Future<void> _submit() async {
    final _date = dateController.text;
    final _type = type;
    final _problem = problemController.text;
    final _verified = false;
    final _verifiedBy = "";

    Diagnosis _diagnosis = new Diagnosis(
      date: _date,
      problem: _problem,
      type: _type,
      verified: _verified,
      verifiedBy: _verifiedBy,
    );
    await ehrDatabase.createDiagnosis(_diagnosis);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      opacity: 0.9,
      progressIndicator: kWaveLoadingIndicator,
      inAsyncCall: loadingIndicator,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(6),
        title: Text(
          'New Diagnosis',
          style: kTextStyle.copyWith(
            fontSize: 24,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomDropdownMenu(
                label: 'Type',
                items: [
                  'Disease',
                  'Accident',
                ],
                onChanged: (value) {
                  setState(() {
                    type = value;
                  });
                },
              ),
              CustomTextField(
                label: 'Description',
                hint: 'Diagnosed problem',
                controller: problemController,
                keyboardType: TextInputType.text,
              ),
              CustomTextField(
                label: 'Date',
                hint: 'MM, YYYY',
                controller: dateController,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () async {
              active = false;
              FocusScope.of(context).unfocus();
              print("Before");
              setState(() {
                loadingIndicator = true;
              });
              await _submit();
              setState(() {
                loadingIndicator = false;
              });
              print("After");
              setState(() {});
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Submit',
              style: kTextStyle.copyWith(color: Colors.green, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
