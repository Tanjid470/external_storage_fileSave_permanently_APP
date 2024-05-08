import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class TemporaryStore extends StatefulWidget {
  const TemporaryStore({super.key});

  @override
  State<TemporaryStore> createState() => _TemporaryStoreState();
}

class _TemporaryStoreState extends State<TemporaryStore> {
  String image="";
  late File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Temporary",style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w500,fontSize: 25),),centerTitle: true,backgroundColor:Colors.grey.withOpacity(.25) ,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 10,
            color: Colors.transparent,
          ),
          const SizedBox(height: 40,),
          image.isEmpty?const SizedBox.shrink():Image.file(File(image)),
          const SizedBox(height: 20,),

          //Pick image
          ElevatedButton(onPressed: () async{
            //var status=await Permission.storage.request();
            var image=await ImagePicker().pickImage(source:ImageSource.gallery);
            if(image!=null){
              setState(() {
                this.image=image.path;
              });
            }
          }, child: const Text("Select Image")),

          ElevatedButton(onPressed: () async {
            var status=await Permission.storage.request();
            if(status==PermissionStatus.granted){
              try{
                /*  <--------Check the location here external store hit-------->
                Directory? directory = await getExternalStorageDirectory();
                log('${directory}--------------');*/
                var read=await File(image).readAsBytes();
                file=File("/storage/emulated/0/Android/data/com.example.flutter_internal_store/files/image.jpg");
                var newFile=await file.create(recursive: true);
                var write = await newFile.writeAsBytes(read);
                log(write.toString());
              }
              catch(execption){
                log(execption.toString());
              }
             if (status.isDenied) {
               log('Storage permission denied');
             }
            }
            else if (status.isPermanentlyDenied) {
              await openAppSettings();
            }
          }, child: const Text("Create and Store")),

          ElevatedButton(onPressed: () async{
            //var flag=await file.exists();
            if(await file.exists()){
              file.delete(recursive: true);
              setState(() {
                image="";
              });
              log("Deleted successfully");
            }

          }, child: const Text("Delete")),
        ],
      ),
    );
  }
}
