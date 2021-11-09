class HistoryModel {
  List<dynamic> getLocationObjectsFromJson(dynamic j) {
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
