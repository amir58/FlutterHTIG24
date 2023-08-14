import 'package:flutter/material.dart';
import 'package:flutter24/state_management/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late CounterCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<CounterCubit>();
    // cubit = BlocProvider.of<CounterCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, count) {
          print('BlocBuilder');
          return Center(
            child: Text(
              '$count',
              style: TextStyle(fontSize: 22.sp),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Text("0"),
            onPressed: () => cubit.reset(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => BlocProvider.of<CounterCubit>(context).decrement(),
          ),
        ],
      ),
    );
  }
}
