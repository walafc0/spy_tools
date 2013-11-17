#!/bin/bash

STUDENTS=$(w | tail -n +3 | sed -r "s/([^ ]+) .*/\1\n/g")
$LC_STALKER $STUDENTS


