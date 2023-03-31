import 'package:expense_tracker/model/request_model.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/service_locator.dart';

enum RequestState { initial, loading, success, error }

class RequestProvider extends ChangeNotifier {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController categor = TextEditingController();
  final TextEditingController departmen = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController media = TextEditingController();

  List<dynamic> category = [];
  List<dynamic> department = [];
  final _requestService = serviceLocator<RequestsService>();

  RequestModel? _requestModel;
  RequestState _requestState = RequestState.initial;
  String _errorMessage = '';

  RequestState get requestState => _requestState;
  String get errorMessage => _errorMessage;
  RequestModel? get requestModel => _requestModel;

  void setRequestState(RequestState requestState) {
    _requestState = requestState;
    notifyListeners();
  }

  void resetRequestState() {
    _requestState = RequestState.loading;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  Future<RequestModel> getRequests() async {
    var response = await _requestService.getUserRequests();
    if (response.isError) {
      setErrorMessage(response.errorMessage!);
      setRequestState(RequestState.error);
      return RequestModel(
        data: [],
        msg: '',
        success: false,
      );
    } else {
      _requestModel = RequestModel.fromJson(response.data);
      setRequestState(RequestState.success);
      return _requestModel!;
    }
  }

  Future<RequestModel> getSpecificRequest() async {
    var response = await _requestService.getUserRequests();
    if (response.isError) {
      setErrorMessage(response.errorMessage!);
      setRequestState(RequestState.error);
      return RequestModel(
        data: [],
        msg: '',
        success: false,
      );
    } else {
      _requestModel = RequestModel.fromJson(response.data);
      setRequestState(RequestState.success);
      return _requestModel!;
    }
  }

  getStuff() async {
    var res = await _requestService.getCategories();
    if (res.isError == false) {
      List<dynamic> c = res.data['data'];
      category = c;
      notifyListeners();
    }
    var res1 = await _requestService.getDepartments();
    if (res1.isError == false) {
      List<dynamic> d = res1.data['data'];
      department = d;
      notifyListeners();
    }
  }

  Future<void> createRequest() async {
    setRequestState(RequestState.loading);
    var res = await _requestService.createRequests(
      title.text,
      amount.text,
      desc.text,
      categor.text,
      departmen.text,
      media.text,
    );
    if (res.isError == false) {
      getRequests();
      getSpecificRequest();
      setRequestState(RequestState.success);
    } else {
      setErrorMessage(res.errorMessage.toString());
      setRequestState(RequestState.error);
      title.clear();
      amount.clear();
      desc.clear();
      categor.clear();
      departmen.clear();
      media.clear();
    }
  }
}
