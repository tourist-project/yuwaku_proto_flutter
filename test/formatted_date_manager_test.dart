import 'package:test/test.dart';
import 'package:yuwaku_proto/formatted_date_manager.dart';

void main() {
  final formattedDateManager = FormattedDateManager();
  test('yyyy-MM-ddの形式でString型の日付が表示されるか', () {
    DateTime date22102 = DateTime(2020, 10, 2);
    final stringDate22102 = formattedDateManager.stringSlashedFormatDate(date22102);
    expect(stringDate22102, '2020-10-2');
  });

  test('UTCでDateTimeを渡した時、想定したyyyy-MM-ddの形式でString型の日付が表示されるか', () {
    DateTime date22102UTC = DateTime(2020, 10, 2).toUtc();
    final stringDate22102UTC = formattedDateManager.stringSlashedFormatDate(date22102UTC);
    expect(stringDate22102UTC, '2020-10-1');

    DateTime date22102150UTC = DateTime(2022, 10, 2, 15, 0).toUtc();
    DateTime date22102150UTCAdd9hour = date22102150UTC.add(Duration(hours: 9));
    final stringDate22102150UTC = formattedDateManager.stringSlashedFormatDate(date22102150UTCAdd9hour);
    expect(stringDate22102150UTC, '2022-10-2');
  });
}