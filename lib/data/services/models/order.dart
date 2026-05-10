import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final bool? success;
  final String? message;
  final List<Order>? orders;

  OrderModel({
    this.success,
    this.message,
    this.orders,
  });

  OrderModel copyWith({
    bool? success,
    String? message,
    List<Order>? orders,
  }) =>
      OrderModel(
        success: success ?? this.success,
        message: message ?? this.message,
        orders: orders ?? this.orders,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    success: json["success"],
    message: json["message"],
    orders: json["orders"] == null
        ? []
        : List<Order>.from(
      json["orders"]!.map((x) => Order.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "orders": orders == null
        ? []
        : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  final int? id;
  final int? clientId;
  final int? clientRoomId;
  final dynamic staffId;
  final int? status;
  final String? clientComment;
  final dynamic staffComment;
  final List<Option>? options;
  final int? serviceId;
  final dynamic acceptedAt;
  final dynamic finishedAt;
  final bool? isPaid;
  final dynamic canceledBy;
  final dynamic clientFinishComment;
  final dynamic rating;
  final String? createdAt;
  final String? updatedAt;
  final String? price;
  final String? currency;
  final bool? refund;
  final Room? room;
  final Service? service;
  final dynamic staff;

  Order({
    this.id,
    this.clientId,
    this.clientRoomId,
    this.staffId,
    this.status,
    this.clientComment,
    this.staffComment,
    this.options,
    this.serviceId,
    this.acceptedAt,
    this.finishedAt,
    this.isPaid,
    this.canceledBy,
    this.clientFinishComment,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.currency,
    this.refund,
    this.room,
    this.service,
    this.staff,
  });

  Order copyWith({
    int? id,
    int? clientId,
    int? clientRoomId,
    dynamic staffId,
    int? status,
    String? clientComment,
    dynamic staffComment,
    List<Option>? options,
    int? serviceId,
    dynamic acceptedAt,
    dynamic finishedAt,
    bool? isPaid,
    dynamic canceledBy,
    dynamic clientFinishComment,
    dynamic rating,
    String? createdAt,
    String? updatedAt,
    String? price,
    String? currency,
    bool? refund,
    Room? room,
    Service? service,
    dynamic staff,
  }) =>
      Order(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        clientRoomId: clientRoomId ?? this.clientRoomId,
        staffId: staffId ?? this.staffId,
        status: status ?? this.status,
        clientComment: clientComment ?? this.clientComment,
        staffComment: staffComment ?? this.staffComment,
        options: options ?? this.options,
        serviceId: serviceId ?? this.serviceId,
        acceptedAt: acceptedAt ?? this.acceptedAt,
        finishedAt: finishedAt ?? this.finishedAt,
        isPaid: isPaid ?? this.isPaid,
        canceledBy: canceledBy ?? this.canceledBy,
        clientFinishComment:
        clientFinishComment ?? this.clientFinishComment,
        rating: rating ?? this.rating,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        price: price ?? this.price,
        currency: currency ?? this.currency,
        refund: refund ?? this.refund,
        room: room ?? this.room,
        service: service ?? this.service,
        staff: staff ?? this.staff,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    clientId: json["client_id"],
    clientRoomId: json["client_room_id"],
    staffId: json["staff_id"],
    status: json["status"],
    clientComment: json["client_comment"],
    staffComment: json["staff_comment"],
    options: json["options"] == null
        ? []
        : List<Option>.from(
      json["options"]!.map((x) => Option.fromJson(x)),
    ),
    serviceId: json["service_id"],
    acceptedAt: json["accepted_at"],
    finishedAt: json["finished_at"],
    isPaid: json["is_paid"],
    canceledBy: json["canceled_by"],
    clientFinishComment: json["client_finish_comment"],
    rating: json["rating"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    price: json["price"],
    currency: json["currency"],
    refund: json["refund"],
    room: json["room"] == null
        ? null
        : Room.fromJson(json["room"]),
    service: json["service"] == null
        ? null
        : Service.fromJson(json["service"]),
    staff: json["staff"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "client_room_id": clientRoomId,
    "staff_id": staffId,
    "status": status,
    "client_comment": clientComment,
    "staff_comment": staffComment,
    "options": options == null
        ? []
        : List<dynamic>.from(options!.map((x) => x.toJson())),
    "service_id": serviceId,
    "accepted_at": acceptedAt,
    "finished_at": finishedAt,
    "is_paid": isPaid,
    "canceled_by": canceledBy,
    "client_finish_comment": clientFinishComment,
    "rating": rating,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "price": price,
    "currency": currency,
    "refund": refund,
    "room": room?.toJson(),
    "service": service?.toJson(),
    "staff": staff,
  };
}

class Option {
  final int? type;
  final String? name;
  final String? values;

  Option({
    this.type,
    this.name,
    this.values,
  });

  Option copyWith({
    int? type,
    String? name,
    String? values,
  }) =>
      Option(
        type: type ?? this.type,
        name: name ?? this.name,
        values: values ?? this.values,
      );

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    type: json["type"],
    name: json["name"],
    values: json["values"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "values": values,
  };
}

class Room {
  final int? id;
  final int? organizationId;
  final String? name;
  final dynamic description;
  final String? qrCode;
  final bool? isActive;
  final List<dynamic>? gallery;

  Room({
    this.id,
    this.organizationId,
    this.name,
    this.description,
    this.qrCode,
    this.isActive,
    this.gallery,
  });

  Room copyWith({
    int? id,
    int? organizationId,
    String? name,
    dynamic description,
    String? qrCode,
    bool? isActive,
    List<dynamic>? gallery,
  }) =>
      Room(
        id: id ?? this.id,
        organizationId: organizationId ?? this.organizationId,
        name: name ?? this.name,
        description: description ?? this.description,
        qrCode: qrCode ?? this.qrCode,
        isActive: isActive ?? this.isActive,
        gallery: gallery ?? this.gallery,
      );

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"],
    organizationId: json["organization_id"],
    name: json["name"],
    description: json["description"],
    qrCode: json["qr_code"],
    isActive: json["is_active"],
    gallery: json["gallery"] == null
        ? []
        : List<dynamic>.from(json["gallery"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "organization_id": organizationId,
    "name": name,
    "description": description,
    "qr_code": qrCode,
    "is_active": isActive,
    "gallery": gallery == null
        ? []
        : List<dynamic>.from(gallery!.map((x) => x)),
  };
}

class Service {
  final int? id;
  final int? organizationId;
  final int? staffCategoryId;
  final String? price;
  final String? currency;
  final String? description;
  final String? availableFrom;
  final String? availableTo;
  final bool? monday;
  final bool? tuesday;
  final bool? wednesday;
  final bool? thursday;
  final bool? friday;
  final bool? saturday;
  final bool? sunday;
  final bool? isActive;
  final String? name;
  final List<Option>? options;
  final String? icon;

  Service({
    this.id,
    this.organizationId,
    this.staffCategoryId,
    this.price,
    this.currency,
    this.description,
    this.availableFrom,
    this.availableTo,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.isActive,
    this.name,
    this.options,
    this.icon,
  });

  Service copyWith({
    int? id,
    int? organizationId,
    int? staffCategoryId,
    String? price,
    String? currency,
    String? description,
    String? availableFrom,
    String? availableTo,
    bool? monday,
    bool? tuesday,
    bool? wednesday,
    bool? thursday,
    bool? friday,
    bool? saturday,
    bool? sunday,
    bool? isActive,
    String? name,
    List<Option>? options,
    String? icon,
  }) =>
      Service(
        id: id ?? this.id,
        organizationId: organizationId ?? this.organizationId,
        staffCategoryId: staffCategoryId ?? this.staffCategoryId,
        price: price ?? this.price,
        currency: currency ?? this.currency,
        description: description ?? this.description,
        availableFrom: availableFrom ?? this.availableFrom,
        availableTo: availableTo ?? this.availableTo,
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
        isActive: isActive ?? this.isActive,
        name: name ?? this.name,
        options: options ?? this.options,
        icon: icon ?? this.icon,
      );

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    organizationId: json["organization_id"],
    staffCategoryId: json["staff_category_id"],
    price: json["price"],
    currency: json["currency"],
    description: json["description"],
    availableFrom: json["available_from"],
    availableTo: json["available_to"],
    monday: json["Monday"],
    tuesday: json["Tuesday"],
    wednesday: json["Wednesday"],
    thursday: json["Thursday"],
    friday: json["Friday"],
    saturday: json["Saturday"],
    sunday: json["Sunday"],
    isActive: json["is_active"],
    name: json["name"],
    options: json["options"] == null
        ? []
        : List<Option>.from(
      json["options"]!.map((x) => Option.fromJson(x)),
    ),
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "organization_id": organizationId,
    "staff_category_id": staffCategoryId,
    "price": price,
    "currency": currency,
    "description": description,
    "available_from": availableFrom,
    "available_to": availableTo,
    "Monday": monday,
    "Tuesday": tuesday,
    "Wednesday": wednesday,
    "Thursday": thursday,
    "Friday": friday,
    "Saturday": saturday,
    "Sunday": sunday,
    "is_active": isActive,
    "name": name,
    "options": options == null
        ? []
        : List<dynamic>.from(options!.map((x) => x.toJson())),
    "icon": icon,
  };
}