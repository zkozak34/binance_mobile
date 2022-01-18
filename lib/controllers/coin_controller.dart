import 'dart:async';
import 'dart:convert';

import 'package:binance_mobile/models/coin.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CoinController extends GetxController {
  final _coins = <Coin>[].obs;
  var url = Uri.parse("https://api.binance.com/api/v1/ticker/24hr");

  @override
  void onInit() {
    super.onInit();
    getCoins();
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await getCoins();
    });
  }

  getCoins() async {
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        _coins.clear();
        var coinJson = jsonDecode(response.body);
        for (var coin in coinJson) {
          if (coin['symbol'].toLowerCase().contains('usdt')) {
            _coins.add(Coin.fromJson(coin));
          }
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<Coin> get coins => _coins;
}
