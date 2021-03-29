import 'package:bloc/bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.unloaded) {
    loadSplash();
  }
  Future<void> loadSplash() async {
    emit(SplashState.unloaded);
    await Future.delayed(Duration(seconds: 1));
    emit(SplashState.loaded);
  }
}
