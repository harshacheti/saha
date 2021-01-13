import 'package:algolia/algolia.dart';

class AlgoliaApplication{
  static final Algolia algolia = Algolia.init(
    applicationId: 'MK4FKGQT13', //ApplicationID
    apiKey: "ebf46ee984b4c1bf1997ec5969632ae7", //search-only api key in flutter code
  );
}