extension StringExtension on String? {
  bool isNullOrBlank() {
    return this == null || this!.isEmpty || this == '';
  }
}

class StringUtils {
  //App Version will be managed by CI build, please do **NOT** change this.
  static String appVersion = '1.0.0';

  static String getFileNameByUrl(String url, {bool isUseFileType = false}) {
    return url.substring(
        url.lastIndexOf('/') + 1, isUseFileType ? null : url.lastIndexOf('.'));
  }

  static String getFileTypeByUrl(String url) {
    return url.substring(url.lastIndexOf('.'));
  }

  static String getMineTypeOfFileByUrl(String url) {
    switch (getFileTypeByUrl(url)) {
      case '.aac':
        return 'audio/aac';
      case '.abw':
        return 'application/x-abiword';
      case '.arc':
        return 'application/x-freearc';
      case '.avif':
        return 'image/avif';
      case '.avi':
        return 'video/x-msvideo';
      case '.bmp':
        return 'image/bmp';
      case '.cda':
        return 'application/x-cdf';
      case '.css':
        return 'text/css';
      case '.csv':
        return 'text/csv';
      case '.doc':
        return 'application/msword';
      case '.docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case '.gz':
        return 'application/gzip';
      case '.gif':
        return 'image/gif';
      case '.htm':
        return 'text/html';
      case '.html':
        return 'text/html';
      case '.ico':
        return 'image/vnd.microsoft.icon';
      case '.ics':
        return 'text/calendar';
      case '.jar':
        return 'application/java-archive';
      case '.jpeg':
        return 'image/jpeg';
      case '.jpg':
        return 'image/jpeg';
      case '.mid':
        return 'audio/midi';
      case '.midi':
        return 'audio/midi';
      case '.mp3':
        return 'audio/mpeg';
      case '.mp4':
        return 'video/mp4';
      case '.mpeg':
        return 'video/mpeg';
      case '.mpkg':
        return 'application/vnd.apple.installer+xml';
      case '.odp':
        return 'application/vnd.oasis.opendocument.presentation';
      case '.ods':
        return 'application/vnd.oasis.opendocument.spreadsheet';
      case '.odt':
        return 'application/vnd.oasis.opendocument.text';
      case '.oga':
        return 'audio/ogg';
      case '.ogv':
        return 'video/ogg';
      case '.ogx':
        return 'application/ogg';
      case '.opus':
        return 'audio/opus';
      case '.otf':
        return 'font/otf';
      case '.png':
        return 'image/png';
      case '.pdf':
        return 'application/pdf';
      case '.ppt':
        return 'application/vnd.ms-powerpoint';
      case '.pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      case '.rar':
        return 'application/vnd.rar';
      case '.rtf':
        return 'application/rtf';
      case '.svg':
        return 'image/svg+xml';
      case '.tar':
        return 'application/x-tar';
      case '.tif':
        return 'image/tiff';
      case '.tiff':
        return 'image/tiff';
      case '.ts':
        return 'video/mp2t';
      case '.ttf':
        return 'font/ttf';
      case '.txt':
        return 'text/plain';
      case '.vsd':
        return 'application/vnd.visio';
      case '.wav':
        return 'audio/wav';
      case '.xls':
        return 'application/vnd.ms-excel';
      case '.xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case '.zip':
        return 'application/zip';
      case '.7z':
        return 'application/x-7z-compressed';
      default:
        return 'text/plain';
    }
  }

  static String get2DigitsNumber(int number) {
    return number < 10 ? '0$number' : '$number';
  }

  static String getFileNameWithType(String file) {
    return file.substring(file.lastIndexOf('/') + 1);
  }

  static bool checkNullAndIsNotEmpty(String? text) {
    return text != null && text.isNotEmpty;
  }
}
