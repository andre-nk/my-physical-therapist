part of "widget.dart";

class ChatTile extends StatelessWidget {

  final NetworkImage avatar;
  final String name;
  final String message;
  final DateTime? dateTime;
  final void Function() callback;

  const ChatTile({required this.avatar, required this.name, required this.message, this.dateTime, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callback,
      contentPadding: EdgeInsets.zero,
      leading: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: CircleAvatar(
          backgroundColor: Palette.primary,
          backgroundImage: avatar,
        ),
      ),
      title: Font.out(
        name.length >= 34
          ? name.substring(0, 31) + "..."
          : name,
        fontSize: 18, fontWeight: FontWeight.bold, textAlign: TextAlign.left
      ),
      subtitle: Font.out(
        message.length >= 34
          ? message.substring(0, 31) + "..."
          : message,
        fontSize: 14, 
        fontWeight: FontWeight.normal,
        textAlign: TextAlign.left
      ),
      trailing: Font.out(
        dateTime == null ? "" : DateFormat("HH:mm").format(dateTime ?? DateTime.now()),
        fontSize: 14,
        fontWeight: FontWeight.normal,
        textAlign: TextAlign.left
      ),
    );
  }
}