part of './main_page.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.pink,
      child: Center(
        child: Text(
          "Box 2: Contact",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
