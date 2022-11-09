import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumer_test/routes/app_routes.dart';
import 'package:sumer_test/screens/home/home.dart';
import 'package:sumer_test/settings/bloc_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: blocs,
      child: MaterialApp(
        title: 'Sumer Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 94, 105, 109)),
        ),
        routes: routes,
        initialRoute: HomeUI.path,
      ),
    );
  }
}
