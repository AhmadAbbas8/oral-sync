
import 'package:flutter/material.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../home_student_feature/presentation/widgets/post_item_widget.dart';
import '../manager/free_paid_reservation_cubit/free_paid_reservation_cubit.dart';

class CustomFreePostsWidget extends StatefulWidget {
  const CustomFreePostsWidget({
    super.key,
    required this.cubit,
  });

  final FreePaidReservationCubit cubit;

  @override
  State<CustomFreePostsWidget> createState() => _CustomFreePostsWidgetState();
}

class _CustomFreePostsWidgetState extends State<CustomFreePostsWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cubit.reachMax
          ? widget.cubit.freePosts.length
          : widget.cubit.freePosts.length + 1,
      controller: _scrollController,
      itemBuilder: (context, index) => index >= widget.cubit.freePosts.length
          ? const LoadingWidget()
          : PostItemWidget(
        userName: widget.cubit.freePosts[index].userName ?? '',
        postDate: widget.cubit.freePosts[index].dateCreated ?? '',
        caption: widget.cubit.freePosts[index].content ?? '',
        images: widget.cubit.freePosts[index].image ?? [],
        likesCount: widget.cubit.freePosts[index].likeCount?.toInt() ?? 0,
        commentsCount:
        widget.cubit.freePosts[index].comments?.length ?? 0,
        profileURL:
        'http://graduationprt22-001-site1.gtempurl.com/Profile/default/male.png',

      ),
    );
  }

  void _onScroll() {
    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (currentScroll >= maxScroll) {
      widget.cubit.getFreePosts();
    }
  }
}