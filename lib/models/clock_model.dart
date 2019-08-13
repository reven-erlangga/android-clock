import 'package:scoped_model/scoped_model.dart';

class ClockModel extends Model {
  int _dayParameter=DateTime.now().weekday;
  String _dayString="-", _monthString="-";

  int get dayParameter => _dayParameter;
  String get dayString => _dayString;
  String get monthString => _monthString;
  
  void getDayString () {
    switch (DateTime.now().weekday) {
      case 1:
        _dayString = "Mon"; break;
      case 2:
        _dayString = "Tue"; break;
      case 3:
        _dayString = "Wed"; break;
      case 4:
        _dayString = "Thurs"; break;
      case 5:
        _dayString = "Fri"; break;
      case 6:
        _dayString = "Sat"; break;
      case 7:
        _dayString = "Sun"; break;
      default:
        _dayString = "Uknown";
    }
    notifyListeners();
  }

  void getMonthString(){
    switch (DateTime.now().month) {
      case 1:
        _monthString = "Jan"; break;
      case 2:
        _monthString = "Feb"; break;
      case 3:
        _monthString = "Mar"; break;
      case 4:
        _monthString = "Apr"; break;
      case 5:
        _monthString = "May"; break;
      case 6:
        _monthString = "Jun"; break;
      case 7:
        _monthString = "Jul"; break;
      case 8:
        _monthString = "Aug"; break;
      case 9:
        _monthString = "Sept"; break;
      case 10:
        _monthString = "Oct"; break;
      case 11:
        _monthString = "Nov"; break;
      case 12:
        _monthString = "Dec"; break;
      default:
        _monthString = "Uknown";
    }
    notifyListeners();
  }
}
