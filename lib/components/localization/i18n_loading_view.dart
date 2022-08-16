import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../components/components.dart';

typedef Widget I18NWidgetCreator(I18NMessages messages);

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator _creator;

  I18NLoadingView(this._creator);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if(state is InitI18NMessagesState || state is LoadingI18NMessagesState) {
          return ProgressView(messages: 'Loading messages',);
        }
        if(state is LoadedI18NMessagesState) {
          final messages = state.messages;
          return _creator.call(messages);
        }        
        return ErrorView('Erro buscando mensagens da tela');
      }
    );
  }
}
