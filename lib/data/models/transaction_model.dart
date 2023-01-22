import 'dart:convert';

void main(List<String> args) {
  String jsonString = '''
[
            {
                "_id": "2023-01-11",
                "data": [
                    {
                        "_id": "63bec043e47d12917e3e13a5",
                        "invoice": {
                            "client": {
                                "_id": "63bec043e47d12917e3e1399",
                                "firstName": "Mohammed",
                                "lastName": "Mohammed",
                                "email": "Mohammed@gmail.com",
                                "country": "Palestine"
                            },
                            "currency": "USD",
                            "revenue": 0,
                            "fixed": [
                                {
                                    "itemName": "test job",
                                    "description": "test invoice",
                                    "price": 1000,
                                    "_id": "63bec043e47d12917e3e139e"
                                },
                                {
                                    "itemName": "test 2 job",
                                    "description": "test invoice",
                                    "price": 500,
                                    "_id": "63bec043e47d12917e3e139f"
                                }
                            ],
                            "freelancer": {
                                "_id": "634d22cfde2f958029428274",
                                "firstName": "taymaa test",
                                "lastName": "zn"
                            },
                            "invoiceNo": "INV185",
                            "status": "sent"
                        },
                        "updatedAt": "2023-01-11T13:57:33.950Z"
                    },
                    {
                        "_id": "63bebd38a986fdce6374819e",
                        "invoice": {
                            "client": {
                                "_id": "63bebd38a986fdce63748192",
                                "firstName": "Mohammed",
                                "lastName": "Mohammed",
                                "email": "Mohammed@gmail.com",
                                "country": "Palestine"
                            },
                            "currency": "USD",
                            "revenue": 0,
                            "fixed": [
                                {
                                    "itemName": "test job",
                                    "description": "test invoice",
                                    "price": 1000,
                                    "_id": "63bebd38a986fdce63748197"
                                },
                                {
                                    "itemName": "test 2 job",
                                    "description": "test invoice",
                                    "price": 500,
                                    "_id": "63bebd38a986fdce63748198"
                                }
                            ],
                            "freelancer": {
                                "_id": "634d22cfde2f958029428274",
                                "firstName": "taymaa test",
                                "lastName": "zn"
                            },
                            "invoiceNo": "INV184",
                            "status": "sent"
                        },
                        "updatedAt": "2023-01-11T13:44:45.745Z"
                    },
                    {
                        "_id": "63ad7ab4832096914c8ce534",
                        "invoice": {
                            "client": {
                                "firstName": "taymaa client",
                                "lastName": "Alzayyan",
                                "email": "taymaa@gmail.com",
                                "address": {
                                    "country": "Palestine",
                                    "city": "Gaza",
                                    "state": "gaza",
                                    "zipCode": "gaza"
                                },
                                "_id": "635d5d724f772714d74a18ab"
                            },
                            "currency": "USD",
                            "revenue": 0,
                            "fixed": [
                                {
                                    "itemName": "master job",
                                    "description": "test invoice",
                                    "price": 600,
                                    "_id": "63ad7ab3832096914c8ce52f"
                                },
                                {
                                    "itemName": "master job",
                                    "description": "test invoice",
                                    "price": 200,
                                    "_id": "63ad7ab3832096914c8ce530"
                                }
                            ],
                            "freelancer": {
                                "_id": "634d22cfde2f958029428274",
                                "firstName": "taymaa test",
                                "lastName": "zn"
                            },
                            "invoiceNo": "INV163",
                            "status": "unpaid"
                        },
                        "updatedAt": "2023-01-11T13:36:28.246Z"
                    },
                    {
                        "_id": "63beae30eca7cbfc0c4a5641",
                        "invoice": {
                            "client": {
                                "_id": "63beae30eca7cbfc0c4a5635",
                                "firstName": "Mohammed",
                                "lastName": "Mohammed",
                                "email": "Mohammed@gmail.com",
                                "country": "Palestine"
                            },
                            "currency": "USD",
                            "revenue": 0,
                            "fixed": [
                                {
                                    "itemName": "test job",
                                    "description": "test invoice",
                                    "price": 1000,
                                    "_id": "63beae30eca7cbfc0c4a563a"
                                },
                                {
                                    "itemName": "test 2 job",
                                    "description": "test invoice",
                                    "price": 500,
                                    "_id": "63beae30eca7cbfc0c4a563b"
                                }
                            ],
                            "freelancer": {
                                "_id": "634d22cfde2f958029428274",
                                "firstName": "taymaa test",
                                "lastName": "zn"
                            },
                            "invoiceNo": "INV183",
                            "status": "cancelled"
                        },
                        "updatedAt": "2023-01-11T12:41:36.146Z"
                    },
                    {
                        "_id": "63beadfceca7cbfc0c4a5618",
                        "service": {
                            "fixed": [
                                {
                                    "itemName": "prod test job",
                                    "description": "test invoice",
                                    "price": 110,
                                    "_id": "63beadfceca7cbfc0c4a5614"
                                },
                                {
                                    "itemName": "prod test job",
                                    "description": "test invoice",
                                    "price": 200,
                                    "_id": "63beadfceca7cbfc0c4a5615"
                                }
                            ],
                            "currency": "USD",
                            "status": "archived",
                            "revenue": 0,
                            "serviceNo": "LNK-93"
                        },
                        "updatedAt": "2023-01-11T12:39:31.711Z"
                    },
                    {
                        "_id": "63beacb14f7aca40bdad78f1",
                        "service": {
                            "fixed": [
                                {
                                    "itemName": "prode edit",
                                    "description": "test service",
                                    "price": 300,
                                    "_id": "63bead53fdde7abb9c3b966a"
                                },
                                {
                                    "itemName": "edit job",
                                    "description": "test service",
                                    "price": 300,
                                    "_id": "63bead53fdde7abb9c3b966b"
                                }
                            ],
                            "currency": "USD",
                            "status": "archived",
                            "revenue": 0,
                            "serviceNo": "LNK-92"
                        },
                        "updatedAt": "2023-01-11T12:37:44.942Z"
                    },
                    {
                        "_id": "63beab944e25024a4166e64b",
                        "withdraw": {
                            "amount": 10,
                            "office": {
                                "_id": "6310a930d74275d6cdd15be3",
                                "name": "مكتب الدانا"
                            },
                            "typeWithdraw": "cash",
                            "status": "pending"
                        },
                        "updatedAt": "2023-01-11T12:29:08.737Z"
                    },
                    {
                        "_id": "63beaa017747a04f851efbec",
                        "withdraw": {
                            "amount": 10,
                            "office": {
                                "_id": "6310a930d74275d6cdd15be3",
                                "name": "مكتب الدانا"
                            },
                            "typeWithdraw": "cash",
                            "status": "completed"
                        },
                        "updatedAt": "2023-01-11T12:28:37.447Z"
                    },
                    {
                        "_id": "63beaa3a4e25024a4166e620",
                        "withdraw": {
                            "amount": 300,
                            "bank": {
                                "_id": "636348c2a1307bbf9c5073d7",
                                "accountNumber": "20172014"
                            },
                            "typeWithdraw": "bank",
                            "status": "pending"
                        },
                        "updatedAt": "2023-01-11T12:23:22.209Z"
                    },
                    {
                        "_id": "63bea97a8f091507cf36c4d9",
                        "withdraw": {
                            "amount": 10,
                            "office": {
                                "_id": "6310a930d74275d6cdd15be3",
                                "name": "مكتب الدانا"
                            },
                            "typeWithdraw": "cash",
                            "status": "pending"
                        },
                        "updatedAt": "2023-01-11T12:20:10.353Z"
                    }
                ]
            }
        ]
''';

  final json = jsonDecode(jsonString);

 final TransactionModel transactionModel=TransactionModel.fromJson(json);

  print(transactionModel.data!.length);
}

