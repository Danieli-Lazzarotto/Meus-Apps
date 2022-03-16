import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage(this.data, this.mine, {Key? key}) : super(key: key);

  Map<String, dynamic> data;
  final bool mine;

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          widget.mine == false
              ? Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.data["senderPhotoUrl"]),
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: widget.mine
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                widget.data['imgUrl'] != null
                    ? Image.network(
                        widget.data["imgurl"],
                        width: 250,
                      )
                    : Text(
                        widget.data['text'],
                        textAlign:
                            widget.mine ? TextAlign.end : TextAlign.start,
                        style: TextStyle(fontSize: 16),
                      ),
                Text(
                  widget.data["senderName"],
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          widget.mine
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.data["senderPhotoUrl"]),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
