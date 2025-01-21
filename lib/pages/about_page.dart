part of './main_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Container(
          color: state.themeMode == ThemeMode.dark
              ? Colors.black.withOpacity(0.2)
              : ColorUtils.gray50,
          padding: EdgeInsets.symmetric(vertical: 150.h, horizontal: 130.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextViewUtils.titleBold(
                  text: "About Me",
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/png/ic_linkedin.png',
                      width: (width / 6).w,
                      height: (height / 2).h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 120.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Curious about me? Here you have it:",
                            style: TextStyleUtils.semiBold(22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextViewUtils.descriptionsRegular(
                          text:
                              "I'm a passionate, self-proclaimed designer who specializes in full stack development (React.js & Node.js). I am very enthusiastic about bringing the technical and visual aspects of digital products to life. User experience, pixel perfect design, and writing clear, readable, highly performant code matters to me.",
                        ),
                        SizedBox(height: 20.h),
                        TextViewUtils.descriptionsRegular(
                          text:
                              "I'm a passionate, self-proclaimed designer who specializes in full stack development (React.js & Node.js). I am very enthusiastic about bringing the technical and visual aspects of digital products to life. User experience, pixel perfect design, and writing clear, readable, highly performant code matters to me.",
                        ),
                        SizedBox(height: 20.h),
                        TextViewUtils.descriptionsRegular(
                          text:
                              "I'm a passionate, self-proclaimed designer who specializes in full stack development (React.js & Node.js). I am very enthusiastic about bringing the technical and visual aspects of digital products to life. User experience, pixel perfect design, and writing clear, readable, highly performant code matters to me.",
                        ),
                        SizedBox(height: 20.h),
                        TextViewUtils.descriptionsRegular(
                          text:
                              "I'm a passionate, self-proclaimed designer who specializes in full stack development (React.js & Node.js). I am very enthusiastic about bringing the technical and visual aspects of digital products to life. User experience, pixel perfect design, and writing clear, readable, highly performant code matters to me.",
                        ),
                        SizedBox(height: 20.h),
                        TextViewUtils.descriptionsRegular(
                          text:
                              "I'm a passionate, self-proclaimed designer who specializes in full stack development (React.js & Node.js). I am very enthusiastic about bringing the technical and visual aspects of digital products to life. User experience, pixel perfect design, and writing clear, readable, highly performant code matters to me.",
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
