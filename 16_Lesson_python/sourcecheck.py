#!/usr/bin/env python3

import os
import re
import sys

if len(sys.argv)>=2:
    pathToRepo=sys.argv[1]
else:
    pathToRepo=os.getcwd()
regex = r"(?:modified:\s*.*)"
bash_command = ["cd "+pathToRepo, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
if result_os.find('modified') != -1:
    matches = re.finditer(regex, result_os, re.MULTILINE)
    for match in enumerate(matches):
        rez = str(list(match)[1])
        print(pathToRepo+rez[rez.find(":")+4:-2])
