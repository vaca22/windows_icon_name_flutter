part of portscanner;

List ipStringToIntegerRange(String ipCidr) {
  List parts = ipCidr.split('/');

  InternetAddress addr = new InternetAddress(parts[0]);
  int ip = internetAddressToInteger(addr);

  int defaultMask = 32, maxInt = 0xFFFFFFFF;

  int mask = parts.length > 1 ? int.parse(parts[1]) : defaultMask;

  return [ip, ip + (maxInt >> mask)];
}

int internetAddressToInteger(InternetAddress addr) {
  var shift = 0;
  return addr.rawAddress.reversed.reduce((prev, elem) {
    shift += 8;
    return prev |= elem << shift;
  });
}

String ipv4IntegerToString(int ip) {
  // 4 sets of 8-bit integer values
  return [
    ip >> 24,
    (ip & 0x00FF0000) >> 16,
    (ip & 0x0000FF00) >> 8,
    (ip & 0x000000FF)
  ].map((int x) => x.toString()).join('.');
}

String ipv6IntegerToString(int ip) {
  List parts = [];

  // 8 sets of 16-bit hex values
  for (int i = 0; i < 8; i++) {
    parts.add((ip & 0xFFFF).toRadixString(16));
    ip >>= 16;
  }

  String ipStr = parts.reversed.join(':');

  // Convert 0s to double-colon shorthand (::)
  ipStr = ipStr.replaceAll(new RegExp(r'(^|:)(0:)+'), '::');

  return ipStr;
}
