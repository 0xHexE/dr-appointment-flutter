import 'package:redurx/redurx.dart';

class AppState {
  AppState(this.role);
  final String role;

  @override
  String toString() => role.toString();
}

class SetRole extends Action<AppState> {
  SetRole([this.role]);

  final String role;

  AppState reduce(AppState state) => AppState(role);
}
