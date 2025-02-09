import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_plate/models/my_user.dart';
import 'package:quick_plate/models/recipe.dart';

class UserNotifier extends StateNotifier<MyUser> {
  UserNotifier(
    String uid,
    String email,
    String name,
    List<Recipe> recipes,
  ) : super(
          MyUser(
            uid: uid,
            email: email,
            name: name,
            recipes: recipes,
          ),
        );

  void setUser(MyUser user) {
    state = user;
  }

  void clearUser() {
    state = MyUser(uid: '', email: '', name: '', recipes: []);
  }

  bool isUserEmpty() {
    return state.uid.isEmpty;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, MyUser>((ref) {
  return UserNotifier('', '', '', []);
});
