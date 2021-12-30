#!/usr/bin/env python3

import os
import re

regex = r"(?:modified:\s*.*)"
bash_command = ["cd ~/PycharmProjects/DevOps_Netology/", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
if result_os.find('modified') != -1:
    matches = re.finditer(regex, result_os, re.MULTILINE)
    for match in enumerate(matches):
        rez = str(list(match)[1])
        print(rez[rez.find(":")+4:-2])
