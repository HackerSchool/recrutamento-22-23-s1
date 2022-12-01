const String noteTable = 'notes';

class NoteFields {
  static const List<String> values = [id, title, content, color, time];

  static const String id = '_id';
  static const String title = 'title';
  static const String content = 'content';
  static const String color = 'color';
  static const String time = 'time';
}

class Note {
  final int? id;

  final String title;
  final String content;
  final int color;
  final DateTime createdAt;

  const Note(
      {this.id,
      required this.title,
      required this.content,
      required this.color,
      required this.createdAt});

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.content: content,
        NoteFields.color: color,
        NoteFields.time: createdAt.toIso8601String()
      };

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        content: json[NoteFields.content] as String,
        color: json[NoteFields.color] as int,
        createdAt: DateTime.parse(json[NoteFields.time] as String),
      );

  Note copy({
    int? id,
    String? title,
    String? content,
    int? color,
    DateTime? createdAt,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
      );
}
