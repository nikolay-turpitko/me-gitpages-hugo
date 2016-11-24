import nre, strutils, future
from re import reEmail

try:
  while true:
    echo(readLine(stdin).replace(
      re(reEmail),
      (s: string) => s.replace(".", "_{dot}_").replace("@", "_{at}_")))
except: discard
