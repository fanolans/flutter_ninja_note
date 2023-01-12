class Note {
  final String id;
  final String tittle;
  final String note;
  final DateTime updatedAt;
  final DateTime createdAt;
  bool isPinned;

  Note({
    required this.id,
    required this.tittle,
    required this.note,
    required this.updatedAt,
    required this.createdAt,
    this.isPinned = false,
  });
}
