part of './main_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Container(
          color: state.themeMode == ThemeMode.dark
              ? Colors.black.withOpacity(0.2)
              : ColorUtils.gray50,
          padding: EdgeInsets.symmetric(vertical: 140.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: TextViewUtils.titleBold(
                  text: AppText.aboutMe,
                ),
              ),
              SizedBox(height: 80.h),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 40.h,
                spacing: 10.w,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/png/avt.png',
                      width: 300,
                      height: 347,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 40.w),
                  SizedBox(
                    width: width / 1.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
