import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/no_task_widget.dart';
import '../widgets/post_item_widget.dart';

class HomeStudentPage extends StatelessWidget {
  static const routeName = '/homeStudentPage';

  const HomeStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: true
            ? ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  endIndent: 20.w,
                  indent: 20.w,
                ),
                itemCount: 5,
                itemBuilder: (context, index) => const PostItemWidget(
                  caption:
                      'Hey There I am Ahmad Abbas , And i am good doctor in dental',
                  commentsCount: 5,
                  likesCount: 5,
                  postDate: 'Feb 14,2024',
                  images: [
                    'https://th.bing.com/th/id/OIP.TGyiAEuPn8zz0Sp-PrA7qgHaE8?w=262&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                    'https://th.bing.com/th/id/OIP.6NzSWXrfsJdY2M1ep17V5AHaEK?w=272&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                    'https://th.bing.com/th/id/OIP.LM4pX1UDBxpo77kgicT9CwHaHa?w=202&h=202&c=7&r=0&o=5&dpr=1.3&pid=1.7'
                  ],
                  userName: 'Ahmad Abbas',
                ),
              )
            : NoTaskWidget(),
      ),
    );
  }
}
