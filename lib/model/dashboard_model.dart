class DashboardModel {
  int remainingClients;
  List<String> clientNames;
  List<DateTime> time;

  DashboardModel({
    this.remainingClients,
    this.clientNames,
    this.time
  });

  factory DashboardModel.fromJson(Map<String, dynamic> parsedJson) {
    var remainingClientsFromJson = parsedJson['remainingClients'];
    var clientNamesFromJson = parsedJson['clientNames'];
    var timeFromJson = parsedJson['time']; //toTime

    return new DashboardModel(
      remainingClients: remainingClientsFromJson,
      clientNames: clientNamesFromJson,
      time: timeFromJson
    );
  }
}
