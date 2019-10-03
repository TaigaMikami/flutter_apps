import 'dart:async'; // dart:asyncをインポート

// 実行箇所にasyncを宣言
void main() async {
  print(new DateTime.now());
  // new Future.delayed() の前にawaitを書く
  var now = await myfunc();
  print(now);
}

Future <String> myfunc(){

  return new Future.delayed(new Duration(seconds: 10), (){
    return new DateTime.now().toString();
  });
}
