#!/usr/bin/env python3

import json
import re
import sys
import time
from dataclasses import asdict, dataclass
from pathlib import Path

LOG_FILE = Path.home() / ".local/share/eww_link_log.jsonl"

BLOCKED_PATTERNS = [
    r"\.pdf(\?.*)?$",
    r"\.zip(\?.*)?$",
    r"\.exe(\?.*)?$",
    r"\.mp4(\?.*)?$",
    r"application/(pdf|zip|octet-stream)",
]


@dataclass
class LinkDecision:
    decision: str
    reason: str
    url: str
    timestamp: str

    def to_json(self):
        return json.dumps(asdict(self))

    def log(self):
        LOG_FILE.parent.mkdir(parents=True, exist_ok=True)
        with open(LOG_FILE, "a") as f:
            f.write(self.to_json() + "\n")


def classify_link(url: str) -> LinkDecision:
    now = time.strftime("%Y-%m-%dT%H:%M:%S")

    if re.search(r"\.pdf(\?.*)?$", url, re.IGNORECASE):
        return LinkDecision("OPEN_EXTERNALLY", "PDF file", url, now)
    elif "youtube.com" in url or "youtu.be" in url:
        return LinkDecision("OPEN_EXTERNALLY", "YouTube link", url, now)
    elif re.search(r"\.(mp4|zip|exe)$", url, re.IGNORECASE):
        return LinkDecision("BLOCK", "Binary file", url, now)
    return LinkDecision("OPEN_IN_EWW", "Default", url, now)


def main():
    if len(sys.argv) != 2:
        print(json.dumps({"decision": "OPEN_IN_EWW", "reason": "No input"}))
        return

    url = sys.argv[1]
    result = classify_link(url)
    result.log()
    print(result.to_json())


if __name__ == "__main__":
    main()
