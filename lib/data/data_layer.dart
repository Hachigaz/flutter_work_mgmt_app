import 'dart:convert';
import 'dart:math';

import 'package:flutter_work_mgmt_app/commons/misc/random.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/notifications.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/models.dart';
part "repositories/project_repository.dart";
part "repositories/report_form_template_repository.dart";
part "repositories/report_schedule_repository.dart";
part "repositories/task_report_repository.dart";
part "repositories/task_repository.dart";
part "repositories/work_item_repository.dart";
part "repositories/notification_repository.dart";

class DataLayer {
  DataLayer._(); // Private constructor

  static DataLayer instance = DataLayer._();

  late final _projectRepository = _ProjectRepository();
  late final _workItemRepository = _WorkItemRepository();
  late final _taskRepository = _TaskRepository(
    reportRepo: _reportScheduleRepository,
  );
  late final _reportFormTemplateRepository = _ReportFormTemplateRepository();
  late final _taskReportRepository = _TaskReportRepository();
  late final _reportScheduleRepository = _ReportScheduleRepository();
  late final _notificationRepository = _NotificationRepository();

  DataRepository<ProjectRecord> get projectRepository => _projectRepository;
  DataRepository<WorkItemRecord> get workItemRepository => _workItemRepository;
  DataRepository<TaskRecord> get taskRepository => _taskRepository;
  DataRepository<ReportFormTemplateRecord> get reportFormTemplateRepository =>
      _reportFormTemplateRepository;
  DataRepository<TaskReportRecord> get taskReportRepository =>
      _taskReportRepository;
  DataRepository<ReportScheduleRecord> get reportScheduleRepository =>
      _reportScheduleRepository;
  DataRepository<NotificationRecord> get notificationRepository =>
      _notificationRepository;
}

final dataLayer = DataLayer.instance;
