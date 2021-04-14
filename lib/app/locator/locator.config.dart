// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/auth_service.dart' as _i3;
import '../services/firebase_service.dart' as _i4;
import '../services/firestore_service.dart' as _i5;
import '../services/router_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initLocator(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthService>(() => _i3.AuthService());
  gh.lazySingleton<_i4.FirebaseService>(() => _i4.FirebaseService());
  gh.lazySingleton<_i5.FirestoreService>(() => _i5.FirestoreService());
  gh.lazySingleton<_i6.RouterService>(() => _i6.RouterService());
  return get;
}
