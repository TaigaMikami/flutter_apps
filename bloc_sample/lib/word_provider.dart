import 'package:bloc_sample/word_bloc.dart';
import 'package:flutter/cupertino.dart';

class WordProvider extends InheritedWidget {
  final WordBloc wordBloc;

  WordProvider({
    Key key,
    WordBloc wordBloc,
    Widget child,
  })
    : wordBloc = wordBloc ?? WordBloc(),
      super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static WordBloc of(BuildContext context) =>
    (context.inheritFromWidgetOfExactType(WordProvider) as WordProvider).wordBloc;
}
