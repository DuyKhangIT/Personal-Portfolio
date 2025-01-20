part of './main_page.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.yellow,
      child: Center(
        child: Text(
          "Box 2: Projects",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
