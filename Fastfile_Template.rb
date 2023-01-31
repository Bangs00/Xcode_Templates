# 기본 플랫폼 설정
# 차후 Android 적용 검토시 확인 필요 
default_platform(:ios)

# 상수 설정
# 프로젝트에 맞게 값 수정
module Constant
  # 프로젝트 이름
  PROJECT_NAME = "PROJECT_NAME"
  # Slack notification을 보낼 웹 후크 URL
  SLACK_URL = "SLACK_URL"
  # Slack notification icon URL
  SLACK_ICON_URL = "SLACK_ICON_URL"
  # Fastlane에서 애플 인증시 사용할 애플 개발자 계정에 대한 앱 암호
  FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD = "FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD"
  # match passphrase
  MATCH_PASSWORD = "MATCH_PASSWORD"
  # 프로젝트 워크스페이스 파일 이름
  WORKSPACE = "WORKSPACE"
  # Firebase 설치시 발급되는 CLI 토큰
  FIREBASE_CLI_TOKEN = "FIREBASE_CLI_TOKEN"
  # Firebase App Distribution에서 배포할 그룹 이름
  FIREBASE_GROUP_NAME = "FIREBASE_GROUP_NAME"
  # 프로젝트 테스트 코드를 실행할 시뮬레이터
  TESTING_DEVICES = ["TESTING_DEVICE", ...]

  # 앱스토어 커넥트 API 키
  APP_STORE_CONNECT_KEY_ID = "APP_STORE_CONNECT_KEY_ID "
  # Issuer ID
  APP_STORE_CONNECT_ISSUER_ID = "APP_STORE_CONNECT_ISSUER_ID"
  # API key Content
  APP_STORE_CONNECT_KEY_CONTENT = "APP_STORE_CONNECT_KEY_CONTENT"

  # Debug scheme constants
  # scheme 이름
  DEBUG_SCHEME = "DEBUG_SCHEME"
  # app bundle identifier
  DEBUG_BUNDLE_IDENTIFIER = "DEBUG_BUNDLE_IDENTIFIER"
  # app display name
  DEBUG_APP_DISPLAY_NAME = "DEBUG_APP_DISPLAY_NAME"
  # Firebase 앱 등록시 발급되는 app id
  DEBUG_FIREBASE_APP_ID = "DEBUG_FIREBASE_APP_ID"

  # Release scheme constants
  # scheme 이름
  RELEASE_SCHEME = "RELEASE_SCHEME"
  # app bundle identifier
  RELEASE_BUNDLE_IDENTIFIER = "RELEASE_BUNDLE_IDENTIFIER"
  # app display name
  RELEASE_APP_DISPLAY_NAME = "RELEASE_APP_DISPLAY_NAME"
  # Firebase 앱 등록시 발급되는 app id
  RELEASE_FIREBASE_APP_ID = "RELEASE_FIREBASE_APP_ID"
end

