part of './main_page.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.orange,
      child: Center(
        child: Text(
          " Experience",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
