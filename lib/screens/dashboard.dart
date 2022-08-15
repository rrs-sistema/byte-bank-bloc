import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';
import '../screens/screens.dart';
import '../models/models.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Rivaldo R."),
      child: I18NLoadingContainer((messages) => DashboardView(DashboardViewLazyI18n(messages))),
    );
  }
}

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18n _i18n;
  
  DashboardView(this._i18n);

  @override
  Widget build(BuildContext context) {
    //final i18n = DashboardViewLazyI18n(_messages);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome $state'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            child: Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _FeatureItem(
                    _i18n.transfer,
                    Icons.monetization_on,
                    onClick: () => _showContactsList(context),
                  ),
                  _FeatureItem(
                    _i18n.transactionFeed,
                    Icons.description,
                    onClick: () => _showTransactionsList(context),
                  ),
                  _FeatureItem(
                    _i18n.changeName,
                    Icons.person_outline,
                    onClick: () => _showChangeName(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext blocContext) {
    push(blocContext, ContactsListContainer());
  }

  void _showChangeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(blocContext),
          child: NameContainer(),
        ),
      ),
    );
  }

  _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
}

class DashboardViewLazyI18n {
  final I18NMessages _messages;

  DashboardViewLazyI18n(this._messages);

  String get transactionFeed => _messages.get('transactionFeed');
  String get changeName => _messages.get('changeName');
  String get transfer => _messages.get('transfer');

}

class DashboardViewI18n extends ViewI18n {
  DashboardViewI18n(BuildContext context) : super(context);

  String transactionFeed() {
    return localize({
      'pt-br': 'Transações', 
      'en': 'Transaction Feed'
    });     
  }

  String changeName() {
    return localize({
      'pt-br': 'Mundar o nome', 
      'en': 'Change name'
    });    
  }

  String transfer() {
    return localize({
      'pt-br': 'Transferir', 
      'en': 'Transfer'
    });
  }

}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(
    this.name,
    this.icon, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
