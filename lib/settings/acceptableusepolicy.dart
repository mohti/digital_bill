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

class AcceptableUsePolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Accceptable Use Policy',
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
                'Accceptable Use Policy',
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
                      child: SizedBox(
                        width: 359.0,
                        height: 673.0,
                        child: SingleChildScrollView(
                            child: Text(
                          'Effective date: December 11, 2019\n\n​\n\nUse of the services offered by Bradvice Solutions is subject to this acceptable use policy (“AUP”).\n\n​\n\nSprouting Wings provides a plethora of services in the field of digital marketing to help its users to meet their goals, initiatives and manage them with accountability to uphold the integrity and confidentiality of its assets. This acceptable use policy safeguards the company against potentially harmful legal issues and requests the users of information assets to comply with the policies of Sprouting Wings.\n\n​\n\nThe rationale behind this policy is to establish acceptable as well as unacceptable use of the services provided by Sprouting Wings in synchronization with its established ethos of ethical and lawful conduct, conviction and veracity.\n\n​\n\nThe policies established by Sprouting Wings play an imperative role in maintaining an overall positive and progressive experience for its users. Please comply with these policies when using our products and services. The users are advised to check back from time to time, as these policies are subject to change. Please also refer to Sprouting Wings’ Terms of Service for more information.\n\n \n\nScope\n​\nAll the employees, consultants, teachers and temporary workers at Sprouting Wings, inclusive of the persons associated with any third parties are required to adhere to this policy. This policy is applicable to all the information assets which are owned or leased by Sprouting Wings or to the devices residing at a Sprouting Wings’ site.\n\n​\n\nStatement of the policy\n​\nGeneral Requirements\n​\nThe users are expected to be responsible enough for exercising suitable judgment vis-à-vis appropriate utilization of the resources of Sprouting Wings in agreement with the Sprouting Wings policies, guidelines, and specifications. Sprouting Wings’ resources must not be used for any illegal or unauthorized purpose. The audit policy will guide the authorized personnel in monitoring and auditing the systems and network traffic for security, maintenance and compliance purposes. Devices which interfere with other users on the Sprouting Wings network are liable to be disconnected. Information Security disallows the active blocking of authorized audit scans. Access to the scan sources must be approved by the firewalls and other technologies which block them.\n\n​\n\nGeneral guidelines pertaining to acceptable use policy\n​\nComplying with our acceptable use policy, the user agrees not to allow third parties or his/her end users to exploit the services provided to him/her for any of the following purposes:\n\n​\n\nFor the facilitation of unsolicited commercial emails sent in bulk.\n\nFor violation of the legal privileges of others\n\nFor illegitimate, defamatory or deceitful purposes.\n\nFor the distribution of viruses, trojan horses and worms to exploit the general public.\n\nTo grant access to an individual End User account to multiple users.\n\nFor the reverse engineering of services provided by Sprouting Wings to gauge the vulnerabilities and dodge filtering capabilities.\n\nFor creating an End User Account on behalf of a business instead of a human being for the purpose of exploiting the services by sharing the files outside the domain.\n\nTo record the communications in the form of audio or video files without the consent of the company. (The user is solely responsible for ensuring the compliance of the concerned agency within the applicable jurisdiction and regulations).\n\nFor the purpose of reselling the End User Accounts or its part as a commercial product to any third-party agency.\n\n \nDetailed Guidelines of Acceptable Use Policy\n​\nUnacceptable Use\n​\nRude conduct: The users are requested not to threaten, intimidate or harass any person belonging to the organization as well as other users. Any foul, disrespectful and offensive behavior is strictly liable to be scrutinized. The users’ access would be terminated immediately if he/she uses any ethnic or religious slurs against any other personnel.\n\nUnsolicited Contact: The users are strictly advised not to contact any person who has requested for the same. Anyone found to be impersonating would be liable to termination.\n\nIllegal activities: The services provided by Sprouting Wings should not be used to promote or engage in illicit adventures.\n\nPrivate and Confidential Information: The users are advised not to provide any confidential information about a person to the system without prior authorization. The privacy rights of a person should not be violated. Information including the Aadhar id and personal address shall be uploaded with the written permission of the account holder.\n\nNetwork Attacks, Phishing, and Other Deceptive Practices: The users should not access any device or communication system without permission. No attempt should be made to penetrate the security system via phishing or any other malpractices. Intentional spreading of a virus or spyware, renunciation of service attack, or any other attempt to disable the operations of the communication systems will not be tolerated. The users are requested to refrain from the act of gathering sensitive data which includes passwords, Aadhar numbers as well as financial details.\n\nSpam and Commercial Use: Sending of bulk commercial e-mails to advertise a third-party product or service is strictly prohibited. The users are also requested not to cooperate with the distribution of spam or any automated messages.  \n\nMalware: Sprouting Wings does not allow the broadcasting of malware, destructive codes, trojan horses or any other potentially harmful malware that might interfere with the operations of servers and devices.\n\nViolations of Law: Violation of any law and entertaining any illicit activities such as copyright violation, trademarks, intellectual property law, threatening, stalking or defaming any person is strictly prohibited and liable to be responded with immediate termination of present and future services\n\nChild Safety: Sprouting Wings has a zero-tolerance policy against any activity which might be potentially harmful to the children. If the company becomes aware of any such conduct, we reserve the right to report it to the concerned authorities for disciplinary action. Immediate termination of the services would be levied for such conduct.\n\n \nRepercussions of Violation\n​\nFailure to comply with this Acceptable Use Policy (“AUP”) will result in suspension and/or termination of the services provided to the user in addition to legal action (if required). The users may also be required to pay for the investigation costs as well as the requisite action related to the type of AUP violation. Sprouting Wings reserves the right to take the requisite action as per the End User Agreement.\n\n​\n\nIf the services are used for educational purposes, no third-party sharing is allowed except for the purposes authorized by the concerned institution. For further information, the institution is required to contact the service provider.\n\n​\n\nTestifying Unacceptable Use\n​\nThe users are requested to report any information pertaining to a potential violation of this Acceptable Use Policy (“AUP”)  via email to the following address: mailto:INFO@SWDM.IN\n\n​\n\nThe users are required to submit the requisite date and time of the concerned violation and any other information pertaining to the violator as well as the details of the violation.\n\n​\n\nModification of Acceptable Use Policy\n​\nThe Acceptable Use policy is liable to be updated or changed with time. The users will be notified for any changes in the existing Acceptable Use policy by means of posting the new Acceptable Use policy on the concerned webpage of our company website. The users will also be notified by means of an email as well as a notice prior to the implementation of the changed Acceptable Use policy and an effective date will be updated at the top of this policy.\n\n​\n\nHowever, the users are advised to re-examine the Acceptable Use policy sporadically for any changes. Any changes to this policy would be effective only when they are mentioned on this page.\n\n​\n\nEnforcement\n​\nSprouting Wings reserves the right to take the requisite disciplinary action up to and including the deactivation of accounts of the person found to be violating this Acceptable Use Policy. If the user feels that their account has been disabled by mistake, he/she can contact us at the above-mentioned email.',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 8,
                            color: const Color(0xff2f2e41),
                          ),
                          textAlign: TextAlign.left,
                        )),
                      ),
                    ),
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
