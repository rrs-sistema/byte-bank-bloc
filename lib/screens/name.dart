import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NameCubit extends Cubit<String> {
  NameCubit(String name) : super(name);

  void change(String name) => emit(name);
}

class NameContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contextBloc) => NameCubit('Rivaldo R.'),
      child: NameView(),
    );
  }
}

class NameView extends StatefulWidget {

  @override
  State<NameView> createState() => _NameViewState();
}

class _NameViewState extends State<NameView> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = context.read<NameCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change name'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Desired name',
            ),
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  final name = _nameController.text;
                  context.read<NameCubit>().change(name);
                  Navigator.of(context).pop();
                }, 
                child: Text('Change')
              ),
            ),
          ),
        ],
      ),
    );
  }
}