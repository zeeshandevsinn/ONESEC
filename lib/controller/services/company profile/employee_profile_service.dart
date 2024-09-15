import 'dart:convert';

import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:http/http.dart' as http;

class EmployeeProfileServices {
  static fetchEmployees(token) async {
    final completeURL = EndPointsURLs.BASE_URL + "api/employees/";
    final url = Uri.parse(completeURL);
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final _employees = json.decode(response.body);
        return _employees;
      } else if (response.statusCode == 401) {
        MyToast('Authentication credentials were not provided.', Type: false);
        return null;
      } else {
        MyToast('Failed to load employees', Type: false);
        return null;
      }
    } catch (error) {
      MyToast(error.toString(), Type: false);
      return null;
    }
  }

  static addEmployee(
    token, {
    required int? companyID,
    required String? firstName,
    required String? lastName,
    required String email,
    required String position,
    required String? phone,
    required String? display_email,
    required String? username,
    String? address,
    String? bio,
    String? facebook,
    String? instagram,
    String? website,
    String? linkedin,
    String? github,
    String? whatsapp,
    String? profilePic,
  }) async {
    final completeURL = EndPointsURLs.BASE_URL + "api/employees/";
    final url = Uri.parse(completeURL);
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'company': companyID,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'position': position,
          'phone': phone,
          'address': address,
          'bio': bio,
          'facebook': facebook,
          'instagram': instagram,
          'display_email': display_email,
          'username': username,
          'website': website,
          'linkedin': linkedin,
          'github': github,
          'whatsapp': whatsapp,
          'profile_pic': profilePic,
        }),
      );

      if (response.statusCode == 201) {
        final newEmployee = json.decode(response.body);
        // _employees.add(newEmployee);
        return newEmployee;
        // notifyListeners();
      } else if (response.statusCode == 400) {
        MyToast('Validation errors: ${response.body}', Type: false);
        return null;
      } else {
        MyToast('Failed to create employee', Type: false);
        return null;
      }
    } catch (error) {
      MyToast(error.toString(), Type: false);
      return null;
    }
  }

  static Future<void> fetchEmployeeDetail(String email, _token) async {
    final completeURL = EndPointsURLs.BASE_URL + "api/employees/$email/";
    final url = Uri.parse(completeURL);
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $_token',
        },
      );

      if (response.statusCode == 200) {
        final _employeeDetail = json.decode(response.body);
        return _employeeDetail;
        // notifyListeners();
      } else if (response.statusCode == 404) {
        MyToast('Employee does not exist.', Type: false);
        return null;
      } else {
        MyToast('Failed to load employee detail', Type: false);
        return null;
      }
    } catch (error) {
      MyToast(error.toString(), Type: false);
      return null;
    }
  }

  // Update employee detail
  static updateEmployee({
    required var token,
    required String email,
    required var companyID,
    String? firstName,
    String? lastName,
    String? newEmail,
    String? position,
    String? phone,
    String? address,
    String? bio,
    String? facebook,
    String? instagram,
    String? website,
    String? linkedin,
    String? github,
    String? whatsapp,
    String? profilePic,
  }) async {
    final completeURL = EndPointsURLs.BASE_URL + "api/employees/$email/";
    final url = Uri.parse(completeURL);
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'company': companyID,
          'first_name': firstName,
          'last_name': lastName,
          'email': newEmail,
          'position': position,
          'phone': phone,
          'address': address,
          'bio': bio,
          'facebook': facebook,
          'instagram': instagram,
          'website': website,
          'linkedin': linkedin,
          'github': github,
          'whatsapp': whatsapp,
          'profile_pic': profilePic,
        }),
      );

      if (response.statusCode == 200) {
        final _employeeDetail = json.decode(response.body);

        return _employeeDetail;
      } else if (response.statusCode == 400) {
        MyToast('Validation errors: ${response.body}', Type: false);
        return null;
      } else {
        MyToast('Failed to create employee', Type: false);
        return null;
      }
    } catch (error) {
      MyToast(error.toString(), Type: false);
      return null;
    }
  }

  // Delete employee
  static deleteEmployee(String email, token) async {
    final completeURL = EndPointsURLs.BASE_URL + "api/employees/$email/";
    final url = Uri.parse(completeURL);
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 204) {
        MyToast("Successfully Delete Employee");
        // _employees.removeWhere((employee) => employee['email'] == email);
        return true;
        // notifyListeners();
      } else if (response.statusCode == 403) {
        MyToast('You do not have permission to perform this action.',
            Type: false);
      } else {
        MyToast('Failed to delete employee', Type: false);
      }
    } catch (error) {
      MyToast(error.toString(), Type: false);
    }
  }
}
