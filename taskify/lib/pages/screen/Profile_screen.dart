import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/core/theme/themeController.dart';
import 'package:taskify/core/widget/custom-svg-picture.dart';
import 'package:taskify/main.dart';
import 'package:taskify/pages/screen/user_details_screen.dart';
import 'package:taskify/pages/screen/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String MotivationQuote;
  late String? userImagePath;

  bool isloading = true;
  //File? selectedImage;
  // bool isDarkMode= true;

  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    //استخدام ست ستيت لتحديث واجهة الصفحة بعد تحميل الاسم.
    setState(() {
      username = PreferencesManager().getString('username') ?? '';
      // username = pref.getString('username') ?? '';
      // MotivationQuote = pref.getString()??"One task at a time. One step closer." ;
      MotivationQuote =
          PreferencesManager().getString('MotivationQuote') ??
          "One task at a time. One step closer.";
      isloading = false;
      //isDarkMode= PreferencesManager().getBool("theme")??true;
      userImagePath=PreferencesManager().getString('user-image');
    });

    print("username == $username");
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),

                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,

                        children: [
                          CircleAvatar(
                            backgroundImage:userImagePath== null
                                ? AssetImage('assets/image/person.png')
                                : FileImage(File(userImagePath!)),
                            backgroundColor: Colors.transparent,
                            radius: 60,
                          ),

                          GestureDetector(
                            onTap: () async {
                              //هاى الفنكشن لفتح نافذة اختيار المعرض او الكاميرا
                              voidImageSourseDialog(context,(XFile file){
                                
                                //لحفظ الصورة محليا
                               _saveImage(file);
                                //تحديث واجهة المستخدم
                                setState(() {
                                  userImagePath=file.path;
                                });
                           
                              }
                              
                              
                              );
                              // ختيار الصورة باستخدام ImagePicker
                              //  XFile? image = await ImagePicker().pickImage(source:ImageSource.gallery );

                              //  //التحقق من أن المستخدم اختار صورة
                              //  //لو المستخدم ضغط "Cancel"، قيمة image ستكون null، وإذا حاولنا نستخدمها رح يحصل خطأ.
                              //  if(image!=null){
                              //   setState(() {
                              //     selectedImage=File(image.path);
                              //   });

                              //  }
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),

                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),

                              child: Icon(Icons.camera_alt, size: 26),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        MotivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 24),

                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UserDetailsScreen(
                            userName: username,
                            MotivationQuote: MotivationQuote,
                          );
                        },
                      ),
                    );
                    if (result != null && result) {
                      _loadData();
                    }
                  },
                  contentPadding: EdgeInsets.all(0),
                  title: Text("User Details"),
                  leading: Customsvgpicture(path: 'assets/svg/user-03.svg'),
                  trailing: Customsvgpicture(path: 'assets/svg/back.svg'),
                ),

                Divider(thickness: 1),

                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Dark Mode"),
                  leading: Customsvgpicture(path: 'assets/svg/mon.svg'),

                  trailing: ValueListenableBuilder(
                    valueListenable: Themecontroller.themeNotifier,
                    builder: (context, value, child) {
                      return Switch(
                        value: value == ThemeMode.dark,

                        onChanged: (bool value) async {
                          Themecontroller.toggleTheme();
                        },
                      );
                    },
                  ),
                ),

                Divider(thickness: 1),

                ListTile(
                  onTap: () async {
                    PreferencesManager().remove("username");
                    PreferencesManager().remove("MotivationQuote");
                    PreferencesManager().remove("tasks");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return WelcomeScreen();
                        },
                      ),
                    );
                  },
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Log Out"),
                  leading: Customsvgpicture(path: 'assets/svg/log-out.svg'),

                  trailing: Customsvgpicture(path: 'assets/svg/back.svg'),
                ),
              ],
            ),
          );
  }

void _saveImage(XFile file)async{
  //يعطيك مكان آمن لتخزين الملفات داخل التطبيق
final appDir=await getApplicationDocumentsDirectory();
//ننسخ الصورة من مكانها الأصلي للمجلد الآمن.
  final newFile=await File(file.path).copy('${appDir.path}/${file.name}');
//حفظ المسار بالشير برفرنس
  PreferencesManager().setString("user-image", newFile.path);

}


//هنا فتح الديالوج لاختيار المصدر
  voidImageSourseDialog(BuildContext context,Function(XFile)selectedFile) {
   
   //1-هادا خاص بالكاميرا
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "choose image Source",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(16),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );

                //  //التحقق من أن المستخدم اختار صورة
                //  //لو المستخدم ضغط "Cancel"، قيمة image ستكون null، وإذا حاولنا نستخدمها رح يحصل خطأ.
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text("camera"),
                ],
              ),
            ),

            SimpleDialogOption(
              padding: EdgeInsets.all(16),
              onPressed: () async{
                Navigator.pop(context);
                 XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );

                //  //التحقق من أن المستخدم اختار صورة
                //  //لو المستخدم ضغط "Cancel"، قيمة image ستكون null، وإذا حاولنا نستخدمها رح يحصل خطأ.
                if (image != null) {
                  //هنا بنادى الدالة يلى بعتتها ك كول فنكشن
                  //
                  selectedFile(image);
                 
                }
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text("Gallery"),

                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // void _showButtonSheet(BuildContext context){
  //   showModalBottomSheet(
  //     context:context,
  //     //هنا للارتفاع
  //    isScrollControlled: true,
  //   builder:(context){

  //     return ConstrainedBox(
  //       constraints: BoxConstraints(
  //         maxHeight: MediaQuery.of(context).size.height*0.9,

  //       ),

  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: ListView.builder(

  //         itemCount: 20,
  //         shrinkWrap: true,
  //          itemBuilder: (BuildContext context,int index){

  //         return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //               width: MediaQuery.of(context).size.width,
  //               height: 50,
  //               color: Colors.red,
  //         ),
  //               );

  //               }),
  //       ),
  //     );

  //   });

  // }

  // void _showDateTime(BuildContext context)async{
  //     final selectDate=await showDatePicker(context: context,
  //   initialDate: DateTime.now(),
  //    firstDate:DateTime(1995) ,
  //    lastDate: DateTime.now().add(Duration(days: 360)),

  //    );

  //   final time= await showTimePicker(context: context, initialTime:TimeOfDay(hour: 12, minute: 0) );
  //   print(time);
  // }
}
