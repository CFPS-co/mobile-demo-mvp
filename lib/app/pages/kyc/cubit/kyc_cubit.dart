import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/domain/entities/kyc.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_idensic_mobile_sdk_plugin/flutter_idensic_mobile_sdk_plugin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'kyc_state.dart';

part 'kyc_cubit.freezed.dart';

@injectable
class KycCubit extends Cubit<KycState> {
  KycCubit(this.mvpDemoRepository) : super(const KycState.initial());

  static const emailMock = "test1@test.io";
  static const passwordMock = "123456";

  final MvpDemoRepository mvpDemoRepository;

  void startKyc(BuildContext context) async {
    String emailValue = "";
    String passwordValue = "";
    final email = mvpDemoRepository.getEmail();
    final password = mvpDemoRepository.getPassword();

    email.fold(
      (l) {
        emailValue = emailMock;
      },
      (r) {
        emailValue = r ?? emailMock;
      },
    );

    password.fold(
      (l) {
        passwordValue = passwordMock;
      },
      (r) {
        passwordValue = r ?? passwordMock;
      },
    );

    final credentials = await mvpDemoRepository.getKycCredentials(emailValue, passwordValue);
    credentials.fold(
      (l) => null,
      (r) async {
        await launchSDK(r);
        context.router.pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
        return r;
      },
    );
  }

  Future<SNSMobileSDKResult> launchSDK(Kyc kyc) async {
    String accessToken = kyc.sumsubtoken;
    onTokenExpiration() async {
      return Future<String>.delayed(const Duration(seconds: 2), () => accessToken);
    }

    onStatusChanged(SNSMobileSDKStatus newStatus, SNSMobileSDKStatus prevStatus) {
      print("The SDK status was changed: $prevStatus -> $newStatus");
    }

    final snsMobileSDK = SNSMobileSDK.init(accessToken, onTokenExpiration)
        .withHandlers(
          onStatusChanged: onStatusChanged,
        )
        .withDebug(true)
        // .withTheme(kycTheme)
        .withLocale(const Locale("en"))
        .build();

    final SNSMobileSDKResult result = await snsMobileSDK.launch();
    return result;
  }

  static const kycTheme = {
    "universal": {
      "colors": {
        "primaryButtonBackground": {"light": "#1F504B"},
        "primaryButtonContent": {"light": "#D3EAD4"},
        "secondaryButtonBackground": {"light": "#FFFFFF"},
        "secondaryButtonContent": {"light": "#1F504B"},
        "secondaryButtonContentHighlighted": {"light": "#FFFFFF"},
        "alertTint": {"light": "#1F504B"},
        "contentNeutral": {"light": "#011A1A"}, //Loader, success text, it will take
        "contentWeak": {"light": "#011A1A"},
        //loader, icons verify, powered, By tapping
        "backgroundNeutral": {"light": "#D2DCDB"},
        "contentCritical": {"light": "#FF7070"},
        "backgroundCritical": {"light": "#FFC6C6"},
        "contentWarning": {"light": "#FFD15B"},
        "backgroundWarning": {"light": "#FFEDBD"},
        "contentSuccess": {"light": "#011A1A"},
        "backgroundSuccess": {"light": "#D3EAD4"},

        "contentLink": {"light": "#1F504B"},
        "contentInfo": {"light": "#FF0000"},
        "fieldBackground": {"light": "0x1A011A1A"},
        "navigationBarItem": {"light": "#1F504B"},
      }
    },
  };
}
