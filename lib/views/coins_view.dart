import 'dart:ui';

import 'package:binance_mobile/controllers/coin_controller.dart';
import 'package:binance_mobile/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CoinsView extends StatelessWidget {
  const CoinsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoinController _coinController = Get.put(CoinController());
    List<Coin> _coins = _coinController.coins;

    MaterialColor getColor(String price) {
      if (double.parse(price) < 0) {
        return Colors.red;
      } else if (double.parse(price) == 0) {
        return Colors.grey;
      } else if (double.parse(price) > 0) {
        return Colors.green;
      } else {
        return Colors.grey;
      }
    }

    String getChange(String price) {
      if (double.parse(price) > 0) {
        return "+" + double.parse(price).toStringAsFixed(2) + "%";
      } else {
        return double.parse(price).toStringAsFixed(2) + "%";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Koin Listesi"),
      ),
      body: Obx(
        () => _coins.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  semanticsLabel: "Yükleniyor...",
                ),
              )
            : coinList(_coins, getColor, getChange),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          _coinController.getCoins();
        },
      ),
    );
  }

  Widget coinList(
      List<Coin> _coins, MaterialColor Function(String price) getColor, String Function(String price) getChange) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _coins.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _coins[index].symbol.toString().split("USDT")[0],
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  " /USDT",
                  style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  NumberFormat.decimalPattern().format(double.parse(_coins[index].lastPrice)),
                  style: TextStyle(color: getColor(_coins[index].lastPrice)),
                ),
                Text(
                  NumberFormat.decimalPattern().format(double.parse(_coins[index].priceChange)),
                  style: TextStyle(color: getColor(_coins[index].priceChange)),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: getColor(_coins[index].priceChangePercent),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                getChange(_coins[index].priceChangePercent),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );

    // final columns = ["İsim", "Son Fiyat", "Değişim"];
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    //   child: DataTable(columns: getColumn(columns), rows: getRows(_coins)),
    // );
  }

  // List<DataColumn> getColumn(List<String> columns) {
  //   return columns.map((String column) => DataColumn(label: Text(column))).toList();
  // }

  // List<DataRow> getRows(List<Coin> coins) {
  //   coins.map((Coin coin) {
  //     final cells = [coin.symbol, coin.lastPrice, coin.priceChange, coin.priceChangePercent];
  //     return DataRow(cells: getCells(cells));
  //   }).toList();
  // }

  // List<DataCell> getCells(List<dynamic> cells) {
  //   return cells.map((e) => DataCell(Text(e))).toList();
  // }
}
