import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';


import 'core/hive/hive_config.dart';
import 'core/injection/injection.dart';
import 'core/routes/app_router.dart';
import 'shared/fluid/fluid_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveConfig.init();
  await configureInjection();
  runApp(OverlaySupport.global(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: _appRouter.config(),
    theme: ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Manrope'),
    builder: (context, child) {
      Fluid.init(context);
      return child!;
    },
  );
}