# iOS 플랫폼 lanes
platform :ios do
  # 특정 lane 실행 전 실행되는 블록
  before_all do
    app_store_connect_api_key(
      key_id: Constant::APP_STORE_CONNECT_KEY_ID,
      issuer_id: Constant::APP_STORE_CONNECT_ISSUER_ID,
      key_content: Constant::APP_STORE_CONNECT_KEY_CONTENT
    )
    ENV["SLACK_URL"] = Constant::SLACK_URL
    ENV["FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD"] = Constant::FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD
    ENV["MATCH_PASSWORD"] = Constant::MATCH_PASSWORD
  end
  # 특정 lane 실행 후 실행되는 블록
  after_all do |lane|

  end
  # 특정 lane에서 에러 발생시 실행되는 블록
  error do |lane, exception|
    case lane.to_s 
    when "update_pods"
      slack(
        username: Constant::PROJECT_NAME,
        icon_url: Constant::SLACK_ICON_URL,
        pretext: "<!here|here>\n*#{Constant::PROJECT_NAME} Pod 업데이트 실패*",
        success: false,
        payload: {
          "App version" => "#{get_version_number}",
          "Build number" => "#{get_build_number}"
        },
        default_payloads: []
      )
    when "deploy_debug_to_firebase"
      slack(
        username: Constant::PROJECT_NAME,
        icon_url: Constant::SLACK_ICON_URL,
        pretext: "<!here|here>\n*#{Constant::PROJECT_NAME} 개발 빌드 Firebase 배포 실패*",
        success: false,
        payload: {
          "App version" => "#{get_version_number}",
          "Build number" => "#{get_build_number}"
        },
        default_payloads: ["git_branch", "last_git_commit", "last_git_commit_hash"]
      )
    when "deploy_release_to_firebase"
      slack(
        username: Constant::PROJECT_NAME,
        icon_url: Constant::SLACK_ICON_URL,
        pretext: "<!here|here>\n*#{Constant::PROJECT_NAME} 배포 빌드 Firebase 배포 실패*",
        success: false,
        payload: {
          "App version" => "#{get_version_number}",
          "Build number" => "#{get_build_number}"
        },
        default_payloads: ["git_branch", "last_git_commit", "last_git_commit_hash"]
      )
    when "deploy_release_to_testflight"
      slack(
        username: Constant::PROJECT_NAME,
        icon_url: Constant::SLACK_ICON_URL,
        pretext: "<!here|here>\n*#{Constant::PROJECT_NAME} 배포 빌드 Testflight 배포 실패*",
        success: false,
        payload: {
          "App version" => "#{get_version_number}",
          "Build number" => "#{get_build_number}"
        },
        default_payloads: ["git_branch", "last_git_commit", "last_git_commit_hash"]
      )
    end
  end

  # Provisioning Profile 생성
  desc "Create provisioning profiles"
  lane :create_provisioning_profiles do
    sync_code_signing(app_identifier: Constant::RELEASE_BUNDLE_IDENTIFIER,
                      type: "development",
                      readonly: false,
                      force_for_new_devices: true)
    sync_code_signing(app_identifier: Constant::RELEASE_BUNDLE_IDENTIFIER,
                      type: "appstore",
                      readonly: false,
                      force_for_new_devices: true)
    sync_code_signing(app_identifier: Constant::RELEASE_BUNDLE_IDENTIFIER,
                      type: "adhoc",
                      readonly: false,
                      force_for_new_devices: true)
    sync_code_signing(app_identifier: Constant::DEBUG_BUNDLE_IDENTIFIER,
                      type: "development",
                      readonly: false,
                      force_for_new_devices: true)
    sync_code_signing(app_identifier: Constant::DEBUG_BUNDLE_IDENTIFIER,
                      type: "appstore",
                      readonly: false,
                      force_for_new_devices: true)
    sync_code_signing(app_identifier: Constant::DEBUG_BUNDLE_IDENTIFIER,
                      type: "adhoc",
                      readonly: false,
                      force_for_new_devices: true)
  end
  # Provisioning Profile 동기화
  desc "Fetch provisioning profiles"
  lane :fetch_provisioning_profiles do
    sync_code_signing(app_identifier: Constant::RELEASE_BUNDLE_IDENTIFIER,
                      type: "development",
                      readonly: true)
    sync_code_signing(app_identifier: Constant::RELEASE_BUNDLE_IDENTIFIER,
                      type: "appstore",
                      readonly: true)
    sync_code_signing(app_identifier: Constant::RELEASE_BUNDLE_IDENTIFIER,
                      type: "adhoc",
                      readonly: true)
    sync_code_signing(app_identifier: Constant::DEBUG_BUNDLE_IDENTIFIER,
                      type: "development",
                      readonly: true)
    sync_code_signing(app_identifier: Constant::DEBUG_BUNDLE_IDENTIFIER,
                      type: "appstore",
                      readonly: true)
    sync_code_signing(app_identifier: Constant::DEBUG_BUNDLE_IDENTIFIER,
                      type: "adhoc",
                      readonly: true)
  end
  # Pods 업데이트
  desc "Update pods"
  lane :update_pods do
    increase_build_number_from_firebase
    cocoapods(
      use_bundle_exec: false
    )
    slack(
      username: Constant::PROJECT_NAME,
      icon_url: Constant::SLACK_ICON_URL,
      pretext: "*#{Constant::PROJECT_NAME} Pod 업데이트 완료*",
      success: true,
      payload: {
        "App version" => "#{get_version_number}",
        "Build number" => "#{get_build_number}"
      },
      default_payloads: []
    )
  end
  # 테스트 코드 실행
  desc "Run tests"
  lane :run_test_codes do
    increase_build_number_from_firebase
    run_tests(
      workspace: Constant::WORKSPACE,
      scheme: Constant::DEBUG_SCHEME,
      devices: Constant::TESTING_DEVICES,
      reinstall_app: true,
      app_identifier: Constant::DEBUG_BUNDLE_IDENTIFIER,
      clean: true,
      app_name: "*#{Constant::PROJECT_NAME}*",
      configuration: "Debug",
      slack_username: Constant::PROJECT_NAME,
      slack_icon_url: Constant::SLACK_ICON_URL,
      slack_message: ">*App version*\n>#{get_version_number}\n>*Build number*\n>#{get_build_number}",
      slack_default_payloads: ["test_result", "git_branch", "last_git_commit", "last_git_commit_hash"]
    )
  end
  # Debug scheme Firebase App Distribution에 배포
  desc "Deploy debug scheme to Firebase App Distribution"
  lane :deploy_debug_to_firebase do
    increase_build_number_from_firebase
    sync_code_signing(
      type: "adhoc",
      force_for_new_devices: true
    )
    build_app(
      scheme: Constant::DEBUG_SCHEME,
      workspace: Constant::WORKSPACE,
      export_method: "ad-hoc",
      clean: true,
      include_bitcode: false,
      configuration: "Debug"
    )
    firebase_app_distribution(
      app: Constant::DEBUG_FIREBASE_APP_ID,
      firebase_cli_token: Constant::FIREBASE_CLI_TOKEN,
      groups: Constant::FIREBASE_GROUP_NAME,
      debug: true
    )
    build_number = get_debug_build_number_from_firebase
    slack(
      username: Constant::PROJECT_NAME,
      icon_url: Constant::SLACK_ICON_URL,
      pretext: "*#{Constant::PROJECT_NAME} 개발 빌드 Firebase 배포 완료*",
      success: true,
      payload: {
        "App version" => "#{get_version_number}",
        "Build number" => "#{build_number}"
      },
      default_payloads: ["git_branch", "last_git_commit", "last_git_commit_hash"]
    )
  end
  # Release scheme Firebase App Distribution에 배포
  desc "Deploy release scheme to Firebase App Distribution"
  lane :deploy_release_to_firebase do
    increase_build_number_from_firebase
    sync_code_signing(
      type: "adhoc",
      force_for_new_devices: true
    )
    build_app(
      scheme: Constant::RELEASE_SCHEME,
      workspace: Constant::WORKSPACE,
      export_method: "ad-hoc",
      clean: true,
      include_bitcode: false,
      configuration: "Release"
    )
    firebase_app_distribution(
      app: Constant::RELEASE_FIREBASE_APP_ID,
      firebase_cli_token: Constant::FIREBASE_CLI_TOKEN,
      groups: Constant::FIREBASE_GROUP_NAME,
      debug: true
    )
    build_number = get_release_build_number_from_firebase
    slack(
      username: Constant::PROJECT_NAME,
      icon_url: Constant::SLACK_ICON_URL,
      pretext: "*#{Constant::PROJECT_NAME} 배포 빌드 Firebase 배포 완료*",
      success: true,
      payload: {
        "App version" => "#{get_version_number}",
        "Build number" => "#{build_number}"
      },
      default_payloads: ["git_branch", "last_git_commit", "last_git_commit_hash"]
    )
  end
  # Debug, Release scheme Firebase App Distribution에 배포
  desc "Deploy debug, release scheme to Firebase App Distribution"
  lane :deploy_to_firebase do
    deploy_debug_to_firebase
    deploy_release_to_firebase
  end
  # Release scheme Testflight에 배포
  desc "Deploy release scheme to Testflight"
  lane :deploy_release_to_testflight do
    set_build_number_from_firebase
    sync_code_signing(
      type: "appstore",
      force_for_new_devices: true
    )
    build_app(
      scheme: Constant::RELEASE_SCHEME,
      workspace: Constant::WORKSPACE,
      export_method: "app-store",
      clean: true,
      include_bitcode: false,
      configuration: "Release"
    )
    upload_to_testflight(
      notify_external_testers: false
    )
    build_number = get_build_number_from_testflight
    slack(
      username: Constant::PROJECT_NAME,
      icon_url: Constant::SLACK_ICON_URL,
      pretext: "*#{Constant::PROJECT_NAME} 배포 빌드 Testflight 배포 완료*",
      success: true,
      payload: {
        "App version" => "#{get_version_number}",
        "Build number" => "#{build_number}"
      },
      default_payloads: ["git_branch", "last_git_commit", "last_git_commit_hash"]
    )
  end
