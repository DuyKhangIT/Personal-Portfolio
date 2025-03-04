part of './main_page.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Container(
          color: state.themeMode == ThemeMode.dark
              ? Colors.black.withOpacity(0.2)
              : ColorUtils.gray50,
          padding: EdgeInsets.symmetric(vertical: 140.h, horizontal: 130.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextViewUtils.titleBold(
                text: AppText.experience,
              ),
              SizedBox(height: 20.h),
              TextViewUtils.descriptionsRegular(
                text: AppText.experienceDes,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              const ExperienceCard(
                icon: 'assets/images/png/ic_ecr.png',
                title: "Rail Pro App - Mobile Developer (Flutter)",
                company: "ECR Company",
                date: "February 2024 - Present",
                descriptions: [
                  "Synced server data to local databases (Hive, Floor).",
                  "Implemented lazy loading for product lists and email/SMS notifications",
                  "Developed End of Day functionality to summarize and push data to the server",
                  "Handled order tracking and API configurations with Retrofit",
                  "Build and deploy App on Testflight",
                  "Support UI design for applications with Designer",
                  "Support manual testing with QC",
                  "Support testing API with BE",
                  "Meeting and discussing with Teams",
                ],
              ),
              SizedBox(height: 30.h),
              const ExperienceCard(
                icon: 'assets/images/png/ic_ecr.png',
                title: "IMPL App - Mobile Developer (Flutter)",
                company: "ECR Company",
                date: "February 2024 - Present",
                descriptions: [
                  "Built OCR for scanning package labels",
                  "Setup Sentry tool (monitoring and error detection)",
                  "Handle upload file, camera (Flutter MethodChannel + Kotlin code)",
                  "Managed local and Firebase notifications.",
                ],
              ),
              SizedBox(height: 30.h),
              const ExperienceCard(
                icon: 'assets/images/png/ic_ecaraid.png',
                title: "Mobile Developer (Flutter)",
                company: "EcarAid",
                date: "June 2022 - January 2024",
                descriptions: [
                  "Integrated GPT chat and handled Firebase notifications",
                  "Built booking features for car repairs and chat functionality",
                  "Implemented car club membership and QR code sharing.",
                  "Build and deploy app on AppCenter",
                  "Daily meeting",
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final String icon;
  final String title;
  final String company;
  final String date;
  final List<String> descriptions;
  const ExperienceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.company,
    required this.date,
    required this.descriptions,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: state.themeMode == ThemeMode.dark
                ? ColorUtils.blackDefault
                : ColorUtils.gray200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  width: 220,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20.h),
                TextViewUtils.selectTitleBold(
                  text: title,
                  fontSize: 20,
                ),
                SizedBox(height: 20.h),
                Text(
                  date,
                  style: TextStyleUtils.regular(14).copyWith(
                    color: state.themeMode == ThemeMode.dark
                        ? ColorUtils.gray100
                        : ColorUtils.gray900,
                  ),
                ),
                SizedBox(height: 20.h),
                ListView.builder(
                  itemCount: descriptions.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 30.w),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: state.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Expanded(
                            child: TextViewUtils.descriptionsRegular(
                              text: descriptions[index],
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
