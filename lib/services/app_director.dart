import 'imports.dart';

class AppDirector extends StatelessWidget {
  const AppDirector({Key? key}) : super(key: key);
  static const id = 'AppDirector';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);

    return user?.uid == null
        ? const LoginScreen()
        : MultiProvider(
            providers: [
              StreamProvider<UserData?>.value(
                value: DatabaseUser().userData(uid: user!.uid!),
                initialData: null,
              ),
            ],
            child: StaffHomepage(),
          );
  }
}
