import 'package:expense_tracker/model/message_model.dart';
import 'package:expense_tracker/services/api_service.dart';
import 'package:expense_tracker/services/service_locator.dart';
import 'package:flutter/foundation.dart';

import '../model/conversation_model.dart';

// enum Message

class MessageProvider extends ChangeNotifier {
  final _messageService = serviceLocator<MessageServce>();

  ConversationModel? _cModel;
  MessageModel? _mModel;

  ConversationModel? get cModel => _cModel;
  MessageModel? get mModel => _mModel;

  Future<ConversationModel> getConversations() async {
    final res = await _messageService.getConversations();

    if (res.isError) {
      return _cModel!;
    } else {
      return _cModel!;
    }
  }
}
