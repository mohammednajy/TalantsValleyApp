class TransferModel {
  final String id;
  final int amount;
  final String typeWithdraw;
  final String status;
  final String recipientName;
  final String createdAt;
  final String updatedAt;

  TransferModel({
    required this.id,
    required this.amount,
    required this.typeWithdraw,
    required this.status,
    required this.recipientName,
    required this.createdAt,
    required this.updatedAt,
  });
}

class TransferCashModel extends TransferModel {
  final Map office;
  TransferCashModel(
      {required super.id,
      required super.amount,
      required super.typeWithdraw,
      required super.status,
      required super.recipientName,
      required super.createdAt,
      required super.updatedAt,
      required this.office});

  factory TransferCashModel.fromJson(Map<String, dynamic> map) {
    return TransferCashModel(
      id: map["_id"],
      amount: map["amount"],
      office: map["office"],
      typeWithdraw: map["typeWithdraw"],
      status: map["status"],
      recipientName: map["recipientName"],
      createdAt: map["createdAt"],
      updatedAt: map["updatedAt"],
    );
  }

  @override
  String toString() {
    return 'id $id , amount $amount , office $office , typeWithdrow $typeWithdraw , status $status , recipientName $recipientName , createdAt $createdAt , updatedAt $updatedAt';
  }
}

class TransferBankModel extends TransferModel {
  final Map bank;
  TransferBankModel(
      {required super.id,
      required super.amount,
      required super.typeWithdraw,
      required super.status,
      required super.recipientName,
      required super.createdAt,
      required super.updatedAt,
      required this.bank});

  factory TransferBankModel.fromJson(Map<String, dynamic> map) {
    return TransferBankModel(
      id: map["_id"],
      amount: map["amount"],
      bank: map["bank"],
      typeWithdraw: map["typeWithdraw"],
      status: map["status"],
      recipientName: '',
      createdAt: map["createdAt"],
      updatedAt: map["updatedAt"],
    );
  }

  @override
  String toString() {
    return 'id $id , amount $amount , bank $bank , typeWithdrow $typeWithdraw , status $status , createdAt $createdAt , updatedAt $updatedAt';
  }
}
