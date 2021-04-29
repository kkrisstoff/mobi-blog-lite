import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/counter_cubit.dart';

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text('$state', style: textTheme.headline2);
          },
        ),
      );
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Counter')),
    //   body: Center(
    //     child: BlocBuilder<CounterCubit, int>(
    //       builder: (context, state) {
    //         return Text('$state', style: textTheme.headline2);
    //       },
    //     ),
    //   ),
    //   floatingActionButton: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     crossAxisAlignment: CrossAxisAlignment.end,
    //     children: <Widget>[
    //       FloatingActionButton(
    //         key: const Key('counterView_increment_floatingActionButton'),
    //         child: Icon(Icons.add),
    //         onPressed: () => context.bloc<CounterCubit>().increment(),
    //       ),
    //       const SizedBox(height: 8),
    //       FloatingActionButton(
    //         key: const Key('counterView_decrement_floatingActionButton'),
    //         child: Icon(Icons.remove),
    //         onPressed: () => context.bloc<CounterCubit>().decrement(),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class CounterAcrionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('counterView_increment_floatingActionButton'),
            child: Icon(Icons.add),
            onPressed: () => context.bloc<CounterCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('counterView_decrement_floatingActionButton'),
            child: Icon(Icons.remove),
            onPressed: () => context.bloc<CounterCubit>().decrement(),
          ),
        ],
      );
  }
}