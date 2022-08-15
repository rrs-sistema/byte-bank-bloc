import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../http/http.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;

  LocalizationContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (context) => CurrentLocaleCubit(),
      child: this.child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super('pt-br');
}

class ViewI18n {
  String _language;
  ViewI18n(BuildContext context) {
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }
  String localize(Map<String, dynamic> values) {
    assert(values != null);
    assert(values.containsKey(_language));
    return values[_language];
  }
}

@immutable
abstract class I18NMessagesState {
  const I18NMessagesState();
}

@immutable
class LoadingI18NMessagesState extends I18NMessagesState {
  const LoadingI18NMessagesState();
}

@immutable
class InitI18NMessagesState extends I18NMessagesState {
  const InitI18NMessagesState();
}

@immutable
class LoadedI18NMessagesState extends I18NMessagesState {
  final I18NMessages _messages;

  const LoadedI18NMessagesState(this._messages);
}

class I18NMessages {
  final Map<String, dynamic> _messages;
  I18NMessages(this._messages);

  String get(String key) {
    assert(key != null);
    assert(_messages.containsKey(key));
    return _messages[key];
  }
}

@immutable
class FatalErrorI18NMessagesState extends I18NMessagesState {
  const FatalErrorI18NMessagesState();
}

typedef Widget I18NWidgetCreator(I18NMessages messages);

class I18NLoadingContainer extends BlocContainer {
  final I18NWidgetCreator _creator;

  I18NLoadingContainer(this._creator);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18NMessagesCubit>(
      create: (BuildContext context) {
        final cubit = I18NMessagesCubit();
        cubit.reload(I18NWebClient());
        return cubit;
      },
      child: I18NLoadingView(this._creator),
    );
  }

}

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
          final messages = state._messages;
          return _creator.call(messages);
        }        
        return ErrorView('Erro buscando mensagens da tela');
      }
    );
  }
}

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  I18NMessagesCubit() : super(InitI18NMessagesState());

  reload(I18NWebClient client) {
    client.findAll().then((messages) => 
      emit(LoadedI18NMessagesState(I18NMessages(messages)),
    ));
    /*
    emit(LoadedI18NMessagesState(I18NMessages({
      'transactionFeed': 'TRANSACTION_FEED',
      'changeName': 'CHANGE_NAME',
      'transfer': 'TRANSFER',
    })));
    */
  }
}
