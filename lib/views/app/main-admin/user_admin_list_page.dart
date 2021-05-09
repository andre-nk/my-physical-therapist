part of '../../view.dart';

class UserAdminList extends StatefulWidget {
  @override
  _UserAdminListState createState() => _UserAdminListState();
}

class _UserAdminListState extends State<UserAdminList> {

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
    return Consumer(
      builder: (context, watch, _){
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
                UserList(),
                AdminList()
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: onTabTapped,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: Font.style(fontSize: 14, fontWeight: FontWeight.bold, color: Palette.primary),
            unselectedLabelStyle: Font.style(fontSize: 14, fontWeight: FontWeight.normal, color: Palette.primary),
            items: [
              BottomNavigationBarItem(
                label: "Users", 
                icon: Icon(CupertinoIcons.person, color: Palette.secondary, size: 24),
                activeIcon: Icon(CupertinoIcons.person_fill, color: Palette.primary, size: 24)
              ),
              BottomNavigationBarItem(
                label: "Admins", 
                icon: Icon(CupertinoIcons.person_3, color: Palette.secondary, size: 24),
                activeIcon: Icon(CupertinoIcons.person_3_fill, color: Palette.primary, size: 24)
              ),
            ],
          )
        );
      },
    );
  }
}