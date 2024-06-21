
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/core/widgets/loading_widget.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/no_task_widget.dart';
import 'package:oralsync/features/messages_feature/presentation/manager/messages_cubit/messages_cubit.dart';
import 'package:oralsync/features/messages_feature/presentation/pages/chat_page.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/widgets/custom_search_widget.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ServiceLocator.instance<MessagesCubit>()..getStartMessages(),
      child: BlocConsumer<MessagesCubit, MessagesState>(
        listener: (context, state) {
          if (state is FetchStartMessagesError) {
            showCustomSnackBar(
              context,
              msg: isArabic(context)
                  ? state.responseModel.messageAr ?? ''
                  : state.responseModel.messageEn ?? '',
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<MessagesCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CustomSearchWidget(
                    searchTextController: cubit.searchController,
                    onSearch: (value) => cubit.searchMessages(value),
                    onPressClear: (){
                      cubit.searchMessages('');
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    LocaleKeys.chats.tr(),
                    style: AppStyles.styleSize28.copyWith(fontSize: 24),
                  ),
                ),
                Visibility(
                  visible: state is! FetchStartMessagesLoading,
                  replacement: SliverToBoxAdapter(
                    child: Center(
                      child: LoadingWidget(),
                    ),
                  ),
                  child: Visibility(
                    replacement: SliverToBoxAdapter(
                      child: Center(
                        child: NoTaskWidget(
                            title: LocaleKeys.there_is_no_any_notifications),
                      ),
                    ),
                    visible: cubit.messages.isNotEmpty,
                    child: SliverList.builder(
                      itemBuilder: (context, index) =>cubit.searchController.text.isEmpty? ListTile(
                        title: Text(
                          cubit.checkRole()
                              ? cubit.messages[index].sender?.name ?? ''
                              : cubit.messages[index].receiver?.name ?? '',
                        ),
                        subtitle: const Text(
                          'Last Message ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Hero(
                          tag: index,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(cubit.checkRole()
                                ? cubit.messages[index].sender?.profileImage ??
                                    ''
                                : cubit.messages[index].receiver
                                        ?.profileImage ??
                                    ''),
                          ),
                        ),
                        onTap: () {
                          context.pushNamed(ChatPage.routeName, arguments: [
                            index,
                            cubit.messages[index].receiver?.profileImage ?? '',
                            cubit.messages[index].sender?.id ?? '',
                            cubit.messages[index].receiver?.id ?? '',
                            !cubit.checkRole(),
                            cubit.checkRole()
                                ? cubit.messages[index].sender?.name ?? ''
                                : cubit.messages[index].receiver?.name ?? ''
                          ]);
                        },
                      ):ListTile(
                        title: Text(
                          cubit.checkRole()
                              ? cubit.searchingMessages[index].sender?.name ?? ''
                              : cubit.searchingMessages[index].receiver?.name ?? '',
                        ),
                        subtitle: const Text(
                          'Last Message ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Hero(
                          tag: index,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(cubit.checkRole()
                                ? cubit.searchingMessages[index].sender?.profileImage ??
                                ''
                                : cubit.searchingMessages[index].receiver
                                ?.profileImage ??
                                ''),
                          ),
                        ),
                        onTap: () {
                          context.pushNamed(ChatPage.routeName, arguments: [
                            index,
                            cubit.searchingMessages[index].receiver?.profileImage ?? '',
                            cubit.searchingMessages[index].sender?.id ?? '',
                            cubit.searchingMessages[index].receiver?.id ?? '',
                            !cubit.checkRole(),
                            cubit.checkRole()
                                ? cubit.searchingMessages[index].sender?.name ?? ''
                                : cubit.searchingMessages[index].receiver?.name ?? ''
                          ]);
                        },
                      ),
                      itemCount: cubit.searchController.text.isEmpty
                          ? cubit.messages.length
                          : cubit.searchingMessages.length,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
