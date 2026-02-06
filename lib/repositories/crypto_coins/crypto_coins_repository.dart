import 'dart:math';

import 'package:crpt_app_0/repositories/models/crypto_coin_details.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'crypto_coins.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository{

final Dio dio;

final Box<CryptoCoin> cryptoCoinsBox;

  CryptoCoinsRepository({
  required this.dio,
  required this.cryptoCoinsBox});

  @override
  Future<List<CryptoCoin>> getCoinsList() async{
    var cryptoCoinsList = <CryptoCoin>[];
    //проверка на ошибку. Если ошибки нет (данные нормально поступают) - мы собираем данные в Box. Если данные прекратиили поступать - возвращаем последние засунутые данные в Box
    try{
    cryptoCoinsList = await _fetchCoinsListFromAPI();

    final cryptoCoinsMap = {for(var e in cryptoCoinsList) e.name: e};
    cryptoCoinsBox.putAll(cryptoCoinsMap);

    } catch(e,st){
      GetIt.instance<Talker>().handle(e,st); //обрабатываем ошибку, просто чтобы знать, что за ошибка
       cryptoCoinsList = cryptoCoinsBox.values.toList(); //вызов сохраненных значений в Box
    }

    cryptoCoinsList.sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD),);
    return cryptoCoinsList;
  }



  Future<List<CryptoCoin>> _fetchCoinsListFromAPI() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,USDC,DOGE,SOL,XRP,PAXG,USDT,XAUT&tsyms=USD'
    );
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e){
      final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
    
      final details = CryptoCoinDetails.fromJson(usdData);
    
      return CryptoCoin(
        name: e.key,
        details: details
        );}).toList();
    return cryptoCoinsList;
  }
}