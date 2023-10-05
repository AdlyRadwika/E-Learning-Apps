extension StringExtension on String {
  String getGreetingBasedOnTime() {
    final hour = DateTime.now().hour;
    if (hour > 17) {
      return "Good evening, $this";
    } else if (hour > 12) {
      return "Good afternoon, $this";
    } else if (hour > 6) {
      return "Good morning, $this";
    }
    return "Good night, $this";
  }
}
