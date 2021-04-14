import 'package:injectable/injectable.dart';

import 'package:steps_tracker/app/router/router.dart';

@lazySingleton
class RouterService {
  final StepsTrackerRouter router = StepsTrackerRouter();
}
