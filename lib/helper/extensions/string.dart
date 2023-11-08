extension StringExtension on String {
  bool hasProblematicEntry() {
    final lowerCaseText = toLowerCase();
    return lowerCaseText.contains("killed someone") ||
        lowerCaseText.contains("kill someone") ||
        lowerCaseText.contains("kill myself") ||
        lowerCaseText.contains("suicidal thoughts");
  }
}
