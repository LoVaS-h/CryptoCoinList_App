import 'dart:async';
import 'package:auto_route/annotations.dart';
import 'package:crpt_app_0/features/crypto_list/view/bloc/crypto_list_bloc.dart';
import 'package:crpt_app_0/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'widgets/widgets.dart';

@RoutePage() //нужен, чтобы этот экран  был виден для auto_route

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    super.initState();
    _cryptoListBloc.add(LoadCryptoList(null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Crypto Value List', style: TextStyle(
          color: Color.fromARGB(255, 255, 249, 131),
        ),)),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TalkerScreen( //экран толкера с логами
                  talker: GetIt.I<Talker>())));
            },    
            icon: Icon(Icons.document_scanner_outlined))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc,CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context,state){
            if (state is CryptoListLoaded){ //если CryptoListLoaded созадлся, то все запустится
                return ListView.separated(
                padding: EdgeInsets.only(top: 16),
                itemCount: state.coinsList.length, //state - обращение к state (в случае моего блока - CryptoListLoaded)
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, i){
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(coin: coin);
                }
              );
            }
            if(state is CryptoListFailure){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('!Something went wrong!', style: TextStyle(color: Colors.white)),
                    Text('Please try again later', style: Theme.of(context).textTheme.labelSmall),
                    SizedBox(height: 30,),
                    TextButton(onPressed: (){
                      _cryptoListBloc.add(LoadCryptoList(null));
                    }, child: Text('Try again', style: TextStyle(color: Color.fromARGB(255, 255, 249, 131)),))
              ],));
            }
            return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 255, 249, 131),));
          },
        ),
      ),
      
      //без блока
      
      //  (_cryptoCoinsList == null) ? const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 255, 249, 131),)) : //проверка. Если список = null, то загрузка иначе ListView
      
      // ListView.separated(
      //   padding: EdgeInsets.only(top: 16),
      //   itemCount: _cryptoCoinsList!.length,
      //   separatorBuilder: (context, index) => Divider(),
      //   itemBuilder: (context, i){
      //     final coin = _cryptoCoinsList![i];
      //     return CryptoCoinTile(coin: coin);
      //   }
      // ),
    );
  }
}