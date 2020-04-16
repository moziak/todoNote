import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<Counter, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(
    Counter event,
  ) async* {

    
    switch (event) {
      case Counter.INCREEMENT:
        yield state + 1;
        break;
      case Counter.DECREEMENT:
        yield state -1;
        break;
    }
  
  }
}
