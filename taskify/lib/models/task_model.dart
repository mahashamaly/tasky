class TaskModel {
  final int id;
final String taskName;
final String taskDescription;
final bool HighPriority;
bool isDone;
TaskModel({
required this.id,
required this.taskName,
required this.taskDescription,
required this.HighPriority,
this.isDone=false,

});

// وهنا عملت فاكتورى كونستركتور من المودل يلى اسمه تاسك مودل
//راح ابعتله الجسون يلى جاي من الشير برفرنس علشان هو بالنهاية يرجعلى اوبجكت جديد تاسك مودل
factory TaskModel.fromJson(Map<String,dynamic>json){
  return TaskModel(
    id: json["id"],
   taskName: json["taskName"],
     taskDescription:json ["taskDescription"], 
     HighPriority:json ["HighPriority"],
     isDone: json["isDone"]??false,
     );
    
}






//حولت المودل يلى عندى من سترنج وبولين الى ماب كى وفاليو
//بتحول كائن التاسك مودل لماب وبعدها بعمله انكودد وبخزنه

Map<String,dynamic>toJson(){
  return{
    "id":id,
 "taskName":taskName,
 "taskDescription":taskDescription,
  "HighPriority":HighPriority,
"isDone":isDone,

  };
  
}


}



