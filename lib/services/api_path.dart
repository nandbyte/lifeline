class APIPath {
  static String profile(String uid) => '/profile/$uid';
  static String ehr(String uid)=>'/health_record/$uid';
  static String diagnosis(String uid, String id)=>'/health_record/$uid/history/$id';
  
}
