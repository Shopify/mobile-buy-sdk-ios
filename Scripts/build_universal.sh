#!/bin/sh

UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal
TARGET_NAME="Buy Static"
FRAMEWORK_NAME="Buy"

# make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

# Build Device and Simulator versions
xcodebuild -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -OBJROOT="${OBJROOT}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" SYMROOT="${SYMROOT}" BUILD_ROOT="${BUILD_ROOT}" clean build
xcodebuild -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -OBJROOT="${OBJROOT}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" SYMROOT="${SYMROOT}" BUILD_ROOT="${BUILD_ROOT}" clean build

# Copy the framework structure (from iphoneos build) to the universal folder
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/"

# Create universal binary file using lipo and place the combined executable in the copied framework directory
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"

# Copy the framework to the sample apps folder
rm -rf "${SRCROOT}/../Mobile Buy SDK Sample Apps/${TARGET_NAME}.framework"
cp -r "${UNIVERSAL_OUTPUTFOLDER}/${FRAMEWORK_NAME}.framework" "${SRCROOT}/../Mobile Buy SDK Sample Apps"

