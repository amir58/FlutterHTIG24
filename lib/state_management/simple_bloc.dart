// State Management
// BLoc, GetX, Provider, River-pod

// Architecture Patterns => MVC, MVP, MVVM, MVI
// MVC  => Model, View, Controller
// MVP  => Model, View, Presenter
// MVVM => Model, View, ViewModel
// MVI  => Model, View, Intent

// Model ( Entity ) => Class of data
// View ( Pages , Widgets ) => UI
// ViewModel => Logic ( Actions, DB, Firebase, APIs )

// Bloc => MVVM
// GetX, Provider => MVC

// Bloc vs Cubit

// Model     => none
// View (UI) => CounterPage
// ViewModel => CounterCubit
// Bloc Widgets
// BlocProvider => create object from cubit
// BlocBuilder  => Refresh ui
// BlocListener => Listen for states
// BlocConsumer => BlocBuilder + BlocListener

import 'package:flutter/material.dart';
import 'package:flutter24/state_management/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(),
      ),
    );
  }
}
