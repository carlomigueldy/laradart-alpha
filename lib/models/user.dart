class User {
  final String avatar;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String email;
  final String timeZone;
  final String formattedTimeZone;
  final bool isAdmin;

  User({
    this.avatar,
    this.firstName,
    this.middleName,
    this.lastName,
    this.fullName,
    this.email,
    this.timeZone,
    this.formattedTimeZone,
    this.isAdmin,
  });

  User.fromJson(Map<String, dynamic> json)
      : avatar = json['avatar'],
        firstName = json['first_name'],
        middleName = json['middle_name'],
        lastName = json['last_name'],
        fullName = json['full_name'],
        email = json['email'],
        timeZone = json['time_zone'],
        formattedTimeZone = json['formatted_time_zone'],
        isAdmin = json['is_admin'];

  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
        'full_name': fullName,
        'email': email,
        'time_zone': timeZone,
        'formatted_time_zone': formattedTimeZone,
        'is_admin': isAdmin,
      };
}
