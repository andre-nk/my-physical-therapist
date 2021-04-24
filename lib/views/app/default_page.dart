part of '../view.dart';

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {

  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {

      final authProvider = watch(authenticationProvider);
      final firestoreProvider = watch(firebaseFirestoreProvider);
      final userFirestoreProvider = watch(userProvider);

      firestoreProvider
        .collection('users')
        .doc(authProvider.auth.currentUser?.uid)
        .get().then((value) async {
          if(!(value.exists)){
            await userFirestoreProvider.createUserData(
              authProvider.auth.currentUser?.uid ?? "",
              name:  authProvider.auth.currentUser?.displayName ?? ""
            );
          }
        }
      );

      void onTabTapped(int index) {
        setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500), curve: Curves.easeOut
          );
        });
      }

      return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: <Widget>[
              HomePage(),
              HomePage(),
              HomePage()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: onTabTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: "a", 
              icon: Icon(CupertinoIcons.house, color: Palette.secondary, size: 24),
              activeIcon: Icon(CupertinoIcons.house_fill, color: Palette.primary, size: 24)
            ),
            BottomNavigationBarItem(
              label: "a", 
              icon: Icon(Icons.calendar_today_outlined, color: Palette.primary.withOpacity(0.4), size: 24),
              activeIcon: Icon(Icons.calendar_today_rounded, color: Palette.secondary, size: 24)
            ),
            BottomNavigationBarItem(
              label: "a", 
              icon: Icon(Icons.calendar_today_outlined, color: Palette.primary.withOpacity(0.4), size: 24),
              activeIcon: Icon(Icons.calendar_today_rounded, color: Palette.secondary, size: 24)
            ),
          ],
        ),
      );

      // return SafeArea(
      //   child: Scaffold(
      //     body: ElevatedButton(
      //       onPressed: () async {
      //         await authProvider.signOutWithEmailAndPassword()
      //           .whenComplete((){
      //             Get.offAndToNamed("/auth");
      //           });
      //       },
      //       child: Text("Log out")),
      //   ),
      // );
    });
  }
}
