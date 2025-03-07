part of './main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 80.h),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 40.h,
            spacing: 10.w,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  width: 300,
                  height: 347,
                  'assets/images/png/avatars.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 40.w),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: TextViewUtils.titleBold(
                              text: AppText.hi,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(width: 10.w)),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Image.asset(
                                'assets/images/gif/ic_hi.gif',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    //
                    TextViewUtils.descriptionsRegular(
                      text: AppText.summaryInfo,
                    ),
                    SizedBox(height: 30.h),
                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/svg/ic_location.svg',
                          width: 20,
                          height: 20,
                          color: state.themeMode == ThemeMode.dark
                              ? ColorUtils.gray50
                              : ColorUtils.gray800,
                        ),
                        SizedBox(width: 10.w),
                        TextViewUtils.descriptionsRegular(
                          text: AppText.address,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 2.w),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 0.4,
                              color: const Color(0xff4CAF50),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Center(
                              child: Container(
                                height: 6,
                                width: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xff4CAF50),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        TextViewUtils.descriptionsRegular(
                          text: AppText.available,
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    //
                    Row(
                      children: [
                        socialContact(
                          path: 'assets/images/png/ic_github.png',
                          onTap: () {
                            OpenWeb.openURL('https://github.com/DuyKhangIT');
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: socialContact(
                            path: 'assets/images/png/ic_linkedin.png',
                            onTap: () {
                              OpenWeb.openURL(
                                  'https://www.linkedin.com/in/khang-huynh-15b0b1248/');
                            },
                          ),
                        ),
                        socialContact(
                          path: 'assets/images/png/ic_facebook.png',
                          onTap: () {
                            OpenWeb.openURL(
                                'https://www.facebook.com/duy.khang.155935/');
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget socialContact({required String path, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      child: Image.asset(
        path,
        width: 30,
        height: 30,
      ),
    );
  }
}
