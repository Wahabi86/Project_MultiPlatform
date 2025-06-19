String fixPosterUrl(String url) {
  if (url.contains('localhost')) {
    return url.replaceFirst('http://localhost', 'http://10.0.2.2');
  }
  return url;
}
