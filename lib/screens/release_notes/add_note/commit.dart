class Commit {
  final String author;
  final String hash;
  final String message;
  final String repo;

  String getFullHash() {
    return hash;
  }

  String getShortenedHash() {
    return hash.substring(0, 8);
  }

  String getFullMessage() {
    String shortenedMessage = message.replaceAll("\n", " ");
    return shortenedMessage;
  }

  String getShortenedMessage() {
    String shortenedMessage = message.replaceAll("\n", " ");
    if(shortenedMessage.length > 100) shortenedMessage = shortenedMessage.substring(0, 100) + "...";
    return shortenedMessage;
  }

  Commit(this.author, this.hash, this.message, this.repo);
}