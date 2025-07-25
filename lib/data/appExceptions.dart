class AppExceptions implements Exception{
  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);
  @override
  String toString(){
    return '$_prefix$_message';
  }

}

class InternetExceptions extends AppExceptions{

  InternetExceptions([String ?message]):super(message,'No Internet');
}
class TimeOutExceptions extends AppExceptions{

  TimeOutExceptions([String ?message]):super(message,'Time out');
}

class OtherExceptions extends AppExceptions{

  OtherExceptions([String ?message]):super(message,'');
}
class BadRequestException extends AppExceptions{

  BadRequestException([String ?message]):super(message,'');
}