#!/bin/sh
echo "Running tests on browserstack automate: https://automate.browserstack.com/dashboard/v2/builds/"

BUILD_ID=$(browserstack-cypress run -r spec | grep 'build id:' | rev | cut -d" " -f1 | rev)

RESULTS=https://automate.browserstack.com/dashboard/v2/builds/$BUILD_ID

POLLING_INTERVAL=3
BUILD_STATUS="running"

while [ $BUILD_STATUS == "running" ]
do
  $(browserstack-cypress build-info $BUILD_ID > temp.txt)
  BUILD_STATUS=$(awk '/"status":/ {print $2} ' temp.txt | head -n1 | cut -d"," -f1 | cut -d"\"" -f2)
    
  FAILED_TESTS=$(grep "failed" -m 1 temp.txt | cut -f2- -d:)
  if [ $FAILED_TESTS != "0," ]; then 
    $(browserstack-cypress build-stop $BUILD_ID)    
    echo "TEST BUILD FAILED!. See results at $RESULTS"
    exit 1
  fi
  
  $(sleep $POLLING_INTERVAL)
done

  PASSED_TESTS=$(grep '"success": ' -m 2 temp.txt | cut -f2- -d:)
  if grep -q "$PASSED_TESTS" <<< "{ 0,"; then 
    echo "TEST BUILD FAILED!. See results at $RESULTS"
    exit 1
  fi

  $(rm temp.txt)

echo "Test run on browserstack automate has finished with no failing tests: $RESULTS"
