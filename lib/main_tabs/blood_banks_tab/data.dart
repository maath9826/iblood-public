import 'package:faker/faker.dart';

const List<BloodBank> bloodBanks = [
  BloodBank(id:0,label:'Baghdad Blood Bank'),
  BloodBank(id:1,label:'Dhi Qar Blood Bank'),
  BloodBank(id:2,label:'Babylon Blood Bank'),
  BloodBank(id:3,label:'Diyala Blood Bank'),
];


// List<BloodBag> availableBloodBags = [
//   BloodBag(id:0,label:'A+',amount: faker.randomGenerator.integer(10,min: 0)),
//   BloodBag(id:1,label:'A-',amount: faker.randomGenerator.integer(10,min: 0)),
//   BloodBag(id:2,label:'B+',amount: faker.randomGenerator.integer(10,min: 0)),
//   BloodBag(id:3,label:'B-',amount: 0),
//   BloodBag(id:4,label:'AB+',amount: faker.randomGenerator.integer(10,min: 0)),
//   BloodBag(id:5,label:'AB-',amount: faker.randomGenerator.integer(10,min: 0)),
//   BloodBag(id:6,label:'O+',amount: faker.randomGenerator.integer(10,min: 0)),
//   BloodBag(id:7,label:'O-',amount: faker.randomGenerator.integer(10,min: 0)),
// ];

class BloodBag{
  final String label;
  final int amount;
  const BloodBag({required this.label,required this.amount});
}

class BloodBank{
  final int id;
  final String label;
  const BloodBank({required this.id,required this.label});
}