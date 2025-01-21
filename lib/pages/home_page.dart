part of './main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 112.w, vertical: 80.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: TextViewUtils.titleBold(text: "Hi, I'm Khang"),
                      ),
                      WidgetSpan(child: SizedBox(width: 10.w)),
                      WidgetSpan(
                        child: Image.asset(
                          'assets/images/gif/ic_hi.gif',
                          width: 50,
                          height: 50,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                //
                TextViewUtils.descriptionsRegular(
                    text:
                        'I am a skilled Mobile Engineer with 3 years of experience, specializing in Flutter development. With a strong background in application development and software performance optimization, I remain committed to staying updated with emerging technologies and continuously refining my expertise. My ability to perform efficiently under pressure and quickly resolve challenges ensures the delivery of high-quality results within deadlines. Driven by a dedication to sustainable growth and continuous improvement, I am confident in my ability to contribute significant value to the company.'),
                SizedBox(height: 30.h),
                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/svg/ic_location.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 10.w),
                    TextViewUtils.descriptionsRegular(
                      text: "Ho Chi Minh, Viet Nam.",
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
                      text: "Available",
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                //
                Row(
                  children: [
                    socialContact(
                      path: 'assets/images/png/ic_github.png',
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: socialContact(
                        path: 'assets/images/png/ic_linkedin.png',
                      ),
                    ),
                    socialContact(
                      path: 'assets/images/png/ic_facebook.png',
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 200.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Image.asset(
                width: 290.w,
                height: 347.h,
                'assets/images/png/ic_github.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget socialContact({required String path}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Image.asset(
        path,
        width: 20.w,
        height: 20.h,
      ),
    );
  }
}
