import 'package:crpt_app_0/router/router.dart';
import 'package:crpt_app_0/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoApp extends StatefulWidget { //stf - для нашего автороута
  const CryptoApp({super.key});

  @override
  State<CryptoApp> createState() => _CryptoAppState();
}

class _CryptoAppState extends State<CryptoApp> {
  final _appRouter = AppRouter();//AppRouter - для нашего автороута

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router( //.router - для нашего автороута
      title: 'Crypto App',
      theme: darkTheme,
      routerConfig: _appRouter.config(   //routerConfig - для нашего автороута
        navigatorObservers: () => [ //создание лога для переходв между экранами
        TalkerRouteObserver(GetIt.I<Talker>())
        ],
      )





      //способ без автороута

      // routes: routes,
      // navigatorObservers: [ //создание лога для переходв между экранами
      //   TalkerRouteObserver(GetIt.I<Talker>())
      // ],
    );
  }
}