end

# Methods
def get_debug_build_number_from_firebase
  firebase_version_number = firebase_app_distribution_get_latest_release(
    app: Constant::DEBUG_FIREBASE_APP_ID,
    firebase_cli_token: Constant::FIREBASE_CLI_TOKEN
  ).nil? ? "1" : firebase_app_distribution_get_latest_release(
    app: Constant::DEBUG_FIREBASE_APP_ID,
    firebase_cli_token: Constant::FIREBASE_CLI_TOKEN
  )[:displayVersion]

  if get_version_number != firebase_version_number
    return 1
  end

  build_number = firebase_app_distribution_get_latest_release(
    app: Constant::DEBUG_FIREBASE_APP_ID,
    firebase_cli_token: Constant::FIREBASE_CLI_TOKEN
  ).nil? ? "1" : firebase_app_distribution_get_latest_release(
    app: Constant::DEBUG_FIREBASE_APP_ID,
    firebase_cli_token: Constant::FIREBASE_CLI_TOKEN
  )[:buildVersion]

  return build_number.to_i
end

def get_release_build_number_from_firebase
  firebase_version_number = firebase_app_distribution_get_latest_release(
    app: Constant::RELEASE_FIREBASE_APP_ID,
    firebase_cli_token: Constant::FIREBASE_CLI_TOKEN
  ).nil? ? "1" : firebase_app_distribution_get_latest_release(
    app: Constant::RELEASE_FIREBASE_APP_ID,
    firebase_cli_token: Constant::FIREBASE_CLI_TOKEN
  )[:displayVersion]

  if get_version_number != firebase_version_number
    return 1
  end

  build_number = firebase_app_distribution_get_latest_release(
    app: Constant::RELEASE_FIREBASE_APP_ID,
    firebase_cli_token: Constant::FIREBASE_CLI_TOKEN
  ).nil? ? "1" : firebase_app_distribution_get_latest_release(
    app: Constant::RELEASE_FIREBASE_APP_ID,
    firebase_cli_token: Constant::FIREBASE_CLI_TOKEN
  )[:buildVersion]

  return build_number.to_i
