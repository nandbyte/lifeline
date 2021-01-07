import 'package:flutter/material.dart';
import 'package:lifeline/components/custom_dropdown_menu.dart';
import 'package:lifeline/components/custom_text_field.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:lifeline/services/EHR.dart';
import 'package:lifeline/services/authenticate.dart';

class AlertDialogForm extends StatefulWidget {
  final BuildContext context;

  AlertDialogForm({
    @required this.context,
  });

  @override
  _AlertDialogFormState createState() => _AlertDialogFormState();
}

class _AlertDialogFormState extends State<AlertDialogForm> {
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
    return AlertDialog(
      contentPadding: EdgeInsets.all(6),
      title: Text(
        'New Diagnosis',
        style: kTextStyle.copyWith(
          fontSize: 24,
        ),
      ),
      content: Column(
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
            onChanged: (value){
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
      actions: [
        FlatButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            // TODO: Submit new diagnosis data to the database
            print("Before");
            await _submit();
            print("After");
            setState(() {
              
            });
            Navigator.pop(context);
          },
          child: Text(
            'Submit',
            style: kTextStyle.copyWith(color: Colors.green, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
