import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/project_root/components/project_display_item.dart';

class ProjectListDisplay extends StatelessWidget {
  final ValueNotifier<List<ProjectRecord>> _projectRecordList =
      ValueNotifier<List<ProjectRecord>>([]);

  ProjectListDisplay({super.key});

  void _updateProjectList() {
    _projectRecordList.value = [
      ProjectRecord(
        id: 1,
        name: "Project 1 ABC",
        nameShort: "Project 1",
        description: "",
        workAddress: "",
        startDate: DateTime.now(),
        workItemCount: 2,
        isActive: true,
      ),
      ProjectRecord(
        id: 2,
        name: "Project 2 DEF",
        nameShort: "Project 2",
        description: "",
        workAddress: "",
        startDate: DateTime.now(),
        workItemCount: 5,
        isActive: true,
      ),
      ProjectRecord(
        id: 3,
        name: "Project 3 GHI",
        nameShort: "Project 3",
        description: "",
        workAddress: "",
        startDate: DateTime.now(),
        workItemCount: 4,
        isActive: true,
      ),
      ProjectRecord(
        id: 4,
        name: "Project 4 ABC",
        nameShort: "Project 4",
        description: "",
        workAddress: "",
        startDate: DateTime.now(),
        workItemCount: 2,
        isActive: true,
      ),
      ProjectRecord(
        id: 4,
        name: "Project 4 DEF",
        nameShort: "Project 4",
        description: "",
        workAddress: "",
        startDate: DateTime.now(),
        workItemCount: 5,
        isActive: true,
      ),
      ProjectRecord(
        id: 5,
        name: "Project 5 GHI",
        nameShort: "Project 5",
        description: "",
        workAddress: "",
        startDate: DateTime.now(),
        workItemCount: 4,
        isActive: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _updateProjectList();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_lg),
                child: ElevatedButton(
                  onPressed: _updateProjectList,
                  child: Text("Tải lại"),
                ),
              ),
            ],
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _projectRecordList,
              builder: (context, value, child) {
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                  children: [
                    for (final record in _projectRecordList.value)
                      ProjectListItem(projectRecord: record),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveProjectListDisplay extends ProjectListDisplay {
  ActiveProjectListDisplay({super.key});

  @override
  void _updateProjectList() {
    _projectRecordList.value = [
      ProjectRecord(
        id: 1,
        name: "Project 1 ABC",
        nameShort: "Project 1",
        description: "",
        workAddress: "",
        startDate: DateTime.now(),
        workItemCount: 2,
        isActive: true,
      ),
      ProjectRecord(
        id: 2,
        name: "Project 2 DEF",
        nameShort: "Project 2",
        description: "",
        workAddress: "",
        startDate: DateTime.now(),
        workItemCount: 5,
        isActive: true,
      ),
      ProjectRecord(
        id: 3,
        name: "Project 3 GHI",
        nameShort: "Project 3",
        description: "",
        workAddress: "",
        startDate: DateTime.now(),
        workItemCount: 4,
        isActive: true,
      ),
    ];
  }
}
