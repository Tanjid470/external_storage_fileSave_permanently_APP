import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_internal_store/permanently_store_externalStorage.dart';
import 'package:flutter_internal_store/temporary_store_externalStorage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String current="log_sos_reIN_ex_devi.txt";
  String previous="permanentlySave7.txt";
  List<String> inputList =
  [
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI3NzU2MzE3LCJpYXQiOjE3MTQ3OTYzMTcsImp0aSI6IjQ1ODViZTdjYmViMDQzYThiNGIyZGMxZTljMGI2YzRlIiwidXNlcl9pZCI6NzU0NzF9.Gfajf7kPZa4LyaEMzuIs27YCAQeGsz9qOU5FEFbIqc8",
    "UwDs-pCQk78"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Permanently",style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w500,fontSize: 25),),centerTitle: true,backgroundColor:Colors.grey.withOpacity(.25) ,),

      floatingActionButton: FloatingActionButton (
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TemporaryStore()),
          );
        },
        tooltip: 'Next Page',
        child: const Icon(Icons.navigate_next),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 10,
            color: Colors.transparent,
          ),

          KButton( onTap: () async{
            String concatString=FileStorage.convertSingleString(inputList);
            String encryptedText = FileStorage.makeSecureString(concatString, 3);
            log('$encryptedText----------Write----------->EncryptedText');
            FileStorage.writeTextFileExternalStorage(encryptedText, current);
          }, buttonType: 'Save Permanently',),

          KButton( onTap: () async{
            var readText= await FileStorage.readExternalTextFile(current);
            String decryptedText = FileStorage.makeSecureString(readText, -3);
            List<String> outputList=FileStorage.separateStringIntoList(decryptedText);
            log('${outputList[1]}-----------Read---------->DecryptedText');
          }, buttonType: 'Read Current',),

          KButton( onTap: () async{
            var readText= await FileStorage.readExternalTextFile(previous);
            String decryptedText = FileStorage.makeSecureString(readText, -3);
            List<String> outputList=FileStorage.separateStringIntoList(decryptedText);
            log('$outputList-----------ReadPrevious---------->DecryptedText');
          }, buttonType: 'Read Previous',),


        ],
      ),


    );
  }


}

class KButton extends StatelessWidget {
  final VoidCallback onTap;
  final String  buttonType;

  const KButton({
    super.key,
    required this.onTap,
    required this.buttonType,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent.withOpacity(.8),
            borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Text(buttonType,style: const TextStyle(fontSize: 20,color: Colors.white),),
        ),
      ),
    );
  }
}


