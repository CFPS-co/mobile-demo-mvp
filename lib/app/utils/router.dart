import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/about/about_page.dart';
import 'package:cfps/app/pages/country/country_page.dart';
import 'package:cfps/app/pages/create_password/create_password_page.dart';
import 'package:cfps/app/pages/create_password/your_password_changed_page.dart';
import 'package:cfps/app/pages/dashboard/send_funds/send_funds_details_page.dart';
import 'package:cfps/app/pages/dashboard/send_funds/send_funds_page.dart';
import 'package:cfps/app/pages/home/home_page.dart';
import 'package:cfps/app/pages/kyc/kyc_page.dart';
import 'package:cfps/app/pages/login_with_pin_code/confirm_pin_reset/confirm_pin_reset_page.dart';
import 'package:cfps/app/pages/login_with_pin_code/login_with_pin_code_page.dart';
import 'package:cfps/app/pages/profile/personal_info_page/personal_info_confirmation_page.dart';
import 'package:cfps/app/pages/profile/personal_info_page/personal_info_page.dart';
import 'package:cfps/app/pages/profile/settings/settings_page.dart';
import 'package:cfps/app/pages/profile/tariff_page/tariff_page.dart';
import 'package:cfps/app/pages/profile/widgets/transfer_successful_page.dart';
import 'package:cfps/app/pages/quick_start/quick_start_page.dart';
import 'package:cfps/app/pages/regulations/regulations_page.dart';
import 'package:cfps/app/pages/sign_in/sign_in_page.dart';
import 'package:cfps/app/pages/sign_up/code_verification/sign_up_code_verification_page.dart';
import 'package:cfps/app/pages/sign_up/email/sign_up_email_page.dart';
import 'package:cfps/app/pages/status/status_info_page.dart';

export '../utils/router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: AboutPage),
    AutoRoute(page: ConfirmPinResetPage),
    AutoRoute(page: CountryPage),
    AutoRoute(page: CreatePasswordPage),
    AutoRoute(page: HomePage),
    AutoRoute(page: KycPage),
    AutoRoute(page: LoginWithPinCodePage),
    AutoRoute(page: PersonalInfoConfirmationPage),
    AutoRoute(page: PersonalInfoPage),
    AutoRoute(page: QuickStartPage, initial: true),
    AutoRoute(page: RegulationsPage),
    AutoRoute(page: SendFundsDetailsPage),
    AutoRoute(page: SendFundsPage),
    AutoRoute(page: SettingsPage),
    AutoRoute(page: SignInPage),
    AutoRoute(page: SignUpCodeVerificationPage),
    AutoRoute(page: SignUpEmailPage),
    AutoRoute(page: StatusInfoPage),
    AutoRoute(page: TariffPage),
    AutoRoute(page: TransferSuccessfulPage),
    AutoRoute(page: YourPasswordChangedPage),
  ],
)
class $AppRouter {}
