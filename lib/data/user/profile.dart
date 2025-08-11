class ProfileRequest {
  bool? success;
  Profile? profile;

  ProfileRequest({this.success, this.profile});

  ProfileRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? middleName;
  String? phone;
  String? deviceToken;
  bool? checkedIn;
  String? fullName;
  CurrentClientRoom? currentClientRoom;
  int? ordersCount;
  int? activeOrdersCount;

  Profile(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.middleName,
      this.phone,
      this.deviceToken,
      this.checkedIn,
      this.fullName,
      this.currentClientRoom,
      this.ordersCount,
      this.activeOrdersCount});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    phone = json['phone'];
    deviceToken = json['device_token'];
    checkedIn = json['checked_in'];
    fullName = json['full_name'];
    currentClientRoom = json['current_client_room'] != null
        ? CurrentClientRoom.fromJson(json['current_client_room'])
        : null;
    ordersCount = json['orders_count'];
    activeOrdersCount = json['active_orders_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['middle_name'] = middleName;
    data['phone'] = phone;
    data['device_token'] = deviceToken;
    data['checked_in'] = checkedIn;
    data['full_name'] = fullName;
    if (currentClientRoom != null) {
      data['current_client_room'] = currentClientRoom!.toJson();
    }
    data['orders_count'] = ordersCount;
    data['active_orders_count'] = activeOrdersCount;
    return data;
  }
}

class CurrentClientRoom {
  int? id;
  int? clientId;
  int? roomId;
  String? checkInDate;
  String? checkOutDate;
  bool? isActive;
  Room? room;

  CurrentClientRoom(
      {this.id,
      this.clientId,
      this.roomId,
      this.checkInDate,
      this.checkOutDate,
      this.isActive,
      this.room});

  CurrentClientRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    roomId = json['room_id'];
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    isActive = json['is_active'];
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['room_id'] = roomId;
    data['check_in_date'] = checkInDate;
    data['check_out_date'] = checkOutDate;
    data['is_active'] = isActive;
    if (room != null) {
      data['room'] = room!.toJson();
    }
    return data;
  }
}

class Room {
  int? id;
  int? organizationId;
  String? name;
  String? description;
  String? qrCode;
  bool? isActive;
  List<String>? gallery;

  Room(
      {this.id,
      this.organizationId,
      this.name,
      this.description,
      this.qrCode,
      this.isActive,
      this.gallery});

  Room.fromJson(Map<String, dynamic> json) {
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
