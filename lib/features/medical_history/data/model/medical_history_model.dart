class HistoryModel {
  List<dynamic> getLocationObjectsFromJson(dynamic j) {
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
