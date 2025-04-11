part of "auth_repo.dart";

class TokenData {
  final String token;
  final DateTime token_expr;

  const TokenData({required this.token, required this.token_expr});

  Map<String, dynamic> toJson() => {"token": token, "token_expr": token_expr};

  factory TokenData.fromJson(Map<String, dynamic> json) {
    return TokenData(token: json["token"], token_expr: json["token_expr"]);
  }
}

class UserTokenData {
  final TokenData access_token;
  final TokenData refresh_token;
  final TokenData user_token;

  const UserTokenData({
    required this.access_token,
    required this.refresh_token,
    required this.user_token,
  });

  Map<String, dynamic> toJson() => {
    "access_token": access_token.toJson(),
    "refresh_token": refresh_token.toJson(),
    "user_token": user_token.toJson(),
  };

  factory UserTokenData.fromJson(Map<String, dynamic> json) => UserTokenData(
    access_token: TokenData.fromJson(json["access_token"]),
    refresh_token: TokenData.fromJson(json["refresh_token"]),
    user_token: TokenData.fromJson(json["user_token"]),
  );
}
