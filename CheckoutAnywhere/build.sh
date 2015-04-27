
######################
# Options
######################

REVEAL_ARCHIVE_IN_FINDER=false

FRAMEWORK_NAME="Checkout"
FRAMEWORK_NAME_FRAMEWORK="${FRAMEWORK_NAME}.framework"
UNIVERSAL_LIBRARY_DIR="${BUILD_DIR}/${FRAMEWORK_NAME}"
FRAMEWORK="${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME_FRAMEWORK}"

DIR_ARM="${BUILD_DIR}/build-arm"
DIR_ARM64="${BUILD_DIR}/build-arm64"
DIR_i386="${BUILD_DIR}/build-i386"
DIR_x8664="${BUILD_DIR}/build-x86_64"

######################
# Build Frameworks
######################

xcodebuild -scheme ${FRAMEWORK_NAME} -configuration "Release" -sdk "iphoneos8.3" clean build ARCHS="armv7 armv7s" IPHONEOS_DEPLOYMENT_TARGET="8.0" TARGET_BUILD_DIR="${DIR_ARM}" BUILT_PRODUCTS_DIR="${DIR_ARM}"
xcodebuild -scheme ${FRAMEWORK_NAME} -configuration "Release" -sdk "iphoneos8.3" clean build ARCHS="arm64" IPHONEOS_DEPLOYMENT_TARGET="8.0" TARGET_BUILD_DIR="${DIR_ARM64}" BUILT_PRODUCTS_DIR="${DIR_ARM64}"
xcodebuild -scheme ${FRAMEWORK_NAME} -configuration "Release" -sdk "iphonesimulator8.3" clean build ARCHS="i386" IPHONEOS_DEPLOYMENT_TARGET="8.0" TARGET_BUILD_DIR="${DIR_i386}" BUILT_PRODUCTS_DIR="${DIR_i386}"
xcodebuild -scheme ${FRAMEWORK_NAME} -configuration "Release" -sdk "iphonesimulator8.3" clean build ARCHS="x86_64" VALID_ARCHS="x86_64" IPHONEOS_DEPLOYMENT_TARGET="8.0" TARGET_BUILD_DIR="${DIR_x8664}" BUILT_PRODUCTS_DIR="${DIR_x8664}"

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

######################
# Make an universal binary
######################

# create universal library
lipo -create "${DIR_ARM}/${FRAMEWORK_NAME_FRAMEWORK}/${FRAMEWORK_NAME}" "${DIR_ARM64}/${FRAMEWORK_NAME_FRAMEWORK}/${FRAMEWORK_NAME}" "${DIR_i386}/${FRAMEWORK_NAME_FRAMEWORK}/${FRAMEWORK_NAME}" "${DIR_x8664}/${FRAMEWORK_NAME_FRAMEWORK}/${FRAMEWORK_NAME}" -output "${FRAMEWORK}/${FRAMEWORK_NAME}" | echo
