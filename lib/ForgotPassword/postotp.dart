import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:first_app/Globalz.dart' as globals;

class PostOtp {
  sendotp(String email) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    String url = 'http://10.0.2.2:8009/vivek/vdapi/sendotp';

    String json = globals.email.trim();
    Response res =
        await http.post('http://vivekdamanibacks.in/Meet/vdapi/sendotp',
            // url,
            body: json,
            headers: headers);
    print(res.body);
    if (res.statusCode == 200 && res.body.contains("Succes")) {
      return "Success";
    } else {
      return "Not";
    }
  }

  verify(String otp) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    String url = 'http://10.0.2.2:8009/vivek/vdapi/verifyop';

    ///String json = "meetngandhi@gmail.com" + "~~~" + otp;
    String json = globals.email.trim() + "~~~" + otp;
    Response res =
        await http.post('http://vivekdamanibacks.in/Meet/vdapi/verifyop',
            // url,
            body: json,
            headers: headers);

    if (res.statusCode == 200 && res.body.contains("Succes")) {
      return "Success";
    } else {
      return "Not";
    }
  }

  sendcustom(String date, slot) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    String url = 'http://10.0.2.2:8009/Meet/vdapi/sendnewtimings';

    ///String json = "meetngandhi@gmail.com" + "~~~" + otp;
    String json = globals.email.trim() + "~~~" + date + "~~~" + slot;
    Response res =
        await http.post('http://vivekdamanibacks.in/Meet/vdapi/sendnewtimings',
            //url,
            body: json,
            headers: headers);
    print(res.body);
    if (res.statusCode == 200 && res.body.contains("Send")) {
      return "Success";
    } else {
      return "Not";
    }
  }

  cngrprs(String pass) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    String url = 'http://10.0.2.2:8009/vivek/vdapi/chnghelsgvapasswfda';

    //String json = "meetngandhi@gmail.com" + "~~~" + pass;
    String json = globals.email.trim() + "~~~" + pass;
    Response res = await http.post(
        'http://vivekdamanibacks.in/Meet/vdapi/chnghelsgvapasswfda',
        //  url,
        body: json,
        headers: headers);

    if (res.statusCode == 200 && res.body.contains("Succes")) {
      return "Success";
    } else {
      return "Not";
    }
  }
}
