import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_ai/core/cache/cache.dart';

class CloudStoreService {
  static Future<void> fetchDataFromFirestore() async {
    var email = CacheData.getdata(key: 'email');
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('names').get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        log('Start');
        log('${data['name']}');
        if (data['email'] == email) {
          CacheData.setData(key: 'fullNameFire', value: data['name']);
          CacheData.getdata(key: 'fullNameFire');
          log(CacheData.getdata(key: 'fullNameFire'));
          break;
        } else {
          log('Data not found');
        }
      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  static Future<void> fetchImage() async {
    var email = CacheData.getdata(key: 'email');
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('image').get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        log('Start');
        log('${data['image']}');
        if (data['email'] == email) {
          CacheData.setData(key: 'imageFire', value: data['image']);
          log(CacheData.getdata(key: 'imageFire'));
          break;
        } else {
          log('image not found');
        }
      }
    } catch (e) {
      log('Error fetching image: $e');
    }
  }
}
