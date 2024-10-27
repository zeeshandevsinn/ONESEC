import 'package:client_nfc_mobile_app/controller/services/company%20profile/company_profile_details.dart';
import 'package:client_nfc_mobile_app/controller/services/company%20profile/company_profile_list.dart';
import 'package:client_nfc_mobile_app/controller/services/company%20profile/employee_profile_service.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';

class CompanyProvider extends ChangeNotifier {
  bool isLoading = false;
  CreateCompanyUser(
      context, String token, Map<String, dynamic> profileData) async {
    isLoading = true;
    notifyListeners();
    try {
      final data =
          await CompanyProfileService.createCompanyProfile(token, profileData);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        return data;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  GetCurrentUserProfile(token, username) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await CompanyProfileDetailService.getCompanyProfileDetail(
          token, username);

      if (data != null) {
        isLoading = false;
        notifyListeners();
        return data;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  UpdateCompanyProfile(token, username, profileDetails) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await CompanyProfileDetailService.updateCompanyProfile(
          token, username, profileDetails);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        return data;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  addEmployee(
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
    isLoading = true;
    notifyListeners();
    try {
      final data = await EmployeeProfileServices.addEmployee(token,
          display_email: display_email,
          username: username,
          companyID: companyID,
          firstName: firstName,
          lastName: lastName,
          email: email,
          position: position,
          phone: phone);

      if (data != null) {
        isLoading = false;
        notifyListeners();
        MyToast("Successfully Added");
        return data;
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      MyToast(e.toString(), Type: false);
    }
  }

  getEmployee(token) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await EmployeeProfileServices.fetchEmployees(token);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        MyToast("Employee Fetch Successfully");
        return data;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      // MyToast("Internet Issue", Type: false);
      return null;
    }
  }

  UpdateEmployee({
    required var token,
    required String email,
    required var company,
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
    isLoading = true;
    notifyListeners();
    try {
      final data = await EmployeeProfileServices.updateEmployee(
          token: token,
          email: email,
          companyID: company,
          firstName: firstName,
          lastName: lastName,
          newEmail: email,
          position: position,
          phone: phone);

      if (data != null) {
        isLoading = false;
        notifyListeners();
        MyToast("Successfully Updated Employee Profile");
        return data;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  DeleteEmployee(token, email) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await EmployeeProfileServices.deleteEmployee(email, token);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      // MyToast("Internet Issue 404", Type: false);
      isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
