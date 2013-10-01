#!/bin/bash


source ./bock thisCall
echo -n "Testing if the last call is being kept track of..."
thisCall
if verify thisCall 2>/dev/null
then
    echo PASSED
else
    echo FAILED
fi

echo -n "Testing if resetMocks clears out all mocks..."
resetMocks thisCall
verify thisCall 2>/dev/null && echo FAILED || echo PASSED

echo -n "Testing if these mocks are carried into a sub-program..."
source ./bock mv
. test/testScript
verify mv fakeFile1 fakeFile2 && echo PASSED || echo FAILED

echo -n "Testing handling of repeated resets..."
source ./bock thisCall
resetMocks thisCall
resetMocks thisCall && echo PASSED || echo FAILED

echo -n "Testing verification of missing arguments..."
source ./bock thisCall
thisCall
verify thisCall one two three 2> /dev/null && echo FAILED || echo PASSED

echo -n "Testing verification of extra arguments..."
source ./bock thisCall
thisCall one two three
verify thisCall one two 2> /dev/null && echo FAILED || echo PASSED

echo -n "Testing verification of matching arguments..."
source ./bock thisCall
thisCall one two three
verify thisCall one two three && echo PASSED || echo FAILED
