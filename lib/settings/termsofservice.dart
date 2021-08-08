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

class TermsOfService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    String pra1 =
        ' Effective May 27, 2019\n\nAt JhatpatBill reachable from https://www.bradvicepvt.com we consider this as an immense responsibility and make an effort to safeguard the privacy of our visitors with due diligence. This Terms of Service is an overview of the type of information that we collect, how we use that information, and how you can take control of what you share with us. Provision to update, manipulate and delete their private information is available to the users if they require.\n\n\nThe Mobile Application (as defined hereinafter), the Desktop Application (as defined hereinafter) and the Website (as defined hereinafter) are provided by JhatpatBill is a property of Bradvice Solutions PVT Ltd, an Indian Company registered under the Companies Act of India having CIN U9000RJ2019PTC065044 with its registered office at FF-27, Cross Road mall, Central Spine, Vidhyadhar Nagar, Jaipur, Rajasthan, India 302039. In these Terms of Service, the term "User" or “You” refers to you, the Person or entity using the Mobile Application, Desktop Application, the Website and/or procuring any goods, service or product from JhatpatBill. It is clarified that in case of a company, partnership, trust or any other legal entity which uses or accesses the Services or the JhatpatBill Products, "User" shall include such company, partnership, trust or any other legal entity\n\nJhatpatBill offers the Mobile Application, Desktop Application, Store, Website, platform and any other services conditioned upon the User’s acceptance of all terms, conditions, policies, and notices stated here. By procuring a service from JhatpatBill, or by use of the Mobile Application, Desktop Application, Store, Website or platform, the User agrees to be bound by these terms and conditions ("Terms of Service" or "Terms"), as applicable, to the use of the Mobile Application, Store, Desktop Application, Website, platform and any services provided by JhatpatBill.\n';
    String termsandCondition =
        'Terms and Conditions\n\nUsing the services of JhatpatBill Mobile Application, Desktop Application, Store, Website, platform and any other services, accessible from https//:bradvicepvt.com the user harmonizes with these terms and conditions within the applicable jurisdiction. The user is requested to read the document carefully. The terms represent a general framework of regulations laid down for the use of services provided by JhatpatBill.\n\n​If the user disagrees with any of these terms, he/she is requested not to use the services provided by JhatpatBill. The content of JhatpatBill Mobile Application, Desktop Application, Store, Website, platform and any other services is protected by copyright and trademark regulations and cannot be replicated by any means.';
    String licenceOfUse =
        ' License of use\n\n\n​JhatpatBill does not allow more than one temporary copy of the content provided by us for personal or non-commercial application. This license does not authorize the transfer of title. The user is not allowed to:\n\n    • Reproducing, replicating or modification of the content.\n    • Utilization of material for commercial purposes.\n    • Removal of copyright from the content documents.\n    • Transfer of materials to another individual or firm.\n    • Use of branding or logos used within the services.\n    • Interfering with the services provided by JhatpatBill.\n    • Accessing the services by methods which use some other interface and instructions.\n\n\n JhatpatBill reserves the right to terminate the account of the user for any violation of any of these restrictions. The users are advised to delete or destroy any content that they possess after the termination.';
    String disclaimer =
        ' Disclaimer\n\nJhatpatBill provides the services with commercially acceptable skills and we have a faith that the user will appreciate using them. The users are expected to be responsible enough for exercising suitable judgment vis-à-vis appropriate utilization of the resources of JhatpatBill in agreement with the JhatpatBill policies, guidelines, and specifications. JhatpatBill’ resources must not be used for any illegal or unauthorized purpose. Given that we exclude the following liabilities and warranties from our services:\n\n    1. Liability for personal damage due to laxity.\n    2. Liability for sham or deceptive practices.\n    3. Liabilities not acceptable by the jurisdiction.\n\n We do not make any expressed or implied assurance like non-infringement or fitness of a particular purpose. JhatpatBill provides the services “as is”.';
    String contOfuser =
        'Content of the user\n\n​Services provided by JhatpatBill allows the user to share and receive their content. The user retains the intellectual property rights of that content. By sharing and obtaining content through our services the gives JhatpatBill a worldwide license to reproduce and publish such content. The authorization granted by the user in this license is limited with respect to the purpose of operating and improving our services. The license does not terminate even after the user withdraws from availing our services.';
    String htoc =
        'Hyperlinking to our Content\n\nJhatpatBill does not evaluate the content of the pages linked to its website and excludes any liability to such content. JhatpatBill does not endorse any website due to the presence of any such link.\n\nExcept for the following organizations, every organization needs prior written approval from JhatpatBill for hyperlinking:\n\n    1. Government organizations.\n    2. Search engines.\n    3. News and broadcasting agencies.\n    4. Online directory distributors.\n\n Following guidelines are indispensable to be followed while linking to our home page:\n\n    • The link should not be deceptive or fraudulent.\n    • The link should not imply false association and approval with the products and services provided by JhatpatBill.\n\n JhatpatBill will approve linking with the following types of businesses:\n\n    • Online directory distributors\n    • Internet portals and dot com websites\n    • Charity websites and Non-governmental organizations.\n    • Consulting, accounting and legal organisations.\n\nThe interested organizations can contact JhatpatBill for further process and provide details like the name of the organization, contact information as well as URL of the website and expect the response within 1-2 weeks';
    String useraccount =
        ' User’s Account\n\nThe user is requested to keep the login details as confidential as possible. He/she is solely responsible for the activity that occurs through the account. If the user notices an unusual activity or unauthorized use by a third-party agency, please inform JhatpatBill for further process.';
    String privacyandcopyright =
        'Privacy and Copyright Protection\n\nThe privacy policy laid down by JhatpatBill mentions in detail about the protection of personal information when the user utilizes our services. JhatpatBill retains the right to use this information as per the guidelines of the privacy policy.\n\nJhatpatBill responds to the notices of contended copyright infringement and reserves the right to terminate the account of repeat violators.';
     String matos =
        'Modifying and Terminating our Services\nThe Terms of Service are liable to be updated or changed with time. The users will be notified for any changes in the existing Terms of service by means of posting the new document of the terms on the concerned webpage of our company website. The users will also be notified by means of an email as well as a notice prior to the implementation of the changed Terms of Service and an effective date will be updated at the top of this policy.However, the users are advised to re-examine the Terms of Service sporadically for any changes. Any changes to this policy would be effective only when they are mentioned on this page. ';
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
          'Terms Of Service',
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
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'JhatpatBill Terms of Services',
                style: TextStyle(
                  fontFamily: 'Bell MT',
                  fontSize: 16,
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
                  child: Text(
                    pra1 + '\n\n' 
                    + termsandCondition + 
                    '\n\n' + licenceOfUse+
                    '\n\n'+disclaimer+
                    '\n\n'+contOfuser+
                    '\n\n'+htoc+
                    '\n\n'+useraccount+
                    '\n\n'+privacyandcopyright+
                    '\n\n'+matos+
                    '\n\n'+contactUs+
                    '\n\n'+consent,
                    //  'Terms of service\n​\nEffective date: December 11, 2019\n\n​Welcome to Bradvice Solutions Pvt. LTD!\n​\nWe at Bradvice Solutions want to thank you for tapping into our services (“Services”). The services are provided by Sprouting Wings, situated at FF-27, Cross Road mall, Central Spine, Vidhyadhar Nagar. 302039, Jaipur, Rajasthan, India\n\n​Terms and Conditions\n​\nUsing the services of this website, accessible from https://www.sproutingwingsdigitalmarketing.com the user harmonizes with these terms and conditions within the applicable jurisdiction. The user is requested to read the document carefully. The terms represent a general framework of regulations laid down for the use of services provided by Sprouting Wings.\n\nIf the user disagrees with any of these terms, he/she is requested not to use the services provided by Sprouting Wings. The content of this Website is protected by copyright and trademark regulations and cannot be replicated by any means.\n\n​License of use\n​\nSprouting Wings does not allow more than one temporary copy of the content provided by us for personal or non-commercial application. This license does not authorize the transfer of title. The user is not allowed to:\n\n​\n\nReproducing, replicating or modification of the content.\n\nUtilization of material for commercial purposes.\n\nRemoval of copyright from the content documents.\n\nTransfer of materials to another individual or firm.\n\nUse of branding or logos used within the services.\n\nInterfering with the services provided by Sprouting Wings.\n\nAccessing the services by methods which use some other interface and instructions.\n\n \n\nSprouting Wings reserves the right to terminate the account of the user for any violation of any of these restrictions. The users are advised to delete or destroy any content that they possess after the termination.\n\n​\n\n     Disclaimer\n​\nSprouting Wings provides the services with commercially acceptable skill and we have a faith that the user will appreciate using them. The users are expected to be responsible enough for exercising suitable judgment vis-à-vis appropriate utilization of the resources of Sprouting Wings in agreement with the Sprouting Wings policies, guidelines, and specifications. Sprouting Wings’ resources must not be used for any illegal or unauthorized purpose. Given that we exclude the following liabilities and warranties from our services:\n\n​\n\nLiability for personal damage due to laxity.\n\nLiability for sham or deceptive practices.\n\nLiabilities not acceptable by the jurisdiction.\n\n \n\nWe do not make any expressed or implied assurance like non-infringement or fitness of a particular purpose. Sprouting Wings provides the services “as is”.\n\n​\n\n​\n\n      Refund Policy\n​\nRefund policy or cancellations try to unearth the concealed features of our paid services. Sprouting Wings feel that this policy would be of assistance to the users procuring our services.\n\n​\n\nBy agreeing to the refund policy, the user understands that Sprouting Wings or any associated person shall not be responsible for any personal harm, grievance or loss of any kind experienced by him/her by the use of refund money.\n\n​\n\nThe users are entitled to a refund if he/she requests for the same within 15 days of registration for the service. Cancellation done after 15 days shall not be considered as a valid refund request as per the terms and conditions of refund policy. The terms and conditions concerning the refund policy are as under:\n\n​\n\n       General guidelines:\n\n​\n\nThe user shall possess a registered account on Sprouting Wings to avail the benefits of this refund policy.\n\nThe refund is constrained by applicable statutory laws and regulations.\n\nThe refund shall only be granted to the user if he/she is able to present all the requisite documents as required by Sprouting Wings.\n\nErroneous or faulty information by the user shall entitle Sprouting Wings to debar him/her from availing any future services.\n\nAny user found to be engaged in the illicit or unlawful activity shall be liable to be subjected to suitable legal action.\n\nThe services are liable to be changed, discontinued and extended as per the business constraints of Sprouting Wings.\n\nSprouting Wings does not provide any assurance to respond to every feedback, suggestion or queries of the user.\n\nThe user agrees to share his/her personal information with Sprouting Wings. Sprouting wings reserves the right to use this information for lawful practices.\n\nSprouting Wings shall not be accountable for any technical failure in the connectivity or device at the time of refund.\n\nThe users found be violating the refund policy repeatedly or requesting frequent refunds shall be subject to cancellation of refund requests.\n\nAny disagreement from the T&C laid down in the refund policy shall be attempted to be agreed upon by means of discussions.\n\n \n\n \n     Detailed guidelines:\n​\nIf the user requests for a refund within one week of the membership, he/she shall be entitled to a 30 % refund of the of service charge collected at the time of registration for the service.\n\nThe user shall be permitted to avail a 20 % refund if he/she appeals for a refund within 15 days of the registration for the service.\n\nIn no case, the user shall be given a refund if he/she demands a refund after 15 days of registration for the course.\n\n \n\n \n\nIf the user’s expectations diverge from the above refund policy, he/she is requested to opt out from availing the services provided by Sprouting Wings. The above-mentioned refund policy is subject to changes as per the guidelines published by the competent authorities. Sprouting Wings reserves the right to penalize the user if he is found to be noncompliant to the above terms and conditions. In case of any ambiguity or discrepancy regarding the refund policy, the decision taken by Sprouting Wings will be final and no further discussions shall be entertained.\n\n​\n\n     Content of the user\n​\nServices provided by Sprouting Wings allows the user to share and receive their content. The user retains the intellectual property rights of that content. By sharing and obtaining content through our services the gives Sprouting Wings a worldwide license to reproduce and publish such content. The authorization granted by the user in this license is limited with respect to the purpose of operating and improving our services. The license does not terminate even after the user withdraws from availing our services.\n\n​\n\n     Hyperlinking to our Content\n​\nSprouting Wings does not evaluate the content of the pages linked to its website and excludes any liability to such content. Sprouting Wings does not endorse any website due to the presence of any such link.\n\n​\n\nExcept for the following organizations, every organization needs prior written approval from Sprouting Wings for hyperlinking:\n\n​\n\nGovernment organizations;\n\nSearch engines;\n\nNews and broadcasting agencies;\n\nOnline directory distributors.\n\n \n\nFollowing guidelines are indispensable to be followed while linking to our home page:\n\n​\n\nThe link should not be deceptive or fraudulent.\n\nThe link should not imply false association and approval with the products and services provided by Sprouting Wings.\n\n \n\nSprouting Wings will approve linking with the following types of businesses:\n\n​\n\nOnline directory distributors\n\nInternet portals and dot com websites\n\nCharity websites and Non-governmental organizations.\n\nConsulting, accounting and legal organisations.\n\n \n\nThe interested organizations can contact Sprouting Wings for further process and provide details like the name of the organization, contact information as well as URL if the website and expect the response within 1-2 weeks.\n\n \n\n     User’s Account\n​\nThe user is requested to keep the login details as confidential as possible. He/she is solely responsible for the activity that occurs through the account. If the user notices an unusual activity or unauthorized use by a third-party agency, please inform Sprouting Wings for further process.\n\n​\n\n     Privacy and Copyright Protection\n​\nThe privacy policy laid down by Sprouting Wings mentions in detail about the protection of personal information when the user utilizes our services. Sprouting Wings retains the right to use this information as per the guidelines of the privacy policy.\n\n​\n\nSprouting Wings responds to the notices of contended copyright infringement and reserves the right to terminate the account of repeat violators.\n\n​\n\n     Modifying and Terminating our Services\n​\nThe Terms of Service are liable to be updated or changed with time. The users will be notified for any changes in the existing Terms of service by means of posting the new document of the terms on the concerned webpage of our company website. The users will also be notified by means of an email as well as a notice prior to the implementation of the changed Terms of Service and an effective date will be updated at the top of this policy.\n\n​\n\nHowever, the users are advised to re-examine the Terms of Service sporadically for any changes. Any changes to this policy would be effective only when they are mentioned on this page.\n\n​\n\n     Contact Us\n​\nIf you have any questions about this Refund Policy, please contact us via e-mail to the following address:  INFO@SWDM.IN\n\n​\n\n     Consent\n\nUsing our website ensures your consent to our Privacy Policy as well as the terms and conditions as posted on the website.',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 8,
                      color: const Color(0xff2f2e41),
                    ),
                    textAlign: TextAlign.left,
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
