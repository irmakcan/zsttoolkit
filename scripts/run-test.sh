#!/bin/sh

xcodebuild clean test\
  -sdk iphonesimulator \
  -workspace ZSTToolkit.xcworkspace \
  -scheme ZSTToolkit\
  -configuration Debug \
  OBJROOT=build \
  ONLY_ACTIVE_ARCH=NO \
  GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
  GCC_GENERATE_TEST_COVERAGE_FILES=YES
