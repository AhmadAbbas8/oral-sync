import 'dart:io';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/utils/icon_broken.dart';

import 'package:oralsync/core/widgets/loading_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.index,
    required this.userId,
    required this.receiverId,
    required this.imageUrl,
    required this.isPatient,
    required this.userName,
  }) : super(key: key);

  final int index;
  final String userId;
  final String receiverId;
  final String imageUrl;
  final String userName;
  final bool isPatient;

  static const routeName = '/chatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  String get _chatId => _getChatId(widget.userId, widget.receiverId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            Hero(
              tag: widget.index,
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
            ),
            SizedBox(width: 15.w),
            Text(
              widget.userName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .where('chatId', isEqualTo: _chatId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                log(snapshot.data?.docs
                        .map((e) => [e['receiverId'], e['senderId']])
                        .toList()
                        .toString() ??
                    '');
                if (!snapshot.hasData) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    var message = messages[index];
                    var isMe = message['senderId'] == widget.userId;
                    if (message['imageUrl'] != null) {
                      return ListTile(
                        title: Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await showImageViewer(
                                  context,
                                  CachedNetworkImageProvider(
                                      message['imageUrl']),
                                  swipeDismissible: true,
                                  doubleTapZoomable: true,
                                  useSafeArea: true,
                                );
                              },
                              child: FancyShimmerImage(
                                imageUrl: message['imageUrl'],
                                // fit: BoxFit.cover,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListTile(
                        title: Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: !isMe
                                ?isArabic(context)?CrossAxisAlignment.end: CrossAxisAlignment.start
                                :isArabic(context)?CrossAxisAlignment.start:  CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isMe ? Colors.blue : Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: isMe
                                        ? const Radius.circular(15)
                                        : Radius.zero,
                                    bottomRight: isMe
                                        ? Radius.zero
                                        : const Radius.circular(15),
                                    topRight: const Radius.circular(15),
                                    topLeft: const Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  message['text'],
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                DateFormat('hh:mm:ss mm/dd/yyy').format(
                                    (message['timestamp'] ??
                                            Timestamp(5, 5) as Timestamp)
                                        .toDate()),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(IconBroken.Image_2),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                        hintText: LocaleKeys.type_message.tr(),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey.withOpacity(0.2),
                        filled: true,

                    ), minLines: 1,
                    maxLines: 3,
                  ),
                ),
                IconButton(
                  icon: const Icon(IconBroken.Send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getChatId(String userId, String receiverId) {
    return userId.hashCode <= receiverId.hashCode
        ? '$userId-$receiverId'
        : '$receiverId-$userId';
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('chats').add({
        'text': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'senderId': widget.isPatient ? widget.userId : widget.receiverId,
        'receiverId': widget.isPatient ? widget.userId : widget.receiverId,
        'chatId': _chatId,
        'imageUrl': null,
      });
      _messageController.clear();
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });
      File imageFile = File(pickedFile.path);
      await _uploadImage(imageFile);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      var uploadTask = await FirebaseStorage.instance
          .ref()
          .child('chat_images/${Uri.file(imageFile.path).pathSegments.last}')
          .putFile(imageFile);
      log('here ---');

      // TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await uploadTask.ref.getDownloadURL();

      FirebaseFirestore.instance.collection('chats').add({
        'text': null,
        'timestamp': FieldValue.serverTimestamp(),
        'senderId': widget.isPatient ? widget.userId : widget.receiverId,
        'receiverId': widget.isPatient ? widget.userId : widget.receiverId,
        'chatId': _chatId,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      log('Error uploading image: ${e.toString()}', name: '-Fire Dtorage');
      log(imageFile.path, name: '-Fire Dtorage');
    }
  }
}
