import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';

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