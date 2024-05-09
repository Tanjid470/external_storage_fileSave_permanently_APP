import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class FileStorage {

  static Future<String> getExternalDocumentPath() async {
    PermissionStatus status;
    var deviceSdkVersion= await getDeviceInfo();

    if (Platform.isAndroid &&  deviceSdkVersion > 29) {
      status=await Permission.manageExternalStorage.request();
    } else {
     status= await Permission.storage.request();
    }

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    Directory directory = Directory("");
    if (Platform.isAndroid) {
      directory = Directory("/storage/emulated/0/Android/odd");
    }
    else {
      // If device isNotAndroid
      directory = await getApplicationDocumentsDirectory();
    }

    final exPath = directory.path;
    //log("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<File> writeTextFileExternalStorage(String bytes,String name) async {
    final path = await getExternalDocumentPath();
    File file= File('$path/$name');
    // log("Save file");

    // Write the data in the file you have created
    return file.writeAsString(bytes);
  }

  static Future<String> readExternalTextFile(String fileName) async {

    final path = await getExternalDocumentPath();
    final file = File('$path/$fileName');
    if(await file.exists()){
      try {
        final contents = await file.readAsString();
        return contents;
      } on FileSystemException catch (e) {
        log('Error reading file------------------>: $e');
        throw Exception('Error reading file');
      }
    }
    else{
      return "This path not exists";
    }

  }

  static Future<int> getDeviceInfo() async{
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin() ;
    late AndroidDeviceInfo androidInfo;
    var getInfo = await deviceInfoPlugin.androidInfo;
    if(getInfo.isPhysicalDevice){
      androidInfo=getInfo;
     // log(androidInfo.version.sdkInt.toString());
      return androidInfo.version.sdkInt;
    }
    return 0;
  }

  static String makeSecureString(String text, int shift) {
    String result = "";
    for (int charCode in text.codeUnits) {
      if (charCode >= 65 && charCode <= 90) { // Uppercase letters (A-Z)
        int newCharCode = (charCode - 65 + shift) % 26 + 65;
        result += String.fromCharCode(newCharCode);
      } else if (charCode >= 97 && charCode <= 122) { // Lowercase letters (a-z)
        int newCharCode = (charCode - 97 + shift) % 26 + 97;
        result += String.fromCharCode(newCharCode);
      } else {
        // Leave non-alphabetic characters unchanged
        result += String.fromCharCode(charCode);
      }
    }
    return result;
  }

  static String convertSingleString(List<String> myList) {
    String concat=myList[0];
    for(int i=1;i<myList.length;i++){
      concat="$concat||${myList[i]}";
    }
    return concat;
  }

  static List<String> separateStringIntoList(String str) {
     if (str.isEmpty) {
       return []; // Empty list in Flutter
     }
     return str.split('||');
   }

}
