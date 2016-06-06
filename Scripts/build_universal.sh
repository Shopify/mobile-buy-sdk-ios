#!/bin/sh

UNIVERSAL_OUTPUTFOLDER="${BUILD_DIR}/${CONFIGURATION}-universal"
IPHONE_OUTPUTFOLDER="${BUILD_DIR}/${CONFIGURATION}-iphoneos"
SIMULATOR_OUTPUTFOLDER="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator"

FRAMEWORK_NAME="Buy"
FRAMEWORK_FILE="${FRAMEWORK_NAME}.framework"
TARGET_NAME="Buy"

# Build Device and Simulator versions
xcodebuild -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos        OBJROOT="${OBJROOT}" BUILD_DIR="${BUILD_DIR}" SYMROOT="${SYMROOT}" BUILD_ROOT="${BUILD_ROOT}" MACH_O_TYPE=staticlib clean build
xcodebuild -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator OBJROOT="${OBJROOT}" BUILD_DIR="${BUILD_DIR}" SYMROOT="${SYMROOT}" BUILD_ROOT="${BUILD_ROOT}" MACH_O_TYPE=staticlib clean build

# make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

# Copy the framework structure (from iphoneos build) to the universal folder
cp -R "${IPHONE_OUTPUTFOLDER}/${FRAMEWORK_FILE}" "${UNIVERSAL_OUTPUTFOLDER}/"

# Create universal binary file using lipo and place the combined executable in the copied framework directory
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${FRAMEWORK_FILE}/${FRAMEWORK_NAME}" "${SIMULATOR_OUTPUTFOLDER}/${FRAMEWORK_FILE}/${FRAMEWORK_NAME}" "${IPHONE_OUTPUTFOLDER}/${FRAMEWORK_FILE}/${FRAMEWORK_NAME}"

# Open product in Finder
open "${UNIVERSAL_OUTPUTFOLDER}"