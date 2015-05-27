
######################
# Options
######################

REVEAL_ARCHIVE_IN_FINDER=true

FRAMEWORK_NAME="Buy"
FRAMEWORK_NAME_FRAMEWORK="${FRAMEWORK_NAME}.framework"
UNIVERSAL_LIBRARY_DIR="${BUILD_DIR}/${FRAMEWORK_NAME}"
FRAMEWORK="${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME_FRAMEWORK}"
CONFIGURATION="Debug"

DIR_ARM="${BUILD_DIR}/build-arm"
DIR_x8664="${BUILD_DIR}/build-x86_64"

######################
# Build Frameworks
######################

xcodebuild -scheme ${FRAMEWORK_NAME} -configuration ${CONFIGURATION} -sdk "iphoneos8.3" clean build ARCHS="armv7 armv7s arm64" IPHONEOS_DEPLOYMENT_TARGET="8.0" TARGET_BUILD_DIR="${DIR_ARM}" BUILT_PRODUCTS_DIR="${DIR_ARM}"
xcodebuild -scheme ${FRAMEWORK_NAME} -configuration ${CONFIGURATION} -sdk "iphonesimulator8.3" clean build ARCHS="x86_64" IPHONEOS_DEPLOYMENT_TARGET="8.0" TARGET_BUILD_DIR="${DIR_x8664}" BUILT_PRODUCTS_DIR="${DIR_x8664}"

######################
# Create directory for universal
######################

rm -rf "${UNIVERSAL_LIBRARY_DIR}"
mkdir "${UNIVERSAL_LIBRARY_DIR}"
mkdir "${FRAMEWORK}"

######################
# Copy files Framework
######################

cp -r "${DIR_ARM}/${FRAMEWORK_NAME_FRAMEWORK}/." "${FRAMEWORK}"
rm -rf "${FRAMEWORK}/PrivateHeaders"
rm -rf "${FRAMEWORK}/_CodeSignature"

######################
# Make a universal binary
######################
lipo -create "${DIR_ARM}/${FRAMEWORK_NAME_FRAMEWORK}/${FRAMEWORK_NAME}" "${DIR_x8664}/${FRAMEWORK_NAME_FRAMEWORK}/${FRAMEWORK_NAME}" -output "${FRAMEWORK}/${FRAMEWORK_NAME}" | echo

