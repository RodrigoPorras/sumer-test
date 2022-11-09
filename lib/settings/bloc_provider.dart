import 'package:sumer_test/data/repository/main/main_repository.dart';
import 'package:sumer_test/screens/home/home.dart';

// ignore: implementation_imports
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:sumer_test/settings/dependency_inyection.dart';

final blocs = <BlocProviderSingleChildWidget>[
  BlocProvider(
    create: (_) => HomeBloc(mainRepository: getIt.get<MainRepository>()),
  ),
];
