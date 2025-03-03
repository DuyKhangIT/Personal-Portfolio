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
              SizedBox(height: 15.h),
              TextViewUtils.descriptionsRegular(
                text: AppText.experienceDes,
              ),
              SizedBox(height: 40.h),
              const ExperienceCard(
                icon: 'assets/images/png/ic_ecr.png',
                title: "Mobile Developer (Flutter)",
                company: "ECR Company",
                date: "February 2024 - Present",
                description:
                    "Working on various projects, concentrating on frontend development.",
              ),
              SizedBox(height: 20.h),
              const ExperienceCard(
                icon: 'assets/images/png/ic_ecr.png',
                title: "Mobile Developer (Flutter)",
                company: "ECR Company",
                date: "February 2024 - Present",
                description:
                    "Leading a team of developers, focusing on project management.",
              ),
              SizedBox(height: 20.h),
              const ExperienceCard(
                icon: 'assets/images/png/ic_ecaraid.png',
                title: "Mobile Developer (Flutter)",
                company: "EcarAid",
                date: "June 2022 - January 2024",
                description:
                    "Handling full-stack development tasks across multiple projects.",
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
  final String description;
  const ExperienceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.company,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: state.themeMode == ThemeMode.dark
                ? ColorUtils.gray700
                : ColorUtils.whiteDefault,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  icon,
                  width: 90,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                Spacer(),
                Column(
                  children: [
                    TextViewUtils.selectTitleBold(text: title, fontSize: 16),
                    SizedBox(height: 10.h),
                    Text(description),
                  ],
                ),
                Spacer(),
                Text(
                  date,
                  style:
                      TextStyleUtils.regular(14).copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
