class Appointments {
  final String title;
  final String description;
  final String attendeeEmail; // Updated field
  final DateTime datetime;
  final String meetingStatus;
  final String type; // New field

  Appointments({
    required this.title,
    required this.description,
    required this.attendeeEmail, // Updated field
    required this.datetime,
    required this.meetingStatus,
    required this.type, // New field
  });

  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      attendeeEmail: json['attendee_email'] ?? '', // Updated field
      datetime: DateTime.parse(json['datetime']),
      meetingStatus: json['meeting_status'],
      type: json['type'], // New field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'attendee_email': attendeeEmail, // Updated field
      'datetime': datetime.toIso8601String(),
      'meeting_status': meetingStatus,
      'type': type, // New field
    };
  }
}
