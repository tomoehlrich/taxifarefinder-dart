class TffException implements Exception {
  String _statusCode = '';

  TffException(String statusCode) {
    _statusCode = statusCode;
  }

  String get code {
    return _statusCode;
  }

  String message() {
    if (_statusCode == 'NO_MATCHING_ENTITY') {
      return 'No entity found within given constraints';
    } else if (_statusCode == 'UNKNOWN_ENTITY') {
      return 'No entity with given entity handle found';
    } else if (_statusCode == 'UNSUPPORTED_ENTITY') {
      return 'The entity handle provided is not a supported entity for the TFF API';
    } else if (_statusCode == 'MISSING_PARAMETER') {
      return 'A required parameter is missing';
    } else if (_statusCode == 'UNKNOWN_PARAMETER') {
      return 'A provided parameter is not valid for this API call';
    } else if (_statusCode == 'WRONG_PARAMETER_TYPE') {
      return 'A given parameter value is of the wrong type';
    } else if (_statusCode == 'INVALID_KEY') {
      return 'API key provided is invalid';
    } else if (_statusCode == 'REQUEST_LIMIT_REACHED') {
      return 'Daily request limit for this API key has been reached';
    } else if (_statusCode == 'REQUEST_TIMED_OUT') {
      return 'The request to the server took too long, try again';
    } else if (_statusCode == 'QUERY_RATE_LIMIT_EXCEEDED') {
      return 'Query rate has been exceeded, throttle queries at 10 or fewer per second';
    } else if (_statusCode == 'NO_ROUTE_FOUND') {
      return 'No route could be found between origin and destination';
    } else if (_statusCode == 'NO_NEARBY_ENTITY') {
      return 'There is not an entity near the origin location';
    } else if (_statusCode == 'ERROR') {
      return 'Unspecified error occurred';
    }

    return 'Error occurred';
  }
}
