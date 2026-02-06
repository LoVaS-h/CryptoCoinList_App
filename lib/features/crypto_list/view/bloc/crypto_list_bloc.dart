import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../repositories/crypto_coins/crypto_coins.dart';
part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
    try{
      if (state is! CryptoListLoaded){
        emit(CryptoListLoading());
      }
      final cryptoCoinsList = await coinsRepository.getCoinsList();
      emit(CryptoListLoaded(coinsList: cryptoCoinsList));
    } catch(e,st){
        emit(CryptoListFailure(exception: e));
        GetIt.I<Talker>().handle(e, st); //лог ошибки
      }
      finally{
        event.completer?.complete();
      };
    }
    );
  }

  final AbstractCoinsRepository coinsRepository;

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}