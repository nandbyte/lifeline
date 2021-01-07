// TODO: Delete this model after making the real mdodel
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
}
