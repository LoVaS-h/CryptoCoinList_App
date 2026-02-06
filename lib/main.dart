import 'dart:async';
import 'package:crpt_app_0/crypto_app.dart';
import 'package:crpt_app_0/firebase_options.dart';
import 'package:crpt_app_0/repositories/models/crypto_coin_details.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'repositories/crypto_coins/crypto_coins.dart';


void main(){
  Future<void> maininitializeApp() async {

  final talker = TalkerFlutter.init(); //нужен для логирования

  GetIt.I.registerSingleton(talker);

  //Hive
  const cryptoCoinBoxName = 'crypto_coins_box';

  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailsAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinBoxName);

  // Инициализация Firebase
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  talker.info(app.options.projectId);

  //Dio
  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ), 
  );

  //Bloc
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );


  //Dio (repository)
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
    () => CryptoCoinsRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox),
  );

  //проверка ошибок
  FlutterError.onError = (details) =>
      GetIt.I<Talker>().handle(details.exception, details.stack);
  }

  runZonedGuarded(() {
  WidgetsFlutterBinding.ensureInitialized();
   maininitializeApp().then((_) {
    runApp(const CryptoApp());
   }).catchError((error, stack) {
    GetIt.I<Talker>().handle(error, stack);
   });


  }, (error, stack) => GetIt.I<Talker>().handle(error, stack));
}