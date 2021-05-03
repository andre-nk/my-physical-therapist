part of '../view.dart';

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {

  int _selectedIndex = 0;
  PageController _pageController = PageController();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool _isVisible = true;

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
              HomePage(_drawerKey,
                (){
                  _pageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                }
              ),
              PatientEducationPage(_drawerKey),
              ExercisesPage(_drawerKey,
                (){
                  setState(() {
                    _isVisible = !_isVisible;                    
                  });
                }
              ),
              GoalPage(_drawerKey),
              ChatPage(_drawerKey)
            ],
          ),
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 750),
          height: _isVisible ? 60.0 : 0.0,
          child: _isVisible
          ? AnimatedContainer(
              duration: Duration(milliseconds: 750),
              height: _isVisible ? 60.0 : 0.0,
              child: _isVisible
                ? BottomNavigationBar(
                    backgroundColor: _selectedIndex == 2 ? Palette.primary : Colors.white,
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
                        icon: Icon(CupertinoIcons.book, color: Palette.secondary, size: 24),
                        activeIcon: Icon(CupertinoIcons.book_fill, color: Palette.primary, size: 24)
                      ),
                      BottomNavigationBarItem(
                        label: "a", 
                        icon: Icon(MyPhysicalTherapist.barbell_outlined, color: Palette.secondary, size: 28),
                        activeIcon: Icon(MyPhysicalTherapist.barbell_filled, color: Colors.white, size: 28)
                      ),
                      BottomNavigationBarItem(
                        label: "a", 
                        icon: Icon(CupertinoIcons.flag, color: Palette.secondary, size: 24),
                        activeIcon: Icon(CupertinoIcons.flag_fill, color: Palette.primary, size: 24)
                      ),
                      BottomNavigationBarItem(
                        label: "a", 
                        icon: Icon(CupertinoIcons.chat_bubble, color: Palette.secondary, size: 24),
                        activeIcon: Icon(CupertinoIcons.chat_bubble_fill, color: Palette.primary, size: 24)
                      ),
                    ],
                  )
                : BottomNavigationBar(
                    backgroundColor: _selectedIndex == 2 ? Palette.primary : Colors.white,
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
                        icon: Icon(CupertinoIcons.book, color: Palette.secondary, size: 24),
                        activeIcon: Icon(CupertinoIcons.book_fill, color: Palette.primary, size: 24)
                      ),
                      BottomNavigationBarItem(
                        label: "a", 
                        icon: Icon(MyPhysicalTherapist.barbell_outlined, color: Palette.secondary, size: 28),
                        activeIcon: Icon(MyPhysicalTherapist.barbell_filled, color: Colors.white, size: 28)
                      ),
                      BottomNavigationBarItem(
                        label: "a", 
                        icon: Icon(CupertinoIcons.flag, color: Palette.secondary, size: 24),
                        activeIcon: Icon(CupertinoIcons.flag_fill, color: Palette.primary, size: 24)
                      ),
                      BottomNavigationBarItem(
                        label: "a", 
                        icon: Icon(CupertinoIcons.chat_bubble, color: Palette.secondary, size: 24),
                        activeIcon: Icon(CupertinoIcons.chat_bubble_fill, color: Palette.primary, size: 24)
                      ),
                    ],
                  )
            ) 
          : BottomNavigationBar(
              backgroundColor: _selectedIndex == 2 ? Palette.primary : Colors.white,
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
                  icon: Icon(CupertinoIcons.book, color: Palette.secondary, size: 24),
                  activeIcon: Icon(CupertinoIcons.book_fill, color: Palette.primary, size: 24)
                ),
                BottomNavigationBarItem(
                  label: "a", 
                  icon: Icon(MyPhysicalTherapist.barbell_outlined, color: Palette.secondary, size: 28),
                  activeIcon: Icon(MyPhysicalTherapist.barbell_filled, color: Colors.white, size: 28)
                ),
                BottomNavigationBarItem(
                  label: "a", 
                  icon: Icon(CupertinoIcons.flag, color: Palette.secondary, size: 24),
                  activeIcon: Icon(CupertinoIcons.flag_fill, color: Palette.primary, size: 24)
                ),
                BottomNavigationBarItem(
                  label: "a", 
                  icon: Icon(CupertinoIcons.chat_bubble, color: Palette.secondary, size: 24),
                  activeIcon: Icon(CupertinoIcons.chat_bubble_fill, color: Palette.primary, size: 24)
                ),
              ],
            )
        )
      );
    });
  }
}
