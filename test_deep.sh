#!/bin/bash

ps aux | awk '{print $1"  "$11}' | sort -t' ' -k1,1 | sed -r -n '/^[0-9]{7}.*$/p' | sed -r '/^'$USER'/d' | grep -v ps | grep -v awk | grep -v sort | grep -v sed | grep -v grep >> $LC_FILE
