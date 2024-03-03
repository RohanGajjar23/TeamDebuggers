import 'dart:developer';

import 'package:eventapp/model/event_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class BlockChain {
  late Client httpClient;
  late Web3Client ethClient;
  bool data = false;
  int myAmount = 0;

  // var myData;

  final myAddress = "0xd9B19f4D1d5E0A7F9c0F1D8165225683821C47d2";
  final recipientAddress = "0x036799E6F0E945007896486E8BC6c226cad2c25d";
  final contractAddress = "0x2475a97B4f09d6802548FA32aBebF73c5e2Af9E2";
  final privateKey =
      "b2322273918035261d18717dc29b6c8bf0e50cc415ff8823c30f32910a4eb3cf";

  void initBlockChain() {
    httpClient = Client();
    ethClient = Web3Client(
        "https://sepolia.infura.io/v3/f7971deecbb34099b6e3b9b65c5e50f0",
        httpClient);
    log("I got http and eth");
  }

  Future<void> createEventFirebase(EventModel event) async {
    await EventModel.storeEventData(event);
  }

  Future<DeployedContract> loadEventTicketingContract() async {
    final String abiCode = await rootBundle.loadString('assets/json/abi.json');

    final contract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'EventTicketing'),
      EthereumAddress.fromHex(contractAddress),
    );

    return contract;
  }

  Future<void> verifyEventCreated(int eventId) async {
    final contract = await loadEventTicketingContract();
    final getEventDetailsFunction = contract.function('getEventDetails');

    final result = await ethClient.call(
      contract: contract,
      function: getEventDetailsFunction,
      params: [BigInt.from(eventId)],
    );

    log("Event Details: ${result[0]}, Date: ${result[1]}, Ticket Price: ${result[2]}, Total Tickets: ${result[3]},Total Tickets Sold: ${result[4]}");
  }

  Future<void> purchaseTicket(int eventId, int quantity) async {
    final contract = await loadEventTicketingContract();
    final purchaseTicketFunction = contract.function('purchaseTicket');

    final credentials = EthPrivateKey.fromHex(privateKey);
    final totalTicketPriceInWei = BigInt.from(0.0025 * quantity * 1e18);

    final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: purchaseTicketFunction,
        parameters: [BigInt.from(eventId), BigInt.from(quantity)],
        value: EtherAmount.inWei(totalTicketPriceInWei),
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true,
    );
    log("Transaction : $result");
  }

  Future<void> createAndVerifyEvent(
      String name,
      String date,
      double ticketPrice,
      int totalTickets,
      Status currentStatus,
      EventModel event) async {
    final contract = await loadEventTicketingContract();
    final createEventFunction = contract.function('createEvent');
    final priceInWei = BigInt.from(ticketPrice * 1e18);

    int statusValue = currentStatus.index;

    final credentials = EthPrivateKey.fromHex(privateKey);
    final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: createEventFunction,
        parameters: [
          name,
          date,
          priceInWei,
          BigInt.from(totalTickets),
          BigInt.from(statusValue)
        ],
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true,
    );
    log("Transaction : $result");
    await createEventFirebase(event);
    await Future.delayed(const Duration(seconds: 20));
    final currentEventId = (await ethClient.call(
        contract: contract,
        function: contract.function('nextEventId'),
        params: []))[0] as BigInt;
    -BigInt.one;
    await verifyEventCreated(currentEventId.toInt());
  }

  Future<int> getTicketsOwned(int eventId, String userAddress) async {
    final contract = await loadEventTicketingContract();
    final getTicketsOwnedFunction = contract.function('getTicketsOwned');

    final result = await ethClient.call(
      contract: contract,
      function: getTicketsOwnedFunction,
      params: [BigInt.from(eventId), EthereumAddress.fromHex(userAddress)],
    );

    return (result.first as BigInt).toInt();
  }
}
