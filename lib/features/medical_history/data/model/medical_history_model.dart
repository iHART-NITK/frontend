class HistoryModel {
  List<dynamic> get_medical_objects_from_json(dynamic j) {
    print(j);
    print(j.runtimeType);
    List<dynamic> medical = [];
    j.forEach((history) {
      medical.add({
        "category": history["category"],
        "description": history["description"]
      });
    });

    return medical;
  }
}
