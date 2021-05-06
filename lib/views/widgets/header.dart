part of 'widget.dart';

class Header extends StatelessWidget {

  final Widget content;

  Header({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MQuery.height(0.04, context),
        vertical: MQuery.height(0.03, context),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MQuery.height(0.6, context),
          minWidth: MQuery.width(1, context)
        ),
        child: content
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50)
        ),
        gradient: LinearGradient(
          colors: [
            Palette.primary,
            HexColor("3B5991").withOpacity(0.9)
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight
        )
      ),
    );
  }
}