// mapper is the way to handle api response and catch data in model

abstract class Mapper {
  factory Mapper(Mapper type, dynamic data) {
    if (type is SingleMapper) {
      return type.fromJson(data);
    }
    return type;
  }
}

abstract class SingleMapper implements Mapper {
  Mapper fromJson(Map<String, dynamic> json);
}
