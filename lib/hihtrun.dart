import 'dart:math' as math;

// ignore: camel_case_types
class hihtOutrun {
  final explainList = ['apple', 'banana', 'watermelon', 'storbary', 'orange'];
  var textprite = 'test';
  bool hihtprint = true;

  hihtOutrun() {
    var random = math.Random();
    var randomnum = random.nextInt(5);
    print(random);
    textprite = explainList[randomnum];
  }
}
