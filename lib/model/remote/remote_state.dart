import 'dart:developer';

import 'package:get/get.dart';
import 'package:occasion_app/model/remote/api_data.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/utilities/functions/api_function.dart';
class RemoteState {
  static final RemoteState _rst =RemoteState.internal();
  factory RemoteState(){
    return _rst;
  }
  RemoteState.internal();
  int getID(List<CommonApi> names,String name){
   final nameId = names.indexWhere((el) => el.name==name);
   final id=nameId < 0 ? 0 : names[nameId].id;
  return id!;
  }
  int getPrice(int periodID,int prID){
   final nameId = priceState.indexWhere((el) => el.periodID==periodID && el.serviceID==prID);
   log("The ID:: $nameId");
   final id=nameId < 0 ? 0 : priceState[nameId].price;
  return id!;
  }
  List<String> getNames(List<CommonApi> names){
   final name = names.map((el) => el.name!).toList();
    return name;
 }
  final serviceState = <Service>[].obs;
  final servicesState = <Services>[].obs;
  final userState = <User>[].obs;
  final reserveState = <Reserve>[].obs;
  final givserState = <GivserService>[].obs;
  final priceState = <Price>[].obs;
  final periodState = <Period>[].obs;
  final photoState = <Photo>[].obs;
  // final photoState2 = <Photo2>[].obs;
  final isLoading = false.obs;
  final api = ApiData(Get.find<Crud>());
}