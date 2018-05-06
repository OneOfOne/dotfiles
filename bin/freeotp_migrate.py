#!/usr/bin/env python3

# downloaded from https://www.stavros.io/tips/migrate-freeotp-to-andotp/

import base64
import json
import sys
import xml.etree.ElementTree


def read_tokens(filename):
    e = xml.etree.ElementTree.parse(filename).getroot()
    for item in e.findall("string"):
        if item.get("name") == "tokenOrder":
            continue
        token = json.loads(item.text)
        token["secret"] = base64.b32encode(
            bytes(x & 0xff for x in token["secret"])
        ).decode("utf8")

        issuer = token.get("issuerAlt") or \
            token.get("issuerExt") or \
            token.get("issuerInt")
        label = token.get("label") or token.get("labelAlt")

        if label and issuer:
            token_label = "%s - %s" % (issuer, label)
        else:
            token_label = label or issuer

        yield {
            "algorithm": token["algo"],
            "secret": token["secret"],
            "digits": token["digits"],
            "type": token["type"],
            "period": token["period"],
            "label": token_label,
        }


def main():
    if sys.version_info.major < 3:
        print("This script requires Python 3.")
        sys.exit(1)

    if len(sys.argv) != 2:
        print("Usage: ./freeotp_migrate.py <filename>")
        sys.exit(1)

    # Dump the tokens.
    output = json.dumps(
        list(read_tokens(sys.argv[1])),
        sort_keys=True,
        indent=2,
        separators=(',', ': ')
    )

    print(output)


if __name__ == "__main__":
    main()
