class basicRecord {
  String height;
  String weight;
  String rbc;
  String wbc;
  String bp;
  String sugerLevel;
  int count;
  basicRecord({
    this.height,
    this.weight,
    this.rbc,
    this.wbc,
    this.bp,
    this.sugerLevel,
    this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'Height': height,
      'Weight': weight,
      'RBC Count': rbc,
      'WBC Count': wbc,
      'Suger Level': sugerLevel,
      'Blood Pressure': bp,
      'Count': count ?? 0,
    };
  }
}
