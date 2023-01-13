// ambient variable to access the service locator
import 'package:cpnz/src/repositories/patrol_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<PatrolRepository>(PatrolRepository());
}