end

def get_build_number_from_testflight
  build_number = latest_testflight_build_number(
    app_identifier: Constant::RELEASE_BUNDLE_IDENTIFIER,
    version: get_version_number,
    platform: "ios"
  )

  return build_number.to_i
end

def get_build_number_from_firebase
  debug_build_number = get_debug_build_number_from_firebase
  release_build_number = get_release_build_number_from_firebase

  if debug_build_number == release_build_number
    return debug_build_number
  else
    raise StandardError.new "Check Firebase App Distribution debug and release build number"
  end
end

def set_build_number_from_firebase
  firebase_debug_scheme_build_number = get_debug_build_number_from_firebase
  firebase_release_scheme_build_number = get_release_build_number_from_firebase

  build_number_array = [
    firebase_debug_scheme_build_number,
    firebase_release_scheme_build_number
  ]
  new_build_number = build_number_array.max

  increment_build_number(
    build_number: new_build_number
  )

  return new_build_number
end

def set_build_number_from_testflight
  testflight_build_number = get_build_number_from_testflight

  new_build_number = build_number

  increment_build_number(
    build_number: new_build_number
  )
  
  return new_build_number
end

def increase_build_number_from_firebase
  firebase_debug_scheme_build_number = get_debug_build_number_from_firebase
  firebase_release_scheme_build_number = get_release_build_number_from_firebase

  build_number_array = [
    firebase_debug_scheme_build_number,
    firebase_release_scheme_build_number
  ]

  if build_number_array.min == build_number_array.max
    new_build_number = build_number_array.max + 1
  else
    new_build_number = build_number_array.max
  end

  increment_build_number(
    build_number: new_build_number
  )

  return new_build_number
end
