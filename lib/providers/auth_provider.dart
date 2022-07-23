import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:iblood/providers/users_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user/user.dart';

class AuthProvider with ChangeNotifier {
  StreamSubscription? _authStateChangesListener;
  AuthProvider(){
    _authStateChangesListener = _fbAuthInstance.authStateChanges().listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _authStateChangesListener?.cancel();
    super.dispose();
  }

  final firebase_auth.FirebaseAuth _fbAuthInstance = firebase_auth.FirebaseAuth.instance;
  firebase_auth.UserCredential? _fbUserCredential;
  static User? userData;

  Future<bool> get isAuth async {
    if(_fbAuthInstance.currentUser != null){
      await UsersProvider().get(userId).then((value) => userData =  User.fromJson(value.data()!));
      return true;
    }
    return false;
  }


  static String get userId {
    return firebase_auth.FirebaseAuth.instance.currentUser!.uid;
  }

  //firebase auth will automatically login when signup
  Future<void> signup({
    required String email,
    required String password,
    required User user,
  }) async {
    try{
      await _fbAuthInstance.createUserWithEmailAndPassword(email: email, password: password).catchError((onError){
        throw onError;
      });
      await UsersProvider().set(user, userId);
      userData = user;
      notifyListeners();
    }catch(e){
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try{
      await _fbAuthInstance.signInWithEmailAndPassword(email: email, password: password).catchError((onError){
        throw onError;
      });
      userData = User.fromJson((await UsersProvider().get(userId)).data()!);
      notifyListeners();
    }catch(e){
      rethrow;
    }
  }

  Future<void> logout() async {
    await _fbAuthInstance.signOut().catchError((onError)=> throw onError);
    userData = null;
  }
}


// class AuthProvider with ChangeNotifier {
//
//   firebase_auth.FirebaseAuth _authInstance = firebase_auth.FirebaseAuth.instance;
//
//   String? _token, _userId;
//   DateTime? _expiryDate;
//   User? _user;
//   Timer? _authTimer;
//
//   bool get isAuth {
//     return _token != null;
//   }
//
//   // String? get token {
//   //   if (_expiryDate != null &&
//   //       _expiryDate!.isAfter(DateTime.now()) &&
//   //       _token != null) {
//   //     return _token;
//   //   }
//   //   return null;
//   // }
//
//
//   String? get userId {
//     return _userId;
//   }
//
//   Future<void> _authenticate({
//     required String email,
//     required String password,
//     required String urlSegment,
//     User? user,
//   }) async {
//     final url = Uri.parse(
//         'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAi-tBGzPQSQNNc06jTzn8zmH0jvab5Rwc');
//     try {
//       final response = await http.post(
//         url,
//         body: json.encode(
//           {
//             'email': email,
//             'password': password,
//             "returnSecureToken": true,
//           },
//         ),
//       );
//
//       final responseData = json.decode(response.body);
//       if (responseData['error'] != null) {
//         throw HttpException(responseData['error']['message']);
//       }
//       _token = responseData['idToken'];
//       _userId = responseData['localId'];
//       _expiryDate = _createExpiryDate(responseData['expiresIn']);
//       _user = user != null
//           ? await _setUser(user, _userId!).then((_) => user)
//           : User.fromJson((await _getUser(_userId!)).data()!);
//       await _saveUserData();
//       _createTimer();
//       notifyListeners();
//
//     } catch (error) {
//       rethrow;
//     }
//   }
//
//   Future<void> signup({
//     required String email,
//     required String password,
//     required User user,
//   }) async {
//     return _authenticate(
//       email: email,
//       password: password,
//       urlSegment: 'signUp',
//       user: user,
//     );
//   }
//
//   Future<void> login({
//     required String email,
//     required String password,
//   }) async {
//     return _authenticate(
//       email: email,
//       password: password,
//       urlSegment: 'signInWithPassword',
//     );
//   }
//
//   Future<void> logout() async {
//     _token = null;
//     _userId = null;
//     _expiryDate = null;
//     _user = null;
//     if (_authTimer != null) {
//       _authTimer?.cancel();
//       _authTimer = null;
//     }
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//   }
//
//
//   Future<void> _setUser(User user, String userId) async =>
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .set(user.toJson())
//           .catchError((error) {
//         throw error;
//       });
//
//   Future<DocumentSnapshot<Map<String, dynamic>>> _getUser(
//       String userId) async =>
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(_userId)
//           .get()
//           .catchError((error) {
//         throw error;
//       });
//
//   Future autoLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     print("prefs.containsKey('userData'): ${prefs.containsKey('userData')}");
//     if (!prefs.containsKey('userData')) {
//       return null;
//     }
//     final extractedUserData = json.decode(prefs.getString('userData')!);
//     final expiryDate =
//     DateTime.parse(extractedUserData['expiryDate'] as String);
//     print('expiryDate.isBefore(DateTime.now()): ${expiryDate.isBefore(DateTime.now())}');
//     if (expiryDate.isBefore(DateTime.now())) {
//       return false;
//     }
//     _token = extractedUserData['token'] as String;
//     _userId = extractedUserData['userId'] as String;
//     _expiryDate = expiryDate;
//     _user = User.fromInternalLinkedHashMap(
//         json.decode(extractedUserData['user']) as Map<String, dynamic>);
//     _createTimer();
//     notifyListeners();
//   }
//
//   void _createTimer() {
//     if (_authTimer != null) {
//       _authTimer?.cancel();
//     }
//     final timeToExpiry = _expiryDate?.difference(DateTime.now()).inSeconds;
//     _authTimer = Timer(Duration(seconds: timeToExpiry as int), logout);
//   }
//
//   DateTime _createExpiryDate(String expiredIn) => DateTime.now().add(
//     Duration(
//       seconds: int.parse(
//         expiredIn,
//       ),
//     ),
//   );
//
//   Future<void> _saveUserData() async{
//     final prefs = await SharedPreferences.getInstance();
//     final userData = json.encode(
//       {
//         'token': _token,
//         'userId': _userId,
//         'expiryDate': _expiryDate?.toIso8601String(),
//         'user': json.encode(_user!.jsonEncodable),
//       },
//     );
//     prefs.setString('userData', userData);
//   }
// }








