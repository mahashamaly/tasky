import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details",style: TextStyle(fontSize:20 ,fontWeight:FontWeight.w400 ),),
      ),
      body: Column(
        children: [
          Text("User Name",style: TextStyle(fontSize:16 ,fontWeight:FontWeight.w400,color: Color(0XffFFFCFC) ),)
        ],
      ),



    );
  }
}