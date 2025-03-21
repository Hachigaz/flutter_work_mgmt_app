part of "task_detail_bloc.dart";

final _taskRecord = TaskRecord(
  id: 1,
  workId: 1,
  name: "Task 1 ABC",
  nameShort: "Task 1",
  description:
      """Mỗi chiều đi học về, chú chó Lu nhà tôi lại chạy ào ra, vẫy vẫy cái đuôi tỏ vẻ mừng rỡ chào đón tôi. Chúng tôi đem nó về từ nhà bà ngoại, khi con chó nhà bà đẻ ra một đàn con.

Ngày mới xa mẹ, Lu hiền lành lắm. Chú ta ăn ít, chẳng mấy khi cất tiếng sủa mà suốt ngày chỉ rúc mình trên chiếc giường nhỏ xíu của mình. Tối tối, tôi thường ra kể cho Lu nghe những câu chuyện hài hước trên lớp của tôi. Chú ta không những chẳng cười mà còn kênh kiệu làm ngơ. Một hôm, tôi đi học về, chú chạy ra cửa, ngẩng đầu nhìn tôi. Tôi thấy cưng quá nên ôm chú vào lòng. Chà! Bây giờ, Lu của tôi đã lớn bằng cái phích nước. Nhưng chiếc phích đặc biệt này không chắc cứng đâu. Lu mềm mại với bộ lông vàng tơ dày dặn. Khuôn mặt giờ lúc nào cũng hớn hở, mừng vui. Vì mừng vui nên cái đầu hình tam giác của chú thường lắc lư lắc lư mãi. Điểm vào bộ lông vàng là đôi mắt đen lay láy, to chừng hạt nhãn. Chiếc mũi đen đen thở phì phò, nhưng chú vẫn hay dùng nó để tỏ vẻ âu yếm mọi người đấy. Mỗi khi vui, chú còn thè chiếc lưỡi dài như hình một chiếc lá ra nữa. Tôi thích nhất đôi tai dài của Lu. Đôi ta to hơn lòng bài tay người lớn, rủ xuống hai bên má, cứ như hai cái tai của chú voi tí hon nào đó. Đôi tai chú rất dày lông, ngoài những sợi lông vàng tơ còn có những sợi lông nâu đen. Trông bộ lông trên tai chú cứ như mái tóc hoa râm của một ông cụ nào đó vậy. Bốn chân chú to bằng ngón chân cái người lớn, chân chú tròn mập mạp. Trông vẻ “chân ngắn” vậy thôi, chứ Lu chạy nhanh thoăn thoắt. Sáng sớm, chú tỉnh dậy và ăn sáng để lấy năng lượng. Chú rất khoái khẩu với món canh hầm xương, mấy cục xương đã được ninh nhừ chú đều đánh chén hết. Tối tối, cứ nghe thấy mấy tiếng động lạ là chú cất tiếng sủa “gâu…gâu…gâu…” liên hồi.

Tôi mới cưng chú chó Lu của mình làm sao! Tôi sẽ chăm sóc chú thật tốt để chú có thể đi dạo chơi cùng tôi ở nhiều nơi.""",
  status: TaskStatus.active,
  isActive: true,
);

final _reportSchedules = [
  ReportSchedule(
    id: 1,
    taskId: 1,
    title: "Báo cáo công việc 1 abc asd abc asd",
    dueDate: DateTime.now().add(Duration(days: 0)),
    isReported: false,
    reportId: null,
    isActive: true,
  ),
  ReportSchedule(
    id: 2,
    taskId: 2,
    title: "Báo cáo công việc 2",
    dueDate: DateTime.now().add(Duration(days: 1)),
    isReported: false,
    reportId: null,
    isActive: true,
  ),
  ReportSchedule(
    id: 3,
    taskId: 3,
    title: "Báo cáo công việc 3",
    dueDate: DateTime.now().add(Duration(days: 5)),
    isReported: false,
    reportId: null,
    isActive: true,
  ),
  ReportSchedule(
    id: 4,
    taskId: 4,
    title: "Báo cáo công việc 4",
    dueDate: DateTime.now().add(Duration(days: 10)),
    isReported: false,
    reportId: null,
    isActive: true,
  ),
  ReportSchedule(
    id: 5,
    taskId: 5,
    title: "Báo cáo công việc 5",
    dueDate: DateTime.now().add(Duration(days: 15)),
    isReported: false,
    reportId: null,
    isActive: true,
  ),
];

// final _recurringSchedules = [
//   ReportRecurringSchedule(
//     id: 1,
//     reportScheduleId: 1,
//     title: "Báo cáo định kỳ 1",
//     recurringType: RecurringType.monthly,
//     timeIndex: 5,
//     count: 5,
//     isActive: true,
//   ),
//   ReportRecurringSchedule(
//     id: 1,
//     reportScheduleId: 1,
//     title: "Báo cáo định kỳ 2",
//     recurringType: RecurringType.monthly,
//     timeIndex: 10,
//     count: 3,
//     isActive: true,
//   ),
// ];

final _recentReports = [
  TaskReportRecord(
    id: 1,
    scheduleId: 1,
    createdBy: 1,
    verifiedBy: 1,
    dateCreated: DateTime.now(),
    reportData: null,
    isActive: true,
  ),
];
