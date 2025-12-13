import 'package:flutter/material.dart';

import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/core/widget/custom_text_form_faild.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key, required this.userName, required this.MotivationQuote,});
   final String userName;
   final String? MotivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
final TextEditingController userNameController=TextEditingController();

final TextEditingController MotivationQuoteController=TextEditingController();

final GlobalKey<FormState> _key=GlobalKey();
@override
  void initState() {
    super.initState();
    userNameController.text=widget.userName;
     MotivationQuoteController.text = widget.MotivationQuote ?? '';


  }


  

  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details",style: TextStyle(fontSize:20 ,fontWeight:FontWeight.w400 ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormFaild(controller:userNameController , hintText: 'Maha Atef', title: 'User Name',
              validator: (String?value){
                
              if (value == null || value.trim().isEmpty) {
                       return "Please Enter User Name";
                     }
                     return null;
          
              },
              
              ),
              SizedBox(
                height:20 ,
              ),
              CustomTextFormFaild(controller: MotivationQuoteController, hintText: 'One task at a time. One step closer.', title: 'Motivation Quote',maxLines: 5,
              validator: (String?value){
                if(value==null||value.trim().isEmpty){
                 return "Please Enter Motivation Quote";
                }
                return null;
              }
              
              
              ),
          
          
              Spacer(),
              ElevatedButton(onPressed: ()async{
             
                if(_key.currentState!.validate()){
               
                      // تخزين اسم المستخدم (⚠️ غير مشفّر)
                      PreferencesManager().setString('username', userNameController.value.text);
                       PreferencesManager().setString('MotivationQuote', MotivationQuoteController.value.text);
                    //await  pref.setString('username', userNameController.value.text);
                    //await  pref.setString('MotivationQuote', MotivationQuoteController.value.text);
                    Navigator.pop(context,true);

                }
              }, 
              child: Text("Save Changes"),
             style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width, 40),
             ),
              )
            ],
          ),
        ),
      ),
     



    );
  }
}