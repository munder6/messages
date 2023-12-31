import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData.light());

  void setSystemTheme(Brightness brightness) {
    emit(brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light());
  }
}