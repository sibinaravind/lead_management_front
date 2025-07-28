class ConfigModel {
  String? id;
  String? name;
  String? code;
  String? country;
  String? province;
  String? status;
  String? colour;
  String? program;
  String? category;
  String? phone;
  String? address;

  ConfigModel({
    this.id,
    this.name,
    this.code,
    this.country,
    this.province,
    this.status,
    this.colour,
    this.program,
    this.category,
    this.phone,
    this.address,
  });

  factory ConfigModel.fromMap(Map<String, dynamic> map) => ConfigModel(
        id: map["_id"],
        name: map['name'],
        code: map['code'],
        country: map['country'],
        province: map['province'],
        status: map['status'],
        colour: map['colour'],
        program: map['program'],
        category: map['category'],
        phone: map['phone'],
        address: map['address'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        'name': name,
        'code': code,
        'country': country,
        'province': province,
        'status': status,
        'colour': colour,
        'program': program,
        'category': category,
        'phone': phone,
        'address': address,
      };

  // bool hasFieldName(String fieldName) {
  //   const validFields = [
  //     'id',
  //     'name',
  //     'code',
  //     'country',
  //     'province',
  //     'status',
  //     'colour'
  //   ];
  //   return validFields.contains(fieldName);
  // }

  // bool hasField(String fieldName) {
  //   return _getFieldValue(fieldName) != null;
  // }

  // dynamic getFieldValue(String fieldName) {
  //   return _getFieldValue(fieldName);
  // }

  // dynamic _getFieldValue(String fieldName) {
  //   switch (fieldName) {
  //     case 'id':
  //       return id;
  //     case 'name':
  //       return name;
  //     case 'code':
  //       return code;
  //     case 'country':
  //       return country;
  //     case 'province':
  //       return province;
  //     case 'status':
  //       return status;
  //     case 'colour':
  //       return colour;
  //     default:
  //       return null;
  //   }
  // }
}
