class Prediction {
  final String results;
  final String status;

  Prediction(this.results, this.status);

  Prediction.fromJson(Map<String, dynamic> json)
      : results = json['results'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
    'results': results,
    'status': status,
  };
}


class PredictionsPrediction {
  late String description;

  PredictionsPrediction(
      {required this.description});

  PredictionsPrediction.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    return data;
  }
}

//suggestion class over
class SuggestionPred
{
  late String description;

  SuggestionPred(this.description);

  @override
  String toString() {
    return 'SuggestionPred(description: $description)';
  }
}