class TransactionModel {
  String? sId;
  List<Data>? data;

  TransactionModel({this.sId, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? sId;
  Invoice? invoice;
  String? updatedAt;
  Service? service;
  Withdraw? withdraw;

  Data({this.sId, this.invoice, this.updatedAt, this.service, this.withdraw});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    invoice =
        json['invoice'] != null ?  Invoice.fromJson(json['invoice']) : null;
    updatedAt = json['updatedAt'];
    service =
        json['service'] != null ?  Service.fromJson(json['service']) : null;
    withdraw = json['withdraw'] != null
        ?  Withdraw.fromJson(json['withdraw'])
        : null;
  }


}

class Invoice {
  Client? client;
  String? currency;
  int? revenue;
  List<Fixed>? fixed;
  Freelancer? freelancer;
  String? invoiceNo;
  String? status;

  Invoice(
      {this.client,
      this.currency,
      this.revenue,
      this.fixed,
      this.freelancer,
      this.invoiceNo,
      this.status});

  Invoice.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ?  Client.fromJson(json['client']) : null;
    currency = json['currency'];
    revenue = json['revenue'];
    if (json['fixed'] != null) {
      fixed = <Fixed>[];
      json['fixed'].forEach((v) {
        fixed!.add( Fixed.fromJson(v));
      });
    }
    freelancer = json['freelancer'] != null
        ?  Freelancer.fromJson(json['freelancer'])
        : null;
    invoiceNo = json['invoiceNo'];
    status = json['status'];
  }


}

class Client {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? country;
  Address? address;

  Client(
      {this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.country,
      this.address});

  Client.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    country = json['country'];
    address =
        json['address'] != null ?  Address.fromJson(json['address']) : null;
  }


}

class Address {
  String? country;
  String? city;
  String? state;
  String? zipCode;

  Address({this.country, this.city, this.state, this.zipCode});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
  }

}

class Fixed {
  String? itemName;
  String? description;
  int? price;
  String? sId;

  Fixed({this.itemName, this.description, this.price, this.sId});

  Fixed.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    description = json['description'];
    price = json['price'];
    sId = json['_id'];
  }

}

class Freelancer {
  String? sId;
  String? firstName;
  String? lastName;

  Freelancer({this.sId, this.firstName, this.lastName});

