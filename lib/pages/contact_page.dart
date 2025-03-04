part of './main_page.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 140.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextViewUtils.titleBold(text: "Contact"),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: TextViewUtils.descriptionsRegular(
                text: AppText.contactDes, textAlign: TextAlign.center),
          ),
          SizedBox(height: 30.h),
          contentRow(
            icon: 'assets/images/svg/ic_mail.svg',
            content: 'huynhduykhang2001gv@gmail.com',
          ),
          contentRow(
            icon: 'assets/images/svg/ic_telephone.svg',
            content: '+84-762449965',
          ),
        ],
      ),
    );
  }

  Widget contentRow({
    required String icon,
    required String content,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 120.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              content,
              style: TextStyleUtils.bold(20),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              copyToClipboard(content);
            },
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/images/svg/ic_copy.svg',
              width: 35,
              height: 35,
            ),
          ),
        ],
      ),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
