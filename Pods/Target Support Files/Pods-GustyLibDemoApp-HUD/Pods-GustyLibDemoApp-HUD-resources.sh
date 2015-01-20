#!/bin/sh
set -e

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm\""
      xcrun mapc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
          install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/056-PlusCircle.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/056-PlusCircle@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/191-ArrowHead-left.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/191-ArrowHead-left@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/191-ArrowHead-right.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/191-ArrowHead-right@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/248-QuestionCircleAlt.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/248-QuestionCircleAlt@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/248-QuestionCircleAlt_black.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/248-QuestionCircleAlt_black@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/271-ThreeColumn.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/271-ThreeColumn@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/277-MultiplyCircle-black.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/277-MultiplyCircle-black@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/277-MultiplyCircle-white.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/277-MultiplyCircle-white@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/310-RemoveButton.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/310-RemoveButton@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net/License.rtf"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/iconshock.com/internalWebBrowserActivity@2x~ipad.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/iconshock.com/internalWebBrowserActivity@2x~iphone.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/iconshock.com/internalWebBrowserActivity~ipad.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/iconshock.com/internalWebBrowserActivity~iphone.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/action.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/back.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/forward.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/refresh.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/stop.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPhone/back.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPhone/back@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPhone/forward.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPhone/forward@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFAAboutCustomView.xib"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFAEntityConfig.plist"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFAFormInputAccessoryContentView.xib"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFAFormSectionFooterContentView.xib"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFAFormSectionHeaderView.xib"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFAFormTableViewCellContentView.xib"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFAMapSettingsViewController.storyboard"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFAMultipleSelectionListViewCell.xib"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFASingleSelectionListViewControllerHeaderView.xib"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/IFATableSectionHeaderView.xib"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_1PixelLineHorizontalBottom.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_1PixelLineHorizontalBottom@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_1PixelLineHorizontalTop.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_1PixelLineHorizontalTop@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_1PixelLineVerticalLeft.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_1PixelLineVerticalLeft@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_1PixelLineVerticalRight.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_1PixelLineVerticalRight@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_Add.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_AddToSelection.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_AddToSelection@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_Close.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_Close@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_ICon_Delete.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_ICon_Delete@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_DisclosureIndicatorDown.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_DisclosureIndicatorDown@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_DisclosureIndicatorRight.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_DisclosureIndicatorRight@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_HudError.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_HudError@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_HudError@3x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_HudSuccess.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_HudSuccess@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_HudSuccess@3x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_Info.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_Info@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_List.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_List@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_Next.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_Next@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_Previous.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_Previous@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_RemoveFromSelection.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_RemoveFromSelection@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_UserLocation.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_Icon_UserLocation@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_TextViewBorder.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/images/IFA_TextViewBorder@2x.png"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/billybarker.net"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/iconshock.com"
                    install_resource "../../GustyLib/GustyLib_development/GustyLib/GustyLib/CoreUI/resources/3rd party/SVWebViewController/SVWebViewController.bundle"
          
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ `find . -name '*.xcassets' | wc -l` -ne 0 ]
then
  case "${TARGETED_DEVICE_FAMILY}" in
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;
  esac
  find "${PWD}" -name "*.xcassets" -print0 | xargs -0 actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