  Freelancer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }


}

class Service {
  List<Fixed>? fixed;
  String? currency;
  String? status;
  int? revenue;
  String? serviceNo;

  Service(
      {this.fixed, this.currency, this.status, this.revenue, this.serviceNo});

  Service.fromJson(Map<String, dynamic> json) {
    if (json['fixed'] != null) {
      fixed = <Fixed>[];
      json['fixed'].forEach((v) {
        fixed!.add( Fixed.fromJson(v));
      });
    }
    currency = json['currency'];
    status = json['status'];
    revenue = json['revenue'];
    serviceNo = json['serviceNo'];
  }


}

class Withdraw {
  int? amount;
  Office? office;
  String? typeWithdraw;
  String? status;
  Bank? bank;

  Withdraw(
      {this.amount, this.office, this.typeWithdraw, this.status, this.bank});

  Withdraw.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    office =
        json['office'] != null ?  Office.fromJson(json['office']) : null;
    typeWithdraw = json['typeWithdraw'];
    status = json['status'];
    bank = json['bank'] != null ?  Bank.fromJson(json['bank']) : null;
  }

 
}

class Office {
  String? sId;
  String? name;

  Office({this.sId, this.name});

  Office.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

}

class Bank {
  String? sId;
  String? accountNumber;

  Bank({this.sId, this.accountNumber});

  Bank.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accountNumber = json['accountNumber'];
  }
}



// class TransactionModel {
//   final String date;
//   final List<InvoiceModel> transactionList;

//   TransactionModel({required this.date,required this.transactionList,});
  
// factory TransactionModel.fromJson(Map<String ,dynamic> jsonMap){
//   final List<dynamic> jsonList=jsonMap["data"];
  
//   List<InvoiceModel> transactions=jsonList.map((e)=>InvoiceModel.fromJson(e)).toList();
//   return TransactionModel(date: jsonMap["_id"], transactionList: transactions);
// }
// }

// class InvoiceModel {
//   final ClientModel clientModel;
//   final String currency;
//   final int revenue;
//   final List<FixedModel> fixed;
//   final FreelancerModel freelancer;
//   final String invoiceNo;
//   final String status;
//   final String userId;
//   final String updatedAt;

//   InvoiceModel({required this.userId,required this.updatedAt, 
//     required this.clientModel,
//     required this.currency,
//     required this.revenue,
//     required this.fixed,
//     required this.freelancer,
//     required this.invoiceNo,
//     required this.status,
//   });
//   factory InvoiceModel.fromJson(Map<String, dynamic> jsonMap) {
//     final List<dynamic> jsonFixedList = jsonMap["invoice"]["fixed"];
//     List<FixedModel> list =
//         jsonFixedList.map((e) => FixedModel.fromJson(e)).toList();
//     return InvoiceModel(
//       clientModel: ClientModel.fromJson(jsonMap["invoice"]["client"]),
//       currency: jsonMap["invoice"]["currency"],
//       revenue: jsonMap["invoice"]["revenue"],
//       fixed: list,
//       freelancer: FreelancerModel.fromJson(jsonMap["invoice"]["freelancer"]),
//       invoiceNo: jsonMap["invoice"]["invoiceNo"],
//       status: jsonMap["invoice"]["status"], updatedAt:jsonMap["_id"], userId: jsonMap["updatedAt"],
   
//     );
//   }
// }

// class ClientModel {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String country;
//   // final String stringcity;
//   // final String stringstate;
//   // final String stringzipCode;
//   final String id;

//   ClientModel({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.country,
//     // required this.stringcity,
//     // required this.stringstate,
//     // required this.stringzipCode,
//     required this.id,
//   });

//   factory ClientModel.fromJson(Map<String, dynamic> jsonMap) {
//     return ClientModel(
//       firstName: jsonMap["firstName"],
//       lastName: jsonMap["lastName"],
//       email: jsonMap["email"],
//       country: jsonMap["country"],
//       // stringcity: jsonMap["address"]["city"],
//       // stringstate: jsonMap["address"]["state"],
//       // stringzipCode: jsonMap["address"]["zipCode"],
//       id: jsonMap["_id"],
//     );
//   }
// }

// class FixedModel {
//   final String itemName;
//   final String description;
//   final int price;
//   final String id;

//   FixedModel({
//     required this.itemName,
//     required this.description,
//     required this.price,
//     required this.id,
//   });

//   factory FixedModel.fromJson(Map<String, dynamic> jsonMap) {
//     return FixedModel(
//         itemName: jsonMap["itemName"],
//         description: jsonMap["description"],
//         price: jsonMap["price"],
//         id: jsonMap["_id"]);
//   }
// }

// class FreelancerModel {
//   final String id;
//   final String firstName;
//   final String lastName;

//   FreelancerModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//   });

//   factory FreelancerModel.fromJson(Map<String, dynamic> jsonMap) {
//     return FreelancerModel(
//       id: jsonMap["_id"],
//       firstName: jsonMap["firstName"],
//       lastName: jsonMap["lastName"],
//     );
//   }
// }
