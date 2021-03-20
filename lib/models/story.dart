class Story {
  String id;
  String author;
  String body;
  String emotion;

  /** Constructor */
  Story(String id, String body, String author, String emotion) {
    this.id = id;
    this.body = body;
    this.author = author;
    this.emotion = emotion;
  }

  String toString() {
    return
      """
      id:   ${this.id}
      author: ${this.author}
      body:${this.body}
      emotion: ${this.emotion}
      """;
  }

}