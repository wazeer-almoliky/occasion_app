import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/binding/details_view_binding.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/classes/custom_dialog.dart';
import 'package:occasion_app/utilities/functions/status_request.dart';
import 'package:occasion_app/utilities/services/app_services.dart';
import 'package:occasion_app/view/screens/details_view.dart';

class ServicesController extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  final name = TextEditingController();
  final note = TextEditingController();
  final servicesKey = GlobalKey<FormState>();
  var isUpdate = -1;
  // final periodKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  List<XFile> mediaFileList = [];
  var valueOfDropBox = "";
  var admin = "";
  int? userID, photoID, productID1;
  String? label;
  @override
  void onInit() {
    checkFromUser();
    super.onInit();
    productID1 = Get.arguments["productID"];
    log("ID>>$productID1");
    photoID = Get.arguments["photoID"];
    label = Get.arguments["userlabel"];
    checkFromUser();
    fetchData();
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      userID = storage!.read("userID");
      update();
    }
  }

  void fetchData() async {
    remoteState.serviceState.clear();
    remoteState.givserState.clear();
    remoteState.periodState.clear();
    remoteState.isLoading(true);
    try {
      final response = await Future.wait([
        remoteState.api.respone(
            "${AppLinks.givenService}?op_type=selectwhere&user_id=$userID"),
        remoteState.api.respone("${AppLinks.service}?op_type=select"),
      ]);
      if (admin == "ادمن") {
        if (response[1] != null) {
          remoteState.serviceState
              .addAll(response[1]!.map((e) => Service.fromjson(e)).toList());
          remoteState.serviceState.refresh();
        }
      } else {
        if (response[0] != null) {
          remoteState.givserState.addAll(
              response[0]!.map((e) => GivserService.fromjson(e)).toList());
          remoteState.givserState.refresh();
        }
        log("${remoteState.givserState}");
      }
      final period =await remoteState.api.respone("${AppLinks.period}?op_type=select");
      if(period !=null){
        remoteState.periodState.addAll(period.map((e) => Period.fromjson(e)).toList());
          remoteState.periodState.refresh();
      }
    } finally {
      remoteState.isLoading(false);
    }
  }

  void request() async {
    StatusRequest.loading;
    // log("Admin is $admin ");
    if (servicesKey.currentState!.validate()) {
      if (admin == "ادمن") {
        // log("${name.text}--${note.text}");
        if (mediaFileList.isEmpty) {
          CustomAlertDialog.showSnackBar("لا توجــد  صـورة");
          return;
        }
        await remoteState.api.requestCapture(
            AppLinks.service,
            {
              "op_type": "insert",
              "service_name": name.text,
              "service_note": note.text
            },
            File(mediaFileList[0].path),
            label: "عملية الاضافة",isAlone: true);
      } else {
        int? productID;
        final data = {
          "op_type": "insert",
          "product_name": name.text,
          "product_description": note.text,
          "giver_id": remoteState
              .getID(remoteState.givserState, valueOfDropBox)
              .toString()
        };
        if (mediaFileList.isEmpty) {
          final id = await remoteState.api
              .request(AppLinks.product, data, label: "عملية الاضافة");
          productID = id![0];
        } else {
          final id = await remoteState.api
              .request(AppLinks.product, data, label: "عملية الاضافة");
          productID = id![0];
          await remoteState.api.requestCapture(
              AppLinks.photo,
              {"op_type": "insert", "product_id": "$productID"},
              File(mediaFileList[0].path),
              label: "عملية الاضافة");
        }
      }
    }
    // update();
    clear();
  }
  String? title;
  void periodRequest() async {
    if (servicesKey.currentState!.validate()) {
      if(title ==null){
        await remoteState.api.request(
          AppLinks.period,
          {
            "op_type": "insert",
            "timeperiod_name": name.text,
            "timeperiod_note": note.text
          },
          label: "عملية الاضافة");
      }else{
        await remoteState.api.request(
          AppLinks.period,
          {
            "op_type": "update",
            "timeperiod_name": name.text,
            "timeperiod_note": note.text,
            "timeperiod_id": "$timeID"
          },
          label: "عملية التعديل");
      }
    }
    clear();
  }
int? timeID;
void edit(String selectName,int id){
     name.text=selectName;
     timeID=id;
     title="تعديل";
     update();
  }
  void clear() {
    // name.text = "";
    // note.text = "";
    mediaFileList = [];
    update();
  }

  void deleteData(int id) async {
    if (admin == "ادمن") {
      //delete//service_id
      await remoteState.api.request(
          AppLinks.service,
          {
            "op_type": "delete",
            "service_id": "$id",
          },
          label: "عملية الحذف");
    } else {}
    fetchData();
  }

  TextEditingController listOfController(int index) {
    final controller = [name, note];
    return controller[index];
  }

  Future<void> getImage(ImageSource source) async {
    remoteState.isLoading(true);
    try {
      final pickedFile = await _picker.pickMultiImage();
      List<XFile> xfilePick = pickedFile;
      if (xfilePick.isNotEmpty) {
        for (var i = 0; i < xfilePick.length; i++) {
          mediaFileList.add(xfilePick[i]); //File(xfilePick[i].path)
        }
        update();
      } else {
        log('No image selected.');
      }
    } finally {
      remoteState.isLoading(false);
    }
  }

  void addImage() async {
    if (mediaFileList.isEmpty) {
    } else {
      await remoteState.api.requestCapture(
          AppLinks.photo,
          {"op_type": "update", "product_id": "$productID1"},
          File(mediaFileList[0].path),
          label: "عملية الاضافة");
    }
  }

  void updateRequest() async {
    if (admin == "ادمن") {
      final data = {
        "op_type": "update",
        "service_name": name.text,
        "service_note": note.text,
        "service_id": productID1,
      };
      if (mediaFileList.isEmpty) {
        await remoteState.api
            .request(AppLinks.service, data, label: "عملية التعديل");
      }
      await remoteState.api.requestCapture(
          AppLinks.service, data, File(mediaFileList[0].path),isAlone: true,
          label: "عملية التعديل");
    } else {
      final data = {
        "op_type": "update",
        "product_name": name.text,
        "product_description": note.text,
        "product_id": productID1,
        "giver_id": remoteState
            .getID(remoteState.givserState, valueOfDropBox)
            .toString()
      };
      if (mediaFileList.isEmpty) {
        await remoteState.api
            .request(AppLinks.product, data, label: "عملية التعديل");
      } else {
        await remoteState.api.requestCapture(
            AppLinks.product, data, File(mediaFileList[0].path),isAlone: true,
            label: "عملية التعديل");
      }
    }
  }

  Future<void> getImageCamera() async {
    remoteState.isLoading(true);
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        mediaFileList.add(pickedFile);
        update();
      }
    } finally {
      remoteState.isLoading(false);
    }
  }

  void valueOfDropDownBox(String val) {
    valueOfDropBox = val;
    update();
  }

  List<String> listOfDataService() {
    return remoteState.getNames(remoteState.givserState);
  }

  void detailsViewScreen({int? id, String? name}) async {
    Get.to(() => const DetailsView(),
        binding: DetailsViewBinding(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        transition: Transition.circularReveal,
        arguments: {"id": id, "name": name});
  }
}
