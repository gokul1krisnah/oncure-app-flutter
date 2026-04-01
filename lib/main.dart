import 'package:flutter/material.dart';
import 'package:plan_my_onco/core/routes/app_router.dart';
import 'package:plan_my_onco/core/routes/injection/injection.dart';
import 'package:plan_my_onco/shared/fluid/fluid_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Manrope',
      ),
      builder: (context, child) {
        Fluid.init(context);
        return child!;
      },
    );
  }
}

