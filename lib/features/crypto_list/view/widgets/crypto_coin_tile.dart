import 'package:auto_route/auto_route.dart';
import 'package:crpt_app_0/repositories/models/crypto_coin.dart';
import 'package:crpt_app_0/router/router.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
    trailing: Icon(Icons.arrow_forward_ios, ),
    
    leading: Image.network(coin.details.fullimageUrl, scale: 2,),
    
    title: Text(coin.name,style: Theme.of(context).textTheme.bodyMedium),
    
    subtitle: Text('${coin.details.finalPriceInUSD}\$', style: Theme.of(context).textTheme.labelSmall),
    
    onTap: () {
      //Навигация с автороутом
      AutoRouter.of(context).push(CryptoCoinRoute(coin: coin));//есть еще много возможностей у автороута помимо этого обычного push(посмотреть потом)



      //Навигация без автороута
      //  Navigator.of(context).pushNamed(
      // '/coin',
      // arguments: {
      //   'image': coin.details.fullimageUrl, 
      //   'name': coin.name,
      //   'price': coin.details.finalPriceInUSD,
      //   'high24hours': coin.details.finalHigh24hours,
      //   'low24hours': coin.details.fianlLow24hours,
      //   },//передача аргументов при открытии экрана <3
      //  );
      },
    );
  }
}