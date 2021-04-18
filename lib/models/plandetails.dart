class PlanDetails {
  String planName;
  DateTime d;
  DateTime sdate;
  int remaininginvoices;
  int remainingewaybill;

  PlanDetails(
    this.planName,
    this.d,
    this.sdate,
    this.remaininginvoices,
    this.remainingewaybill,
  );
  Map<String, dynamic> toJson() => {
        'planName': planName,
        'duration': d,
        'sdate': sdate,
        'remaininginvoices': remaininginvoices,
        'remainingewaybill': remainingewaybill,
      };
}
