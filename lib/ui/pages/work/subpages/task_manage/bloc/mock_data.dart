part of "task_manage_bloc.dart";

final _taskRecord = TaskRecord(
  id: 1,
  workId: 1,
  name: "Task 1 ABC",
  nameShort: "Task 1",
  status: TaskStatus.active,
  isActive: true,
);

final List<TaskRecord> _searchTaskList = <TaskRecord>[
  TaskRecord(
    id: 1,
    workId: 1,
    name: "Task 1 ABC",
    nameShort: "Task 1",
    status: TaskStatus.active,
    isActive: true,
  ),
  TaskRecord(
    id: 1,
    workId: 1,
    name: "Task 2 DEF",
    nameShort: "Task 2",
    status: TaskStatus.active,
    isActive: true,
  ),
  TaskRecord(
    id: 1,
    workId: 1,
    name: "Task 3 GHI",
    nameShort: "Task 3",
    status: TaskStatus.active,
    isActive: true,
  ),
  TaskRecord(
    id: 1,
    workId: 1,
    name: "Task 4 ABC",
    nameShort: "Task 4",
    status: TaskStatus.active,
    isActive: true,
  ),
  TaskRecord(
    id: 1,
    workId: 1,
    name: "Task 5 CDE",
    nameShort: "Task 5",
    status: TaskStatus.active,
    isActive: true,
  ),
];

List<TaskRecord> _addTaskList({int count = 3}) {
  final List<TaskRecord> taskRecs = [];
  for (var i = 0; i < count; i++) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    final random = Random();
    final stringName = String.fromCharCodes(
      List.generate(
        3,
        (index) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
    final stringShort = String.fromCharCodes(
      List.generate(
        2,
        (index) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );

    taskRecs.add(
      TaskRecord(
        id: 1,
        workId: 1,
        name: "Task $stringShort $stringName",
        nameShort: "Task $stringShort",
        status: TaskStatus.active,
        isActive: true,
      ),
    );
  }
  return taskRecs;
}
