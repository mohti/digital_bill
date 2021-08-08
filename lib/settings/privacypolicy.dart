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
    String pra1 =
        'At JhatpatBill reachable from https://www.bradvicepvt.com we consider this as an immense responsibility and make an effort to safeguard the privacy of our visitors with due diligence. This Privacy Policy is an overview of the type of information that we collect, how we use that information, and how you can take control of what you share with us. Provision to update, manipulate and delete their private information is available to the users if they require.\n\nThe Mobile Application (as defined hereinafter), the Desktop Application (as defined hereinafter) and the Website (as defined hereinafter) are provided by JhatpatBill is a property of Bradvice Solutions PVT Ltd, an Indian Company registered under the Companies Act of India having CIN U9000RJ2019PTC065044 with its registered office at FF-27, Cross Road mall, Central Spine, Vidhyadhar Nagar, Jaipur, Rajasthan, India 302039. In these Terms of Service, the term "User" or “You” refers to you, the Person or entity using the Mobile Application, Desktop Application, the Website and/or procuring any goods, service or product from JhatpatBill. It is clarified that in case of a company, partnership, trust or any other legal entity which uses or accesses the Services or the JhatpatBill Products, "User" shall include such company, partnership, trust or any other legal entity.\n\nJhatpatBill offers the Mobile Application, Desktop Application, Store, Website, platform and any other services conditioned upon the User’s acceptance of all terms, conditions, policies, and notices stated here. By procuring a service from JhatpatBill, or by use of the Mobile Application, Desktop Application, Store, Website or platform, the User agrees to be bound by these terms and conditions ("Terms of Service" or "Terms"), as applicable, to the use of the Mobile Application, Store, Desktop Application, Website, platform and any services provided by JhatpatBill.';
    String informationCollection = 'Information Collection\n\n​At JhatpatBill, we need you to comprehend the type of information collected and the way in which it is collected when you avail our services. This collection of information is indispensable in order to provide superior services to our users. The type of information collected by JhatpatBill is governed by the services used by you and the privacy settings.\n\nTypes of information collected:\n\n    1. Information Submitted by the user:\n\nThe users are prompted to provide their personally identifiable information when they contact JhatpatBill. You are required to submit personal information when you interact with JhatpatBill such as registering for an account, availing our services, requesting information or notification for our products and services and providing a job application.\n\nIn each of the above cases, the user is completely aware of the data collected by JhatpatBill as they have voluntarily provided it. If the user chooses to deny personal information requested by JhatpatBill, he/she may not be able to avail some services on our Mobile Application, Desktop Application, Website, Store and we would not be able to respond to the inquiries that the user may have.Personal information may include, but not restricted to:\n\n\n    1. Email address\n    2. First name and Last name\n    3. Phone number\n    4. Demographic Information: Address, State, Province, ZIP/Postal code, City\n    5. Cookies and Usage Data\n\n     1. Information Collected by means of Third-Party sources:\n\nJhatpatBill may collect the user’s information via third-party sources where acceptable by law to offer services to them.\n\n    1. Passive Information or Automatically Collected Information:\n\nJust like any other website, JhatpatBill uses data collection tools that automatically collect your data which includes cookies, web beacons, web links (embedded) and gifs, etc. Tools like these have the ability to accumulate standard data that the browser of the concerned users sends to our website when he/she uses our services or Mobile Application, Desktop Application, Website, Store or other product.\n\nThis type of information may include:\n\n    1. Type of the browser used.\n    2. The operating system of the user.\n    3. Web pages are seen.\n    4. Cookies: Session Cookies, Preference cookies, security cookies.\n    5. Links clicked by the user.\n    6. The IP address used to connect\n    7. Amount of time taken by the visitor on our Mobile Application, Desktop Application, Website, \n        Store or other product or services.\n    8. The referring URL or webpage.\n    9. Crash Reports.\n    10. System Activity.\n\nJhatpatBill also collects data when any app or device interacts with our services. The user can deny permission to access the cookies and manage their access from within their browser setting. However, if the user denies certain permissions, he/she would not be able to use some of our services.\n\n    1. Collaborations:\n\nAt times JhatpatBill can collaborate with third-party agencies to combine the information collected by both of them from their users, to the extent permitted by the Indian law.\n\n Why does JhatpatBill collect information?\n\nJhatpatBill may use the user information for operating our business and other legitimate purposes, to the extent permitted by the law. We may utilize the information in the following ways:\n\n    • Contact information is kept in order to contact the user for confirmation of the procurement of the services of our Mobile Application, Desktop Application, Website, Store or other product for promotional purposes like changes in our services and newly introduced products.\n    • To improve our products and services and customize them for a better experience of the user based upon her preferences. This information provides an overview of site trends and customer interests both at an aggregated as well as individualistic level.\n    • To help the user in interacting with the services of the Mobile Application, Desktop Application, Website, Store if he/she intends to do so.\n    • To monitor the amount of utilization of our services by means of tools like Google Analytics\n    • To gather information about prospective applicants of the job for future reference.\n    • Log files are used for the purpose of analyzing trends, tracking the movement of the users as well as gathering their demographic information for future use.\n    • Cookies and web beacons would help in optimizing the overall experience of the user.\n    • For detection and rectification of technical issues.\n    • For security reasons.\n\n\n**Note that JhatpatBill reserves no right over the cookies used by third-party advertisers.' ; 
    String infoSharedatjp = 'Information Sharing at JhatpatBill\n\nJhatpatBill lets the user share her information as per their own consent and have full control over how they share it. Remember, when you share your content publicly, JhatpatBill does not have any liability towards that and it can be accessed through local search engines as well. The information of users may be transferred to or maintained on servers outside of your state or governmental jurisdiction where data protection laws may differ.\n\nIf the user is situated outside India and wishes to share information with us, please be advised that we transfer and store data within India and process it there. Your consent to this privacy policy followed by your submission of personal data gives us the right to comply with this transfer.\n\nJhatpatBill does not share the personal information of its users with other companies or individuals outside of its office space except in the following cases involving third-parties:\n\n    • Sharing with third-party agencies working on our behalf.\n    • With event organizers of our business only.\n    • With our business partners.\n    • For legal purposes when JhatpatBill think that they have to provide the information in order to     comply with the law.\n    • With the future prospective successor of our business.\n    • For reasons not mentioned within this policy. (The user’s consent would be required before this).\n      In addition to the above cases JhatpatBill reserves the right to disclose the information in the following scenarios requiring legal compliances:\n    • Complying with a legal obligation\n    • To defend the rights of JhatpatBill\n    • To help in the investigation of probable wrongdoing concerned with the service.\n    • To protect the safety of the users of its services.\n\n\n' ;
    String keepYInfosecure = 'Keeping your information secure\n\n\nJhatpatBill will take the necessary attempts to protect the data of its users in accordance with this privacy policy and ensures that there would be no transfer of your personal information to any third party unless there is a provision mentioned within this policy with respect to the security of vital information of the user.\n\nHowever, the users should note that no method of transmission over the internet or server ensures 100 percent security to its users. Keeping this in mind JhatpatBill will make every possible attempt to protect your information without the guarantee of absolute security. \n\nAnalytics\n\nJhatpatBill reserves the right to employ third party companies or service providers to perform service-based assistance in analyzing the usage of our service. These parties will have access to the personal information of our users in the supervision of our company under the obligation to not disclose it for any other use.\n\nJhatpatBill uses Google Analytics for many of its purposes. It is a web analytics service that helps us in gauging the traffic on our Mobile Application, Desktop Application, Website, Store or other product. The data collected by Google may be used by them to customize their ads for their own benefit. The users can deny the permission to track their activity by installing Google Analytics opt-out add-on in their respective browser which will prevent its JavaScript from sharing any information about visits.' ;
    String aamypi = 'Access and modify your Personal Information\n\nWherever permitted by the jurisdiction, JhatpatBill provides its users with the ability to modify their personal information by means of logging in and updating their account information.';  
    String ppfc = 'Privacy policy for children\n\nJhatpatBill considers the protection of children as its highest priority. The guardians and parents are encouraged to monitor and guide their children’s online activity. We at JhatpatBill do not participate in the collection of personal data of children below the age of 16 years. If by any chance, you feel that your child has provided some crucial information on our Mobile Application, Desktop Application, Website, Store or other product., we will ensure that we will do our best to remove such information from our database.';
    String ltotps = ' Links to Other third-party sites\n\n​The users of our Mobile Application, Desktop Application, Website, Store or other product. are presented with various links to other websites that may or may not be operated by us. If the user clicks on this link he would be directed to that web-page. We at JhatpatBill recommend its users to carefully check the privacy policy of that website before availing any of its services.JhatpatBill by no means is liable for the content and privacy policy of any third-party agencies.'; 
    String ppc = 'Privacy Policy change\n\n​The privacy policy is liable to be updated or changed with time. The users will be notified for any changes in the existing privacy policy by means of posting the new privacy policy on the concerned webpage of our company Mobile Application, Desktop Application, Website, Store or other product. The users will also be notified by means of an email as well as a notice prior to the implementation of the changed privacy policy and an effective date will be updated at the top of this policy.\n\nHowever, the users are advised to re-examine the privacy policy periodically for any changes. Any changes to this policy would be effective only when they are mentioned on this page.';
     String contactUs =
        'Contact Us\n\nAny queries about the Refund Policy, from the users, are welcome. The users can connect with us by:\n    • Email: bradvicesolutionspvt@gmail.com \n    • Visiting our website: https//:bradvicepvt.com \n    • Contact number: +91-7742330144\n\n ';
    String consent = 
    'Consent\n\nUsing our Mobile Application, Desktop Application, Website, Store or other product ensures your consent to our Privacy Policy as well as the terms and conditions as posted on the Mobile Application, Desktop Application, Website, Store or other product.';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                      pra1+'\n\n\n'+informationCollection+'\n\n\n'+infoSharedatjp+
                      '\n\n'+keepYInfosecure+
                      '\n\n'+aamypi +
                      '\n\n'+ppfc+
                      '\n\n'+ ltotps+
                      '\n\n'+ppc+'\n\n\n' +  contactUs +'\n\n'+consent+'\n\n\n\n\n\n' ,
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
