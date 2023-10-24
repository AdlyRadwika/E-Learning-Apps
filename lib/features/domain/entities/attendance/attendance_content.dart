class AttendanceContent {
  final String id;
  final String label;
  final String studentId;
  final String studentName;
  final String studentImageUrl;
  final String attendanceDate;

  const AttendanceContent({
    required this.id,
    required this.label,
    required this.studentId,
    required this.studentImageUrl,
    required this.studentName,
    required this.attendanceDate,
  });
}
