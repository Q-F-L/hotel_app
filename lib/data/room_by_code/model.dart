import 'package:m_softer_test_project/data/organizations/model.dart';
import 'dart:convert';

RoomByCodeModel roomByCodeModelFromJson(String str) =>
    RoomByCodeModel.fromJson(json.decode(str));

String roomByCodeModelToJson(RoomByCodeModel data) =>
    json.encode(data.toJson());

class RoomByCodeModel {
  bool? success;
  Room? room;
  String? error;
  String? message;

  RoomByCodeModel({this.success, this.room, this.error, this.message});

  factory RoomByCodeModel.fromJson(Map<String, dynamic> json) =>
      RoomByCodeModel(
        success: json["success"],
        error: json["error"],
        message: json["message"],
        room: Room.fromJson(json["room"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "room": room?.toJson(),
      };
}

class Room {
  final int id;
  final int organizationId;
  final String name;
  final String description;
  final String qrCode;
  final bool isActive;
  final List<dynamic> gallery;
  final Organization organization;

  Room({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.description,
    required this.qrCode,
    required this.isActive,
    required this.gallery,
    required this.organization,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        organizationId: json["organization_id"],
        name: json["name"],
        description: json["description"],
        qrCode: json["qr_code"],
        isActive: json["is_active"],
        gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
        organization: Organization.fromJson(json["organization"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "organization_id": organizationId,
        "name": name,
        "description": description,
        "qr_code": qrCode,
        "is_active": isActive,
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "organization": organization.toJson(),
      };
}
