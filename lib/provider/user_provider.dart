
import 'package:flutter/foundation.dart';

import '../models/my_user.dart';

class UserProvider extends ChangeNotifier{
  //todo: data - function
  MyUser ? currentUser;
  void updateUser(MyUser newUser){
    currentUser=newUser;
    notifyListeners();
  }
}