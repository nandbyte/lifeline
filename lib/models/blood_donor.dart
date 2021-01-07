class Donor {
  String name;
  String contact;
  String latitute;
  String longitude;
  String location;
  String blood;

  Donor(
      {this.name,
      this.contact,
      this.latitute,
      this.longitude,
      this.location,
      this.blood});
  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Contact No': contact,
      //'Location': location,
      'Latitute': latitute,
      'Longitude': longitude,
      'Location': location,
      'Blood Group': blood,
    };
  }
}
