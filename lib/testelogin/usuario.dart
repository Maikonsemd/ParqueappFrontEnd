class Usuario {
  bool authenticated;
  String expiration;
  String token;
  String message;

  Usuario({this.authenticated, this.expiration, this.token, this.message});

  Usuario.fromJson(Map<String, dynamic> json) {
    authenticated = json['authenticated'];
    expiration = json['expiration'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authenticated'] = this.authenticated;
    data['expiration'] = this.expiration;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}