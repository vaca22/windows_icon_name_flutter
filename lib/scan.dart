part of portscanner;

class Scanner {
  Future scanPortRange(String ipCidr) {
    List<String> foundPorts = [];
    List<Future> connectionFutures = [];
    List ipRange = ipStringToIntegerRange(ipCidr);

    for (int rangeIndex = ipRange[0]; rangeIndex < ipRange[1]; rangeIndex++) {
      String ipString = ipv4IntegerToString(rangeIndex);
      connectionFutures.add(Socket.connect(ipString, 13207,
              timeout: const Duration(milliseconds: 100))
          .then((socket) {
        foundPorts.add(ipString);
        socket.destroy();
      }).catchError((error) {
        // ignore errors
      }));
    }

    Completer completer = new Completer();
    Future.wait(connectionFutures).then((allSockets) {
      completer.complete(foundPorts);
    });

    return completer.future;
  }
}
