#!/usr/bin/env python3

import random
import json
import os
import html

with open(os.environ['HOME'] + '/.dotfiles/showerthoughts/showerthoughts') as showerthoughts:
    randnum = random.randint(0, 99)
    showerthought = json.load(showerthoughts)["data"]["children"][randnum]["data"]
    print("\"" + html.unescape(showerthought["title"]) + "\" \u2014 " + html.unescape(showerthought["author"]))
