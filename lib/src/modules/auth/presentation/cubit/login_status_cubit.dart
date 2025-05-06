import 'package:flutter_bloc/flutter_bloc.dart';

class LoginStatusCubit extends Cubit<bool> {
  LoginStatusCubit() : super(false);

  void setLoginStatus(bool status) => emit(status);
}
