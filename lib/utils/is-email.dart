String isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(em)) {
    return null;
  } else {
    return "Please enter valid email";
  }
}

String minWidth(String input) {
  return input.length <= 6 ? "Enter at least 6 charactor" : null;
}
