class Hotel {
  bool? success;
  List<Organizations>? organizations;

  Hotel({this.success, this.organizations});

  Hotel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['organizations'] != null) {
      organizations = <Organizations>[];
      json['organizations'].forEach((v) {
        organizations!.add(Organizations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (organizations != null) {
      data['organizations'] = organizations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Organizations {
  int? id;
  String? email;
  String? phone;
  String? title;
  String? image;
  String? fullTitle;
  String? physicalAddress;
  String? legalAddress;
  String? description;
  bool? isActive;
  String? firstName;
  String? lastName;

  Organizations(
      {this.id,
      this.email,
      this.phone,
      this.title,
      this.image,
      this.fullTitle,
      this.physicalAddress,
      this.legalAddress,
      this.description,
      this.isActive,
      this.firstName,
      this.lastName});

  Organizations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    title = json['title'];
    image = json['image'];
    fullTitle = json['full_title'];
    physicalAddress = json['physical_address'];
    legalAddress = json['legal_address'];
    description = json['description'];
    isActive = json['is_active'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    data['title'] = title;
    data['image'] = image;
    data['full_title'] = fullTitle;
    data['physical_address'] = physicalAddress;
    data['legal_address'] = legalAddress;
    data['description'] = description;
    data['is_active'] = isActive;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
