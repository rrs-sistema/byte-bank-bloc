import 'package:flutter/material.dart';

import '../../components/components.dart';

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
