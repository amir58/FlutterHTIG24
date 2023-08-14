import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  // state = 1

  void increment() {
    // emit(state); == setState((){});
    emit(state + 5);
  }

  void decrement() => emit(state - 5);

  void reset(){
    emit(state - state);
  }
}