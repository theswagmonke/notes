class Note {
  int? id;
  final String title;
  final String text;
  String? category;

  Note({
    this.id,
    required this.title,
    required this.text,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'category': category ?? 'Без категории',
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      text: map['text'],
      category: map['category'],
    );
  }

  Note copyWith({int? id, String? title, String? text, String? category}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return "[$id, $title, $text, $category]";
  }
}
