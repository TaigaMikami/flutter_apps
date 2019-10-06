import 'dart:async';
import 'dart:math' show Random;

void main() {
  final calc = MentalCalc(6);
  Output(calc);

  final timer = Timer.periodic(Duration(seconds: 1), (Timer t){
    calc.add(t.tick);
  });

  calc.onStop.listen((_) {
    timer.cancel();
  });
}

class Output {
  Output(MentalCalc calc) {
    calc.onAdd.listen((value) {
      print(value);
    });
  }
}

class MentalCalc {
  final _calcController = StreamController<int>();
  final _outputController = StreamController<String>();
  final _stopController = StreamController<void>();

  Function(int) get add => _calcController.sink.add;

  Stream<String> get onAdd => _outputController.stream;
  Stream<void> get onStop => _stopController.stream;

  int _sum = 0;

  MentalCalc(int repeat) {
    _calcController.stream.listen((count) {
      if (count < repeat + 1) {
        var num = Random().nextInt(99) + 1;
        _outputController.sink.add('$num');
        _sum += num;
      } else {
        _outputController.sink.add('答え$_sum');
        _stopController.sink.add(null);
      }
    });
  }

  void dispose() {
    _calcController.close();
    _outputController.close();
    _stopController.close();
  }
}
