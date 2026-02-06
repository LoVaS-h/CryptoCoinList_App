import 'package:flutter/foundation.dart';

import '../features/crypto_coin/crypto_coin.dart';
import '../features/crypto_list/crypto_list.dart';

// final routes = {
//   '/' : (context) => CryptoValueList(), // дефолтный роут для flutter (вместо home)
//   '/coin' : (context) => CryptoCoinScreen()
// };

import 'package:auto_route/auto_route.dart';

import '../repositories/crypto_coins/crypto_coins.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CryptoListRoute.page, path: '/'), //дефолтный роут
    AutoRoute(page: CryptoCoinRoute.page)
  ];
}