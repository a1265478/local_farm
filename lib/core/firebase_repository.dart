import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:local_farm/core/models/image_file.dart';
import 'package:local_farm/core/models/introduction.dart';
import 'package:local_farm/modules/contact_us/model/info.dart';

import '../modules/customer/model/customer.dart';
import '../modules/service_item/model/service.dart';

class FirebaseRepository {
  static final FirebaseRepository _singleton = FirebaseRepository._internal();

  factory FirebaseRepository() {
    return _singleton;
  }

  FirebaseRepository._internal();

  Map<String, dynamic> get data => _data;
  Map<String, dynamic> _data = {};
  Map<String, String> _customThumbnail = {};
  Map<String, dynamic> get customThumbnail => _customThumbnail;

  List<Customer> _customerList = [];
  List<Customer> get customerList => _customerList;
  List<Customer> get customerLimitList {
    return _customerList.length > 6
        ? _customerList.getRange(0, 6).toList()
        : _customerList;
  }

  List<ImageFile> _lineContent = [];
  List<ImageFile> get lineLimitContent {
    return _lineContent.length > 6
        ? _lineContent.getRange(0, 6).toList()
        : _lineContent;
  }

  List<ImageFile> get lineContent => _lineContent;
  List<Service> _serviceList = [];
  List<Service> get serviceList => _serviceList;
  List<ImageFile> _banners = [];
  List<ImageFile> get banners => _banners;
  List<Introduction> _introductionList = [];
  List<Introduction> get introductionList => _introductionList;
  Info _info = Info.empty;
  Info get info => _info;
  DatabaseReference ref = FirebaseDatabase.instance.ref("data");

  Future<bool> isSyncDataFromFirebase() async {
    try {
      final json = await ref.once();
      Map<String, dynamic> result = json.snapshot.value as Map<String, dynamic>;
      _data = result;

      await Future.wait([
        syncBanner(),
        syncIntroduction(),
        syncLineContent(),
        syncCustomer(),
        syncServiceList(),
        syncInfo(),
      ]);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<void> syncBanner() async {
    try {
      final data = _data["banner"] as List;
      List<ImageFile> list = data.map((e) => ImageFile.fromJson(e)).toList();
      _banners = list;
    } catch (_) {}
  }

  Future<void> syncIntroduction() async {
    try {
      final data = _data["introduction"] as List;
      final List<Introduction> introductionList =
          data.map((data) => Introduction.fromJson(data)).toList();
      _introductionList = introductionList;
    } catch (_) {}
  }

  Future<void> syncLineContent() async {
    try {
      final data = _data["line_content"] as List;

      final List<ImageFile> lineContentList =
          data.map((data) => ImageFile.fromJson(data)).toList();
      _lineContent = lineContentList;
    } catch (_) {}
  }

  Future<void> syncCustomer() async {
    try {
      List<Customer> customerList = [];
      final data = _data["customer"] as Map;
      data.forEach((key, value) {
        customerList.add(Customer.fromJson(value));
      });
      _customerList = customerList;

      for (var customer in customerLimitList) {
        try {
          final thumbnail = await loadFirstImage(customer.id);
          _customThumbnail.addAll({customer.id: thumbnail.first});
        } catch (_) {}
      }
    } catch (_) {}
  }

  Future<void> syncServiceList() async {
    try {
      List<Service> serviceList = [];
      final data = _data["service"] as Map;
      data.forEach((key, value) {
        serviceList.add(Service.fromJson(value));
      });
      _serviceList = serviceList;
    } catch (ex) {}
  }

  Future<void> syncInfo() async {
    try {
      final data = Map<String, dynamic>.from(_data["info"]);
      _info = Info.fromJson(data);
    } catch (ex) {
      _info = Info.empty;
    }
  }

  Future<void> updateData(Map<String, dynamic> data) async {
    try {
      await ref.update(data);
    } catch (ex) {
      rethrow;
    }
  }

  List<ImageFile> getLineContentList(int? limit) {
    try {
      final data = _data["line_content"] as List;

      final List<ImageFile> lineContentList =
          data.map((data) => ImageFile.fromJson(data)).toList();

      return limit == null
          ? lineContentList
          : lineContentList.length >= limit
              ? lineContentList.getRange(0, limit).toList()
              : lineContentList;
    } catch (ex) {
      return [];
    }
  }

  Future<List<String>> loadFirstImage(String id) async {
    try {
      DatabaseReference imageRef = FirebaseDatabase.instance.ref("image_set");
      final json = await imageRef.child(id).limitToFirst(1).once();
      final result = json.snapshot.value as List;
      return result.cast<String>();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<String>> loadImageList(String id) async {
    try {
      DatabaseReference imageRef = FirebaseDatabase.instance.ref("image_set");
      final json = await imageRef.child(id).once();
      final result = json.snapshot.value as List;
      return result.cast<String>();
    } catch (ex) {
      rethrow;
    }
  }
}
