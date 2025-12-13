enum TaskItemActionSEnum {
  markASDone(name: "Done | UnDone "),
    edit(name: "Edit"),
  delete(name: "Delete");


  final String name;
  const TaskItemActionSEnum({ required this.name});
}
