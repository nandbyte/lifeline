// TODO: Delete this model after making the real mdodel
import 'package:lifeline/screens/donor_list_tab.dart';

class Diagnosis {
  String type;
  String problem;
  String date;
  String verifiedBy;
  bool verified = false;

  Diagnosis({
    this.type,
    this.problem,
    this.date,
    this.verified, // For testing
    this.verifiedBy, // For testing
  }) {
    verified = verified ?? false;
  }
  Map<String, dynamic> toMap() {
    return {
      'Type': this.type,
      'Problem': this.problem,
      'Date': this.date,
      'Verified': this.verified,
      'VerifiedBy': this.verifiedBy,
    };
  }
}
