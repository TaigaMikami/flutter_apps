import 'dart:async';

void main() {
  final data = {'イチゴ' : '苺', 'イチジク' : '無花果' };

  final controller = StreamController<String>();

  controller.sink.add('イチゴ');
  controller.sink.add('ドラゴンフルーツ');
  controller.sink.add('イチジク');

  final toKanji = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (data.containsKey(value)) {
        sink.add(data[value]);
      } else {
        sink.addError('$valueの漢字は不明です');
      }
    }
  );

  controller.stream.transform(toKanji).listen(
      (value) { print(value); },
      onError: (err) { print('[エラー] $err'); }
  );
}
