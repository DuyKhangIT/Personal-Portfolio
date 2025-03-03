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
          padding: EdgeInsets.symmetric(vertical: 140.h, horizontal: 130.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextViewUtils.titleBold(
                  text: AppText.aboutMe,
                ),
              ),
              SizedBox(height: 80.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/png/avt.png',
                      width: (width / 4),
                      height: (height / 2),
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
                            AppText.aboutDes,
                            style: TextStyleUtils.semiBold(22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextViewUtils.descriptionsRegular(
                          text: AppText.aboutMeOne,
                        ),
                        SizedBox(height: 20.h),
                        TextViewUtils.descriptionsRegular(
                          text: AppText.aboutMeTwo,
                        ),
                        SizedBox(height: 20.h),
                        TextViewUtils.descriptionsRegular(
                          text: AppText.aboutMeTh,
                        ),
                        SizedBox(height: 20.h),
                        TextViewUtils.descriptionsRegular(
                          text: AppText.aboutMeFour,
                        ),
                        SizedBox(height: 20.h),
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
