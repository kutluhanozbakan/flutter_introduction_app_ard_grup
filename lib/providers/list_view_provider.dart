import 'package:flutter/material.dart';
import 'package:flutter_introduction_app_ard_grup/api/api_repository.dart';
import 'package:flutter_introduction_app_ard_grup/components/crud_view/crud_view.dart';
import 'package:flutter_introduction_app_ard_grup/models/list_view.model.dart';
import 'package:flutter_introduction_app_ard_grup/utils/api_urls.dart';
import 'package:provider/provider.dart';

import '../models/http_response.model.dart';
import '../utils/global_utils.dart';
import 'main_page_view_provider.dart';

class ListViewProvider extends ChangeNotifier {
  final apirepository = APIRepository();
  List<ListViewModel> _exampleListView = [];
  List<ListViewModel> tempexampleListView = [];
  PageController? _pageController;

  bool _isDataLoading = true;
  bool _loading = false;
  bool _isDataExist = false;
  int _currentPage = 1;
  int _toplamKayitSayisi = 0;

  PageController? get pageController => _pageController;
  set setpageController(PageController pageController) {
    _pageController = pageController;
    notifyListeners();
  }

  List<ListViewModel> get exampleListView => _exampleListView;
  set setiexampleListView(List<ListViewModel> exampleListView) {
    _exampleListView = exampleListView;
    notifyListeners();
  }

  bool get isDataLoading => _isDataLoading;

  set setisDataLoading(bool isDataLoading) {
    _isDataLoading = isDataLoading;
    notifyListeners();
  }

  bool get loading => _loading;

  set setloading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  bool get isDataExist => _isDataExist;

  set setisDataExist(bool isDataExist) {
    _isDataExist = isDataExist;
    notifyListeners();
  }

  int get toplamKayitSayisi => _toplamKayitSayisi;

  set settoplamKayitSayisi(int toplamKayitSayisi) {
    _toplamKayitSayisi = toplamKayitSayisi;
    notifyListeners();
  }

  int get currentPage => _currentPage;

  set setcurrentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  bool notificationController(ScrollNotification scrollInfo) {
    if (!_isDataLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      if (_toplamKayitSayisi != null &&
          _exampleListView.length >= _toplamKayitSayisi) {
        return false;
      }
      _currentPage = 1 + _currentPage;
      loadData(_currentPage);
      _isDataLoading = true;
      notifyListeners();
    } else {}
    return false;
  }

  void loadData(index) async {
    _isDataLoading = true;
    Map<String, dynamic> queryParameters = {
      "Page": index,
      "PropertyName": 'id',
      "ItemPerPage": 10,
      "Asc": false,
      "version": 1
    };

    httpSonucModel result = await apirepository.getListForPaging(
        controller: getNotificationsWithPagingFilter,
        queryParameters: queryParameters);
    if (result.success!) {
      tempexampleListView = (result.data.data['data'] as List)
          .map((e) => ListViewModel.fromJson(e))
          .toList();
      Future.delayed(const Duration(milliseconds: 1200), () {
        exampleListView.addAll(tempexampleListView);
        _toplamKayitSayisi = result.data.data['totalItemCount'];
        int noOfTasks = tempexampleListView.length;
        if (noOfTasks > 0) {
          _isDataLoading = false;
          _loading = false;
          _isDataExist = false;
          notifyListeners();
        } else {
          _currentPage = 1;

          _isDataExist = false;
          _loading = false;
          _isDataLoading = false;
          notifyListeners();
        }
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void initData([PageController? pageController]) {
    _pageController = pageController;
  }
}
