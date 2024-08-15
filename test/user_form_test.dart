
import 'package:decoder/src/data/provider/user/form/user_form.dart';
import 'package:flutter_test/flutter_test.dart';

main(){
 test("the result of the age validation should be null", (){
  final userForm = UserForm();
  final result  = userForm.validateAge("5");
  expect(result, isNull);
 });

 test("the result of the age validation should be a error message", (){
  final userForm = UserForm();
  const expected = "Please enter a valid age";
  final result  = userForm.validateAge("131");
  expect(result, expected);
 });
}