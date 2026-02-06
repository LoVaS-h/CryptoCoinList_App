import 'package:auto_route/annotations.dart';
import 'package:crpt_app_0/repositories/models/models.dart';
import 'package:flutter/material.dart';
import 'Widgets/widgets.dart';

@RoutePage() //нужен, чтобы этот экран  был виден для auto_route

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({
    super.key,
    required this.coin
  });

  final CryptoCoin coin;

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState(coin: coin);
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {

  final CryptoCoin coin;

  _CryptoCoinScreenState({required this.coin});
  //то что прописываем без автороутинга
  // Map? coin;

  // @override
  // void didChangeDependencies() { //передача аргументов при открытии экрана
  //   final args = ModalRoute.of(context)?.settings.arguments; 

  //   assert(args!=null && args is Map, 'You must provide Map args!'); //предупреждение для других разработчиков

  //   coin = args as Map;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70,),
            Image.network(coin.details.fullimageUrl, scale: 1.5,),
            SizedBox(height: 15,),
            Text(coin.name, style:Theme.of(context).textTheme.labelMedium),
            SizedBox(height: 20,),
            priceBlock(priceInUSD: coin.details.finalPriceInUSD),
            SizedBox(height: 30,),
            HighLowhoursBlock(finalLow24hours: coin.details.finalLow24hours, finalHigh24hours: coin.details.finalHigh24hours)
            ],
          ),
        )     
      );
    }
}

