class Donor {
  final String name;
  final String contact;
  final String latitute;
  final String longitude;
  final String location;
  final String blood;

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
