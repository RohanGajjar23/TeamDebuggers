import 'dart:convert';

import 'package:http/http.dart' as http;

class EtherScanApi {
  static Future<Map<String, dynamic>> getTransactionReceiptStatus(
      String txHash) async {
    const _apikey = "9Z74NA3QKCFX8EPGT8FHKUS98X2E3WN23E";

    const baseUrl = 'https://api.etherscan.io/api';
    final url = Uri.parse(
        '$baseUrl?module=transaction&action=gettxreceiptstatus&txhash=$txHash&apikey=$_apikey');
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        return json.decode(response.body);
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load transaction receipt status');
      }
    } catch (e) {
      return {
        "status": "1",
        "message": e.toString(),
        "result": {"status": "0"}
      };
    }
  }
}
