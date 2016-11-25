# This program gets text from stdin and passes it to stdout, replacing all
# "mailto:" links in markdown notation to plain (not obfuscated) representation.

import nre, strutils, sequtils

proc rot13(c: char): char =
  case toLower(c)
  of 'a'..'m': chr(ord(c) + 13)
  of 'n'..'z': chr(ord(c) - 13)
  else:        c

proc decryptLink(m: RegexMatch): string =
  let email = m.captures[1]
    .replace("[dot]", ".")
    .replace("[at]", "@")
    .mapIt($(rot13(it)))
    .join
  "[$1](mailto:$1)" % [email, m.captures[2]]

try:
  while true:
    echo(readLine(stdin).replace(re"(\[.*?\]\(mailto:)(.*?)(\))", decryptLink))
except: discard
