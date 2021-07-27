
class Setting {
  final String  appName, appVersion, phone, email, fbUrl, twUrl, instUrl, policy, policyEn, deliveryCost;


  Setting({
    required this.appName, 
    required this.appVersion,
    required this.phone,
    required this.email ,
    required this.fbUrl, 
    required this.twUrl, 
    required this.instUrl, 
    required this.policy,
    required this.policyEn, 
    required this.deliveryCost,
  });


  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      phone: json["phone"],
      email: json["email"],
      appName: json["appName"],
      appVersion:  json['appVersion'],
      fbUrl:  json['fbUrl'],
      twUrl:  json['twUrl'],
      instUrl:  json['instUrl'],
      policy:  json['policy'],
      policyEn:  json['policy_en'],
      deliveryCost: json['deliveryCost'],
    );
  }
}
