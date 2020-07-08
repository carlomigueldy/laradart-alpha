class AuthenticatedUser {
  final String avatar;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String email;
  final String timeZone;
  final String formattedTimeZone;
  final bool isAdmin;

  AuthenticatedUser.fromJson(Map<String, dynamic> json)
      : avatar = json['avatar'] ?? "",
        firstName = json['firstName'] ?? "",
        middleName = json['middleName'] ?? "",
        lastName = json['lastName'] ?? "",
        fullName = json['fullName'] ?? "",
        email = json['email'] ?? "",
        timeZone = json['timeZone'] ?? "",
        formattedTimeZone = json['formattedTimeZone'] ?? "",
        isAdmin = json['isAdmin'] ?? false;
}
