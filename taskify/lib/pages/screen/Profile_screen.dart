import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/pages/screen/user_details_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String username;
  bool isloading = true;
  bool isDarkMode= true;

  void initState() {
    super.initState();
    _LoadUserName();
  }

  void _LoadUserName() async {
    final pref = await SharedPreferences.getInstance();
    //استخدام ست ستيت لتحديث واجهة الصفحة بعد تحميل الاسم.
    setState(() {
      username = pref.getString('username') ?? '';
      isloading = false;
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
                    style: TextStyle(fontSize: 20, color: Color(0XFFFFFCFC)),
                  ),
                ),

                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,

                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/image/person.png',
                            ),
                            backgroundColor: Colors.transparent,
                            radius: 60,
                          ),

                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xfF282828),
                              ),

                              child: Icon(
                                Icons.camera_alt,
                                color: Color(0xffFFFCFC),
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8),
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFCFC),
                        ),
                      ),
                      Text(
                        "One task at a time. One step closer.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),
                Text(
                  "Profile Info",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffFFFCFC),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

            ListTile(
              onTap: (){
                Navigator.push(context,
                 MaterialPageRoute(
                  builder: (BuildContext context){
                  return  UserDetailsScreen();

                }
                )
                );
                
              },
              contentPadding: EdgeInsets.all(0),
              title: Text("User Details",style: TextStyle(fontSize:16 ,fontWeight: FontWeight.w400,color: Color(0xfffFFFCFC)),),
              leading: SvgPicture.asset('assets/svg/user-03.svg'),
              trailing: SvgPicture.asset('assets/svg/back.svg'),

            ),

           Divider(
            color: Color(0xfff6E6E6E),thickness: 1,
           ),
              
               


              
              ListTile(
             
              contentPadding: EdgeInsets.all(0),
              title: Text("Dark Mode",style: TextStyle(fontSize:16 ,fontWeight: FontWeight.w400,color: Color(0xfffFFFCFC)),),
              leading: SvgPicture.asset('assets/svg/mon.svg'),
              trailing:Switch(
               
                value: isDarkMode,
             
                onChanged: (bool value){
                  setState(() {
                  isDarkMode=value;
                  });
                 }
                ),

            ),

            Divider( color: Color(0xfff6E6E6E),thickness: 1,),

                 ListTile(
                  onTap: () {
                    
                  },
              contentPadding: EdgeInsets.all(0),
              title: Text("Log Out",style: TextStyle(fontSize:16 ,fontWeight: FontWeight.w400,color: Color(0xfffFFFCFC)),),
              leading: SvgPicture.asset('assets/svg/log-out.svg'),
              trailing: SvgPicture.asset('assets/svg/back.svg'),

            ),






           
              ],
            ),
          );
  }
}
