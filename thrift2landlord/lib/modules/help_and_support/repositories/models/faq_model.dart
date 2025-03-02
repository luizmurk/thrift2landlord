part of './../../index.dart';

class FAQ {
  String name;
  String id;
  List<FAQContent> content;

  FAQ({
    required this.name,
    required this.id,
    required this.content,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      content: List<FAQContent>.from(
        (json['content'] ?? []).map(
          (contentJson) => FAQContent.fromJson(contentJson),
        ),
      ),
    );
  }
}

class FAQContent {
  String sectionHeader;
  List<HeaderContent> sectionHeaderContent;

  FAQContent({
    required this.sectionHeader,
    required this.sectionHeaderContent,
  });

  factory FAQContent.fromJson(Map<String, dynamic> json) {
    return FAQContent(
      sectionHeader: json['section_header'] ?? '',
      sectionHeaderContent: List<HeaderContent>.from(
        (json['section_header_content'] ?? []).map(
          (contentJson) => HeaderContent.fromJson(contentJson),
        ),
      ),
    );
  }
}

class HeaderContent {
  String title;
  String description;

  HeaderContent({
    required this.title,
    required this.description,
  });

  factory HeaderContent.fromJson(Map<String, dynamic> json) {
    return HeaderContent(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
