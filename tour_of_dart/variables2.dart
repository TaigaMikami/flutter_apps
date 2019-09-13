main() {
  int lineCount;
  assert(lineCount == null);

//  final name = 'bob';
//  name = 'Aluce';

  var foo = const [];
  final bar = const [];
  const baz = [];

  foo = [1,2,3];
  print(foo);

//  String > int
  var one = int.parse('1');
  assert(one == 1);

  var onePointOne = double.parse('1.1');
  assert(onePointOne == 1.1);

  var oneAsString = 1.toString();
  assert(oneAsString == '1');

  String piAsString = 3.14159.toStringAsFixed(2);
  assert(piAsString == '3.14');

  assert((3 << 1) == 6); // 0011 << 1 == 0110
  assert((3 >> 1) == 1); // 0011 >> 1 == 0001
  assert((3 | 4) == 7); // 0011 | 0100 == 0111

  var s = 'hoge';
  assert('fugo $s' == 'fugo ' + 'hoge');
  assert('fugo ${s.toUpperCase()}' == 'fugo ' + 'HOGE');

  var s1 = '''
  hoge
  fugo
  ''';
  print(s1);

  var fullName = '';
  assert(fullName.isEmpty);

  var hitPoints = 0;
  assert(hitPoints <= 0);

}
