import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

final GetIt locator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initLocator',
  usesNullSafety: true,
)
void configureDependencies() => $initLocator(locator);
