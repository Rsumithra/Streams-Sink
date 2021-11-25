import 'dart:async';

enum CounterAction {
  increment,
  decrement,
  reset,
}

class CounterBloc {
  final _stateStremcont = StreamController<int>();
  StreamSink<int> get countersink => _stateStremcont.sink;
  Stream<int> get counterstream => _stateStremcont.stream;

  final _eventstremcont = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventsink => _eventstremcont.sink;
  Stream<CounterAction> get eventstream => _eventstremcont.stream;

  CounterBloc() {
    int counter = 0;
    eventstream.listen((event) {
      if (event == CounterAction.increment) {
        counter++;
      } else if (event == CounterAction.decrement) {
        counter--;
      } else if (event == CounterAction.reset) {
        counter = 0;
      }
      countersink.add(counter);
    });
  }
  void dispose() {
    _stateStremcont.close();
    _eventstremcont.close();
  }
}
