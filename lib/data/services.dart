class ServicesRequest {
  bool? success;
  List<Services>? services;

  ServicesRequest({this.success, this.services});

  ServicesRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  int? organizationId;
  int? staffCategoryId;
  String? price;
  String? currency;
  String? description;
  String? availableFrom;
  String? availableTo;
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thursday;
  bool? friday;
  bool? saturday;
  bool? sunday;
  bool? isActive;
  String? name;
  List<Options>? options;
  String? icon;

  Services(
      {this.id,
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
      this.icon});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organization_id'];
    staffCategoryId = json['staff_category_id'];
    price = json['price'];
    currency = json['currency'];
    description = json['description'];
    availableFrom = json['available_from'];
    availableTo = json['available_to'];
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
    sunday = json['Sunday'];
    isActive = json['is_active'];
    name = json['name'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organization_id'] = organizationId;
    data['staff_category_id'] = staffCategoryId;
    data['price'] = price;
    data['currency'] = currency;
    data['description'] = description;
    data['available_from'] = availableFrom;
    data['available_to'] = availableTo;
    data['Monday'] = monday;
    data['Tuesday'] = tuesday;
    data['Wednesday'] = wednesday;
    data['Thursday'] = thursday;
    data['Friday'] = friday;
    data['Saturday'] = saturday;
    data['Sunday'] = sunday;
    data['is_active'] = isActive;
    data['name'] = name;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['icon'] = icon;
    return data;
  }
}

class Options {
  int? type;
  String? name;
  String? values;

  Options({this.type, this.name, this.values});

  Options.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    values = json['values'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['name'] = name;
    data['values'] = values;
    return data;
  }
}
