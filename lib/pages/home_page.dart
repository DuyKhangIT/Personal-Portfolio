part of './main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
                      TextSpan(
                        text: "Hi, I'm Khang",
                        style: TextStyleUtils.bold(30),
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
                SelectableText(
                  "I am a skilled Mobile Engineer with 3 years of experience, specializing in Flutter development. With a strong background in application development and software performance optimization, I remain committed to staying updated with emerging technologies and continuously refining my expertise. My ability to perform efficiently under pressure and quickly resolve challenges ensures the delivery of high-quality results within deadlines. Driven by a dedication to sustainable growth and continuous improvement, I am confident in my ability to contribute significant value to the company.",
                  style: TextStyleUtils.regular(12),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30.h),
                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/svg/ic_location.svg',
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 10.w),
                    SelectableText(
                      "Ho Chi Minh, Viet Nam.",
                      style: TextStyleUtils.regular(12),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorUtils.green500,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Available",
                      style: TextStyleUtils.regular(12),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.justify,
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
