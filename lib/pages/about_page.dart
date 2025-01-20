part of './main_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: ColorUtils.gray50,
      padding: EdgeInsets.symmetric(horizontal: 112.w),
      child: Center(
        child: Text(
          "Box 2: About",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
