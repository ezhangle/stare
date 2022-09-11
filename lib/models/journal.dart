class Journal {
  final String title;
  final String? year;

  final List<JournalEntry> entries;

  Journal({required this.title, this.year, required this.entries});
}

class JournalEntry {
  final int entryNumber;
  final int date;
  final String month;
  final String mood;
  final String content;

  JournalEntry({
    required this.entryNumber,
    required this.date,
    required this.month,
    required this.mood,
    required this.content,
  });
}
