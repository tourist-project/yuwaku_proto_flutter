class FormattedDateManager {
  // yyyy-MM-dd
  String stringSlashedFormatDate(DateTime date) {
    var dateString = "${date.year}-${date.month}-${date.day}";
    return dateString;
  }
}