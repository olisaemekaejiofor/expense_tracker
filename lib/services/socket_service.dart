import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  final _storage = const FlutterSecureStorage();
  io.Socket socket = io.io('wss://expense-tracker-backend.herokuapp.com/', {
    'transports': ['websocket'],
    'autoConnect': true,
  });

  createSocketConnection() async {
    var id = await _storage.read(key: 'id');
    // var type = await _storage.read(key: 'role');
    // print(socket.active);

    socket.onConnect((data) {
      print('connected');
      print(socket.id!);
      socket.emit(
        'join',
        {
          "userId": "$id",
          "type": "user",
          "socketId": socket.id!,
        },
      );
      socket.on('join', (data) {
        print(socket.id);
        print(data);
      });
    });
    // ignore: avoid_print
    print(socket.connected);
  }
}
