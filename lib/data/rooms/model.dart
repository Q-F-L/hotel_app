import 'dart:convert';

RoomsModel roomsModelFromJson(String str) =>
    RoomsModel.fromJson(json.decode(str));

String roomsModelToJson(RoomsModel data) => json.encode(data.toJson());

class RoomsModel {
  bool? success;
  List<Rooms>? rooms;
  String? message;

  RoomsModel({this.success, this.rooms, this.message});

  RoomsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (rooms != null) {
      data['rooms'] = rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  int? id;
  int? organizationId;
  String? name;
  String? description;
  String? qrCode;
  bool? isActive;
  List<String>? gallery;

  Rooms(
      {this.id,
      this.organizationId,
      this.name,
      this.description,
      this.qrCode,
      this.isActive,
      this.gallery});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organization_id'];
    name = json['name'];
    description = json['description'];
    qrCode = json['qr_code'];
    isActive = json['is_active'];
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organization_id'] = organizationId;
    data['name'] = name;
    data['description'] = description;
    data['qr_code'] = qrCode;
    data['is_active'] = isActive;
    data['gallery'] = gallery;
    return data;
  }
}
