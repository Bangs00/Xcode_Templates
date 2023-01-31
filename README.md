# Template lists
* File Template
  * Custom Collection View Cell
  * Custom Collection Reusable View
  * MVVM
  * StoryboardInstantiable
* Project Template
  * Custom iOS Application
* Fastlane Fastfile Template
  * Fastfile_Template
<br/><br/>

# Template Usage
* ```~/Library/Developer/Xcode/Templates``` 경로에 Template 종류에 따라 하위 디렉토리인 ```File Templates```, ```Project Templates```에 저장
  * 로컬 저장이므로 여러 기기에서 사용하려면 각 기기마다 저장해야 함

OR
* ```/Application/Xcode.app/Contents/Developer/Library/Xcode/Templates``` 경로에 Template 종류에 따라 하위 디렉토리인 ```File Templates```, ```Project Templates```에 저장
  * 로컬 저장인 것은 마찬가지이나 Xcode 어플리케이션 하위에 저장하는 것이므로 Xcode 업데이트시 다시 저장해야 함
<br/><br/>

ps. ```File Templates```, ```Project Templates``` 디렉토리가 존재하지 않을 경우 해당 디렉토리 생성 필요
<br/><br/>

# Detail
* File Template
  * Custom Collection View Cell
    * ```CollectionViewCell.swift```: cell을 설정하는 ```configure(with cellData: CELLDATA)``` 함수 및 Dynamic Sizing 함수가 작성되어 있음
    * ```CollectionViewCell.xib```: ```SafeArea``` 및 ```SafeAreaMargin```이 ```false```로 설정되어 있음
  * Custom Collection Reusable View
    * ```CollectionReusableView.swift```: view를 설정하는 ```configure(with viewModel: VIEWMODEL)``` 함수 및 Dynamic Sizing 함수가 작성되어 있음
    * ```CollectionReusableView.xib```: ```SafeArea``` 및 ```SafeAreaMargin```이 ```false```로 설정되어 있음
  * MVVM
    * ```ViewController.swift```: 초기화 함수(```create(with viewModel: VIVEWMODEL) -> VIEWCONTROLLER```)와 ```ViewController```에 대한 ```ViewModel```이 선언되어 있음
      * 아래에 있는 ```StoryboradInstantiable.swift```파일의 ```instantiateViewController()``` 함수가 필요함
    * ```ViewModel.swift```: Input, Output Protocol 및 ViewModel Actions 작성 영역이 나누어져 있음
    * ```ViewController.xib```: 1개의 ```ViewController```가 존재하며 해당 ViewController의 ```Background Color```가 ```Default```로 설정되어 있음
  * StoryboardInstantiable
    * Storyboard 혹은 Nib에서 ViewController를 인스턴스화 하는 protocol을 UIViewController에서 준수하는 코드가 확장으로 작성되어 있음
* Project Template
  * Custom iOS Application
    * MVVM + Clean Architecture + Rx
      * Alamofire, RxSwift, RxAlamofire에 의존성이 존재하므로 염연히 말하면 Clean Architecture가 아님
    * Cocoapods를 통해 Alamofire, RxSwift, RxAlamofire를 설치해야 함
    * 최상위 폴더에 있는 ```AppDelegate.swift```, ```ContentView.swift``` 파일을 삭제해야 함
      * 차후 Template자체적으로 제외할 수 있는 방법 추가 예정
    * 프로젝트 파일에서 메인 앱 타겟의 Build Settings에서 User-Defined 항목에 API_BASE_URL 값을 scheme에 따라 설정해야 함
    * 프로젝트 파엘에서 메인 앱 타겟의 Build Settings에서 Info.plist 파일 경로를 설정해야함
      * Template에서는 ```PROJECT/Resources``` 경로에 Info.plist파일을 생성함
* Fastlane Fastfile Template
  * Fastfile_Template
    * Testflight 및 Firebase App Distribution에 Debug, Release 빌드를 업로드하는 lane들이 선언되어 있음
    * Firebase App Distribution에서 Debug, Release 빌드 2개를 등록하고 ```GoogleService-Info.plist``` 파일을 각 빌드에 따라 이름을 변경하여 프로젝트에 추가해주어야 하며 프로젝트 파일에서 Build Phase에 Run Script Phase를 Compile Source Phase위에 생성하고 빌드시에 scheme에 따라 복사해서 최상위 디렉토리에 생성하도록 해야 함
      * **Run Script example**
```
PATH_TO_GOOGLE_PLISTS="${PROJECT_DIR}/PROJECT_NAME/Resources"

case "${CONFIGURATION}" in

   "Debug" )
        cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-debug.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;

   "Release" )
        cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-release.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;

    *)
        ;;
esac
```
<br/><br/>

# Reference
* <https://github.com/kudoleh/iOS-Clean-Architecture-MVVM>
* <https://github.com/sergdort/CleanArchitectureRxSwift>
* <https://firebase.google.com/docs/app-distribution/ios/distribute-fastlane?hl=en>
* <https://docs.fastlane.tools/>
