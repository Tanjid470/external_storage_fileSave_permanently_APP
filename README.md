# Flutter_internal_store

### This project based on how to store file/image in device external folder.
 * Permanently locate sothat whenever app uninstalled that file will will be save in . Re- install file can read
 * File ca save Andriod/data . It's temporary .THe file will deleted with app uninstalled

### Set Up
  **Initialize permission handler - AndroidMainfest.xml**
  * uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
  * uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"
    
  **Take permission depend on version sdk,Reason: have version dependency**
   if (Platform.isAndroid &&  deviceSdkVersion > 29) {
      status=await Permission.manageExternalStorage.request();
    } else {
     status= await Permission.storage.request();
    }

#### Note
~~Android don't allow store permanently in android/data~~
