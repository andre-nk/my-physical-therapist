part of '../../view.dart';

class UserDefaultPage extends StatefulWidget {

  final UserModelSimplified userModelSimplified;

  const UserDefaultPage({Key? key, required this.userModelSimplified}) : super(key: key);

  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<UserDefaultPage> {

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
        body: SizedBox.expand(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: <Widget>[
              UserHomePage(userModelSimplified: widget.userModelSimplified),
              UserPatientEducationPage(userModelSimplified: widget.userModelSimplified),
              UserHomePage(userModelSimplified: widget.userModelSimplified),
              UserGoalPage(widget.userModelSimplified),
              UserHomePage(userModelSimplified: widget.userModelSimplified),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: _selectedIndex == 2 ? Palette.primary : Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: onTabTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: "a", 
              icon: Icon(CupertinoIcons.doc_text_search, color: Palette.secondary, size: 24),
              activeIcon: Icon(CupertinoIcons.doc_text_search, color: Palette.primary, size: 24)
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
      );
    });
  }
}
