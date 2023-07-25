// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project()
  ..id = json['id'] as String?
  ..tenantId = json['tenantId'] as String?
  ..code = json['code'] as String?
  ..name = json['name'] as String?
  ..expenditureId = json['expenditureId'] as String?
  ..departmentEntityIds = (json['departmentEntityIds'] as List<dynamic>?)
      ?.map((e) => DepartmentEntityIds.fromJson(e as Map<String, dynamic>))
      .toList()
  ..locationIds = json['locationIds'] as String?;

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'code': instance.code,
      'name': instance.name,
      'expenditureId': instance.expenditureId,
      'departmentEntityIds': instance.departmentEntityIds,
      'locationIds': instance.locationIds,
    };

ProjectRequest _$ProjectRequestFromJson(Map<String, dynamic> json) =>
    ProjectRequest()
      ..departmentEntityId = json['departmentEntityId'] as String?
      ..tenantId = json['tenantId'] as String?;

Map<String, dynamic> _$ProjectRequestToJson(ProjectRequest instance) =>
    <String, dynamic>{
      'departmentEntityId': instance.departmentEntityId,
      'tenantId': instance.tenantId,
    };

DepartmentEntityIds _$DepartmentEntityIdsFromJson(Map<String, dynamic> json) =>
    DepartmentEntityIds()
      ..departmentEntityId = json['departmentEntityId'] as String?
      ..status = json['status'] as bool?;

Map<String, dynamic> _$DepartmentEntityIdsToJson(
        DepartmentEntityIds instance) =>
    <String, dynamic>{
      'departmentEntityId': instance.departmentEntityId,
      'status': instance.status,
    };
