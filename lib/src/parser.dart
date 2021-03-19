enum ParseResult {
  ISAUTHENTICATED,
  PUBLISH,
  REMOVETOKEN,
  SETTOKEN,
  EVENT,
  ACKRECEIVE
}

class Parser {
  static ParseResult parse(dynamic dataObject, int? rid, int? cid, String? event) {
    if (event == null)
      return rid == 1 ? ParseResult.ISAUTHENTICATED : ParseResult.ACKRECEIVE;
    switch (event) {
      case "#publish":
        return ParseResult.PUBLISH;
      case "#removeAuthToken":
        return ParseResult.REMOVETOKEN;
      case "#setAuthToken":
        return ParseResult.SETTOKEN;
      default:
        return ParseResult.EVENT;
    }
  }
}
