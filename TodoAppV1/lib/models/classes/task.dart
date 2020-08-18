class Task {
  List<Task> tasks;
  String note;
  DateTime timeToComplete;
  String status;
  String repeats;
  DateTime deadline;
  List<DateTime> reminders;
  String taskId;
  String title;

  Task(this.title, this.status, this.taskId);
}
