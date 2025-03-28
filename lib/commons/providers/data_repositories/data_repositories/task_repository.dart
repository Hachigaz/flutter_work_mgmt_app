import 'package:flutter_work_mgmt_app/commons/misc/random.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/data_repository.dart';

class TaskRepository extends DataRepository<TaskRecord> {
  @override
  ListReturnResult<TaskRecord> search(String searchValue) {
    return (itemList: _generateItems(count: 5), isLast: false);
  }

  @override
  TaskRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  List<TaskRecord> _generateItems({int count = 3}) {
    final List<TaskRecord> recs = [];
    for (var i = 0; i < count; i++) {
      final stringShort = generateRandomString(3);

      final stringName = generateRandomString(5);

      recs.add(
        TaskRecord(
          id: 1,
          workId: 1,
          description:
              """Mỗi chiều đi học về, chú chó Lu nhà tôi lại chạy ào ra, vẫy vẫy cái đuôi tỏ vẻ mừng rỡ chào đón tôi. Chúng tôi đem nó về từ nhà bà ngoại, khi con chó nhà bà đẻ ra một đàn con.

Ngày mới xa mẹ, Lu hiền lành lắm. Chú ta ăn ít, chẳng mấy khi cất tiếng sủa mà suốt ngày chỉ rúc mình trên chiếc giường nhỏ xíu của mình. Tối tối, tôi thường ra kể cho Lu nghe những câu chuyện hài hước trên lớp của tôi. Chú ta không những chẳng cười mà còn kênh kiệu làm ngơ. Một hôm, tôi đi học về, chú chạy ra cửa, ngẩng đầu nhìn tôi. Tôi thấy cưng quá nên ôm chú vào lòng. Chà! Bây giờ, Lu của tôi đã lớn bằng cái phích nước. Nhưng chiếc phích đặc biệt này không chắc cứng đâu. Lu mềm mại với bộ lông vàng tơ dày dặn. Khuôn mặt giờ lúc nào cũng hớn hở, mừng vui. Vì mừng vui nên cái đầu hình tam giác của chú thường lắc lư lắc lư mãi. Điểm vào bộ lông vàng là đôi mắt đen lay láy, to chừng hạt nhãn. Chiếc mũi đen đen thở phì phò, nhưng chú vẫn hay dùng nó để tỏ vẻ âu yếm mọi người đấy. Mỗi khi vui, chú còn thè chiếc lưỡi dài như hình một chiếc lá ra nữa. Tôi thích nhất đôi tai dài của Lu. Đôi ta to hơn lòng bài tay người lớn, rủ xuống hai bên má, cứ như hai cái tai của chú voi tí hon nào đó. Đôi tai chú rất dày lông, ngoài những sợi lông vàng tơ còn có những sợi lông nâu đen. Trông bộ lông trên tai chú cứ như mái tóc hoa râm của một ông cụ nào đó vậy. Bốn chân chú to bằng ngón chân cái người lớn, chân chú tròn mập mạp. Trông vẻ “chân ngắn” vậy thôi, chứ Lu chạy nhanh thoăn thoắt. Sáng sớm, chú tỉnh dậy và ăn sáng để lấy năng lượng. Chú rất khoái khẩu với món canh hầm xương, mấy cục xương đã được ninh nhừ chú đều đánh chén hết. Tối tối, cứ nghe thấy mấy tiếng động lạ là chú cất tiếng sủa “gâu…gâu…gâu…” liên hồi.

Tôi mới cưng chú chó Lu của mình làm sao! Tôi sẽ chăm sóc chú thật tốt để chú có thể đi dạo chơi cùng tôi ở nhiều nơi.""",
          name: "Task $stringShort $stringName",
          nameShort: "Task $stringShort",
          status: TaskStatus.active,
          isActive: true,
        ),
      );
    }
    return recs;
  }
}
