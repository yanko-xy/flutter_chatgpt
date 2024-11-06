import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/conversation_list/conversation_list_page.dart';
import 'package:flutter_chatgpt/pages/demo_page.dart';
import 'package:flutter_chatgpt/pages/my/my_page.dart';
import 'package:flutter_chatgpt/pages/study_page.dart';
import 'package:flutter_chatgpt/pages/wonderful/wonderful_page.dart';
import 'package:login_sdk/utils/navigator_util.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final PageController _controller = PageController(initialPage: 0);
  final defaultColor = Colors.grey;
  var activeColor = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 更新导航器的context，供退出时使用
    NavigatorUtil.updateContext(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ConversationListPage(),
          WonderfulPage(),
          StudyPage(),
          MyPage(),
          DemoPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem("聊天", Icons.chat, 0),
          _bottomItem("精彩", Icons.local_fire_department, 1),
          _bottomItem("学习", Icons.newspaper, 2),
          _bottomItem("我的", Icons.account_circle, 3),
          _bottomItem("测试", Icons.add, 4),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: defaultColor),
      activeIcon: Icon(
        icon,
        color: activeColor,
      ),
      label: title,
    );
  }
}
