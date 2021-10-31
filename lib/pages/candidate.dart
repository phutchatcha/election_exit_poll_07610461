class Candidate {
  final int candidateNumber;
  final String candidateTitle;
  final String candidateFirstName;
  final String candidateLastName;

  Candidate({
    required this.candidateNumber,
    required this.candidateTitle,
    required this.candidateFirstName,
    required this.candidateLastName,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      candidateNumber: json['candidateNumber'],
      candidateTitle: json['candidateTitle'],
      candidateFirstName: json['candidateFirstName'],
      candidateLastName: json['candidateLastName'],
    );
  }

  Candidate.fromJson2(Map<String, dynamic> json)
      : candidateNumber = json['candidateNumber'],
        candidateTitle = json['candidateTitle'],
        candidateFirstName = json['candidateFirstName'],
        candidateLastName = json['candidateLastName'];
  @override
  String toString() {
    return '$candidateNumber $candidateTitle $candidateFirstName $candidateLastName ';
  }
}
