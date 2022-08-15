import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// Exemplo de contator utilizando Bloc em duas variações
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);

}

class CounterContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        // Abordagem 2 de como acessar o bloc
        child: BlocBuilder<CounterCubit, int>(builder: (context, state) {
          return Text('$state', style: textTheme.headline2);
        },)
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            // Abordagem 1 de como acessar o bloc
            onPressed: () => context.read<CounterCubit>().increment()
          ),
          SizedBox(height: 15,),
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: const Icon(Icons.remove),
            // Abordagem 1 de como acessar o bloc
            onPressed: () => context.read<CounterCubit>().decrement()
          ),          
        ],
      ),
    );
  }
}