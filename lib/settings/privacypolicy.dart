import 'package:flutter/material.dart';

class Tab extends StatelessWidget {
  final String title;
  final Function f;
  final double w;
  final Widget ic;
  Tab(this.ic, this.title, this.f, this.w);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: f,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: w * 1,
          height: 50,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ic,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 12,
                      color: const Color(0xff2f2e41),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            fontFamily: 'Bell MT',
            fontSize: 24,
            color: const Color(0xfff2f2f2),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontFamily: 'Bell MT',
                  fontSize: 18,
                  color: const Color(0xff2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: w,
              height: MediaQuery.of(context).size.height * 0.8,
              child: SizedBox(
                width: 359.0,
                height: 673.0,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: 359.0,
                    height: 673.0,
                    child: SingleChildScrollView(
                        child: Text(
                      'Effective December 11, 2019\n​\nAt Bradvice Solutions reachable from https://www.sproutingwingsdigitalmarketing.com we consider this as an immense responsibility and make an effort to safeguard the privacy of our visitors with due diligence. This Privacy Policy is an overview of the type of information that we collect, how we use that information, and how you can take control of what you share with us. Provision to update, manipulate and delete their private information is available to the users if they require.\n\n​\n\nSproutingwingsdigitalmarketing.com is a property of SproutingWings, an Indian Company registered under the Companies Act having its registered office at FF-27, Cross Road mall, Central Spine, Vidhyadhar Nagar, Jaipur, Rajasthan, India.\n\n​\n\nInformation Collection\n​\nAt Sprouting Wings, we need you to comprehend the type of information collected and the way in which it is collected when you avail our services. This collection of information is indispensable in order to provide superior services to our users. The type of information collected by Sprouting Wings is governed by the services used by you and the privacy settings.\n\n​\n\nTypes of information collected:\n​\nInformation Submitted by the user:\n\n \n\nThe users are prompted to provide their personally identifiable information when they contact Sprouting Wings. You are required to submit personal information when you interact with Sprouting Wings such as registering for an account, availing our services, requesting information or notification for our products and services and providing a job application.\n\n​\n\nIn each of the above cases, the user is completely aware of the data collected by Sprouting Wings as they have voluntarily provided it. If the user chooses to deny personal information requested by Sprouting Wings, he/she may not be able to avail some services on our website and we would not be able to respond to the inquiries that the user may have.\n\n​\n\nPersonal information may include, but not restricted to:\n\n​\n\nEmail address\n\nFirst name and Last name\n\nPhone number\n\nDemographic Information: Address, State, Province, ZIP/Postal code, City\n\nCookies and Usage Data\n\n \n\nInformation Collected by means of Third-Party sources:\n\n \n\nSprouting Wings may collect the user’s information via third-party sources where acceptable by law to offer services to them.\n\n \n\nPassive Information or Automatically Collected Information:\n\n \n\nJust like any other website, Sprouting Wings uses data collection tools that automatically collect your data which includes cookies, web beacons, web links (embedded) and gifs, etc. Tools like these have the ability to accumulate standard data that the browser of the concerned users sends to our website when he/she uses our services or website.\n\n​\n\nThis type of information may include:\n\n​\n\nType of the browser used.\n\nThe operating system of the user.\n\nWeb pages are seen.\n\nCookies: Session Cookies, Preference cookies, security cookies.\n\nLinks clicked by the user.\n\nThe IP address used to connect.\n\nAmount of time taken by the visitor on our Website or services.\n\nThe referring URL or webpage.\n\nCrash Reports.\n\nSystem Activity.\n\n \n\nSprouting Wings also collects data when any app or device interacts with our services. The user can deny permission to access the cookies and manage their access from within their browser setting. However, if the user denies certain permissions, he/she would not be able to use some of our services.\n\n​\n\nCollaborations:\n\n \n\nAt times Sprouting Wings can collaborate with third-party agencies to combine the information collected by both of them from their users, to the extent permitted by the Indian law.\n\n \n\nWhy Sprouting Wings collect information?\n​\nSprouting Wings may use the user information for operating our business and other legitimate purposes, to the extent permitted by the law. We may utilize the information in the following ways:\n\n​\n\nContact information is kept in order to contact the user for confirmation of the procurement of the services of our website and for promotional purposes like changes in our services and newly introduced products.\n\nTo improve our products and services and customize them for a better experience of the user based upon her preferences. This information provides an overview of site trends and customer interests both at an aggregated as well as individualistic level.\n\nTo help the user in interacting with the services of the website if he/she intends to do so.\n\nTo monitor the amount of utilization of our services by means of tools like Google Analytics\n\nTo gather information about prospective applicants of the job for future reference.\n\nLog files are used for the purpose of analyzing trends, tracking the movement of the users as well as gather their demographic information for future use.\n\nCookies and web beacons would help in optimizing the overall experience of the user.\n\nFor detection and rectification of technical issues.\n\nFor security reasons.\n\n\n \n\n**Note that Sprouting Wings reserves no right over the cookies used by third-party advertisers.\n\n​\n\nInformation Sharing at Sprouting Wings\n​\nSprouting Wings lets the user share her information as per their own consent and have full control over how they share it. Remember, when you share your content publicly, Sprouting Wings does not have any liability towards that and it can be accessed through local search engines as well. The information of users may be transferred to or maintained on servers outside of your state or governmental jurisdiction where data protection laws may differ.\n\n​\n\nIf the user is situated outside India and wishes to share information with us, please be advised that we transfer and store data within India and process it there. Your consent to this privacy policy followed by your submission of personal data gives us the right to comply with this transfer.\n\n​\n\nSprouting Wings does not share the personal information of its users with other companies or individuals outside of its office space except in the following cases involving third-parties:\n\n​\n\nSharing with third-party agencies working on our behalf.\n\nWith event organizers of our business only.\n\nWith our business partners.\n\nFor legal purposes when Sprouting Wings think that they have to provide the information in order to comply with the law.\n\nWith the future prospective successor of our business.\n\nFor reasons not mentioned within this policy. (The user’s consent would be required before this).\n\nIn addition to the above cases Sprouting Wings reserves the right to disclose the information in the following scenarios requiring legal compliances:\n\nComplying with a legal obligation\n\nTo defend the rights of Sprouting Wings\n\nTo help in the investigation of probable wrongdoing concerned with the service.\n\nTo protect the safety of the users of its services.\n\n\n \n\nKeeping your information secure\n​\nSprouting Wings will take the necessary attempts to protect the data of its users in accordance with this privacy policy and ensures that there would be no transfer of your personal information to any third party unless there is a provision mentioned within this policy with respect to the security of vital information of the user.\n\n​\n\nHowever, the users should note that no method of transmission over the internet or server ensures 100 percent security to its users. Keeping this in mind Sprouting Wings will make every possible attempt to protect your information without the guarantee of absolute security. \n\n \n\nAnalytics\n​\nSprouting Wings reserves the right to employ third party companies or service providers to perform service-based assistance in analyzing the usage of our service. These parties will have access to the personal information of our users in the supervision of our company under the obligation to not disclose it for any other use.\n\n​\n\nSprouting Wings uses Google Analytics for many of its purposes. It is a web analytics service that helps us in gauging the traffic on our website. The data collected by Google may be used by them to customize their ads for their own benefit. The users can deny the permission to track their activity by installing Google Analytics opt-out add-on in their respective browser which will prevent its JavaScript from sharing any information about visits.\n\n \n\nAccess and modify your Personal Information\n​\nWherever permitted by the jurisdiction, Sprouting Wings provides its users with the ability to modify their personal information by means of logging in and updating their account information.\n\n\n \n\nPrivacy policy for children\n​\nSprouting Wings considers the protection of children as its highest priority. The guardians and parents are encouraged to monitor and guide their children’s online activity. We at Sprouting Wings do not participate in the collection of personal data of children below the age of 16 years. If by any chance, you feel that your child has provided some crucial information on our website, we will ensure that we will do our best to remove such information from our database.\n\n \n\nLinks to Other third-party sites\n​\nThe users of our website are presented with various links to other websites that may or may not be operated by us. If the user clicks on this link he would be directed to that web-page. We at Sprouting Wings recommend its users to carefully check the privacy policy of that website before availing any of its services.\n\nSprouting Wings by no means is liable for the content and privacy policy of any third-party agencies.\n\n \n\nPrivacy Policy change\n​\nThe privacy policy is liable to be updated or changed with time. The users will be notified for any changes in the existing privacy policy by means of posting the new privacy policy on the concerned webpage of our company website. The users will also be notified by means of an email as well as a notice prior to the implementation of the changed privacy policy and an effective date will be updated at the top of this policy.\n\n​\n\nHowever, the users are advised to re-examine the privacy policy sporadically for any changes. Any changes to this policy would be effective only when they are mentioned on this page.\n\n​\n\nContact Us\n​\nAny queries about the privacy policy, from the users, are welcome. The users can connect with us by:\n\nEmail: Info@SWDM.In\n\nVisiting our website: https://www.Sprouting Wingsdigitalmarketing.com/contact\n\nContact number: +91-9983791397\n\n \n\nConsent\nUsing our website ensures your consent to our Privacy Policy as well as the terms and conditions as posted on the website.',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 8,
                        color: const Color(0xff2f2e41),
                      ),
                      textAlign: TextAlign.left,
                    )),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
