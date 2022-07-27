class FormattedDateManager {
  // yyyy-MM-dd
  String stringSlashedFormatDate() {
    var uploadDate = DateTime.now();
    var dateString = "${uploadDate.year}-${uploadDate.month}-${uploadDate.day}";
    return dateString;
  }
}