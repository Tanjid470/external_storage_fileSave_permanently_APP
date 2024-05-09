# Flutter_internal_store

### This project based on how to store file/image in device external folder.
 * Permanently locate so that whenever the app is uninstalled that file will be saved. In Re - install previous save file can read
 * File ca save Andriod/data . It's temporary. The file will deleted with the app uninstalled

## Overview

**Flutter app leverages secure storage to save login data (encrypted) on device storage. Upon app launch, it checks for this data and auto-logins the user if found, enhancing user experience by skipping the login screen. Remember, security is paramount - encrypt data and manage keys properly.**
* First data list en

### Set Up
  **Initialize permission handler - AndroidMainfest.xml**
  * uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
  * uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"
    
  **Take permission depend on version sdk,Reason: have version dependency**
  ```
   if (Platform.isAndroid &&  deviceSdkVersion > 29) {
      status=await Permission.manageExternalStorage.request();
    } else {
     status= await Permission.storage.request();
  ```
  **Analysis permanently_store_externalStorage.dart**
    

#### Note
~~Android don't allow store permanently in android/data~~
