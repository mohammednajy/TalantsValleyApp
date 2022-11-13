class CounteryModel {
  String flag;
  String name;
  String dialCode;

  CounteryModel(
      {required this.flag, required this.name, required this.dialCode});

  factory CounteryModel.fromJson(Map<String, dynamic> json) {
    return CounteryModel(
        flag: json['flag'], name: json['name'], dialCode: json['dialCode']);
  }
}




