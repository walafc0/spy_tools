#!/usr/bin/env python

import pwd;
import sys;
import string;

current = "";
for student in sys.argv[1:]:
    if not student[0].isdigit(): 
        current = ''.join([current, "?        ", str(student), "\n"])
    else:
        name = pwd.getpwuid(int(student)).pw_gecos;
        current = ''.join([current, str(student), "  ", name, "\n"]);

current = current[:-1];

print current;

