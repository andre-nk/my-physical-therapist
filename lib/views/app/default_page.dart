part of '../view.dart';

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {

  int _selectedIndex = 0;
  PageController _pageController = PageController();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut
          );
        });
      }

      return Scaffold(
        key: _drawerKey,
        drawer: Drawer(
          child: Container(
            height: MQuery.height(1, context),
            width: MQuery.width(0.4, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MQuery.height(0.3, context),
                  child: Image.asset("assets/logo.png", fit: BoxFit.contain,)
                ),
                ListTile(
                  onTap: (){
                    final Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'alexleverizabusiness@gmail.com',
                      queryParameters: {
                        'subject': 'Help needed on MyPhysicalTherapist App'
                      }
                    );

                    launch(_emailLaunchUri.toString());
                  },
                  enableFeedback: true,
                  leading: Icon(Icons.live_help_outlined, color: Palette.primary),
                  trailing: Icon(CupertinoIcons.chevron_right),
                  title: Font.out(
                    "Contact us",
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                  )
                ),
                ListTile(
                  onTap: () async {
                    await authProvider.signOutWithEmailAndPassword().whenComplete((){
                      Get.offAndToNamed("/auth");
                    });
                  },
                  enableFeedback: true,
                  leading: Icon(Icons.logout, color: Palette.alert),
                  title: Font.out(
                    "Log out",
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                  )
                )
              ],
            ),
          ),
        ),
        body: SizedBox.expand(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: <Widget>[
              HomePage(_drawerKey),
              PatientEducationPage(_drawerKey),
              GoalPage(_drawerKey),
              ChatPage(_drawerKey)
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
              icon: Icon(CupertinoIcons.book, color: Palette.primary.withOpacity(0.4), size: 24),
              activeIcon: Icon(CupertinoIcons.book_fill, color: Palette.primary, size: 24)
            ),
            BottomNavigationBarItem(
              label: "a", 
              icon: Icon(CupertinoIcons.flag, color: Palette.primary.withOpacity(0.4), size: 24),
              activeIcon: Icon(CupertinoIcons.flag_fill, color: Palette.primary, size: 24)
            ),
            BottomNavigationBarItem(
              label: "a", 
              icon: Icon(CupertinoIcons.chat_bubble, color: Palette.primary.withOpacity(0.4), size: 24),
              activeIcon: Icon(CupertinoIcons.chat_bubble_fill, color: Palette.primary, size: 24)
            ),
          ],
        ),
      );
    });
  }
}
