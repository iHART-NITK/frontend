class HistoryModel {
  Map<String, String> get_medical_objects_from_json(dynamic j) {
    print(j);
    print(j.runtimeType);
    Map<String, String> medical = new Map();
    j.forEach((key, value) {
      print("${key}: ${value}");
      medical[key] = value;
    });
    print(medical.keys);
    return medical;
  }
}