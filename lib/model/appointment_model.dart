import 'dart:convert';

class AppointmentInfoModel {
  String id;
  String parentActivityInstanceId;
  String processInstanceId;
  String processDefinitionId;
  dynamic businessKey;
  String activityId;
  String activityName;
  String activityType;
  List<AppointmentInfoModel> childActivityInstances;
  List<dynamic> childTransitionInstances;
  List<String> executionIds;

  AppointmentInfoModel({
    this.id,
    this.parentActivityInstanceId,
    this.processInstanceId,
    this.processDefinitionId,
    this.businessKey,
    this.activityId,
    this.activityName,
    this.activityType,
    this.childActivityInstances,
    this.childTransitionInstances,
    this.executionIds,
  });

  factory AppointmentInfoModel.fromJson(String str) =>
      AppointmentInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppointmentInfoModel.fromMap(Map<String, dynamic> json) =>
      AppointmentInfoModel(
        id: json["id"] == null ? null : json["id"],
        parentActivityInstanceId: json["parentActivityInstanceId"] == null
            ? null
            : json["parentActivityInstanceId"],
        processInstanceId: json["processInstanceId"] == null
            ? null
            : json["processInstanceId"],
        processDefinitionId: json["processDefinitionId"] == null
            ? null
            : json["processDefinitionId"],
        businessKey: json["businessKey"],
        activityId: json["activityId"] == null ? null : json["activityId"],
        activityName:
            json["activityName"] == null ? null : json["activityName"],
        activityType:
            json["activityType"] == null ? null : json["activityType"],
        childActivityInstances: json["childActivityInstances"] == null
            ? null
            : List<AppointmentInfoModel>.from(json["childActivityInstances"]
                .map((x) => AppointmentInfoModel.fromMap(x))),
        childTransitionInstances: json["childTransitionInstances"] == null
            ? null
            : List<dynamic>.from(
                json["childTransitionInstances"].map((x) => x)),
        executionIds: json["executionIds"] == null
            ? null
            : List<String>.from(json["executionIds"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "parentActivityInstanceId":
            parentActivityInstanceId == null ? null : parentActivityInstanceId,
        "processInstanceId":
            processInstanceId == null ? null : processInstanceId,
        "processDefinitionId":
            processDefinitionId == null ? null : processDefinitionId,
        "businessKey": businessKey,
        "activityId": activityId == null ? null : activityId,
        "activityName": activityName == null ? null : activityName,
        "activityType": activityType == null ? null : activityType,
        "childActivityInstances": childActivityInstances == null
            ? null
            : List<dynamic>.from(childActivityInstances.map((x) => x.toMap())),
        "childTransitionInstances": childTransitionInstances == null
            ? null
            : List<dynamic>.from(childTransitionInstances.map((x) => x)),
        "executionIds": executionIds == null
            ? null
            : List<dynamic>.from(executionIds.map((x) => x)),
      };
}
