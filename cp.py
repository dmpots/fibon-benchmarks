#!/usr/bin/env python
# Script to copy the tree in data/ref to data/train

import os
import os.path
import sys
import shutil

def main():
  (opts, argv) = parse_opts(sys.argv[1:])
  for root in argv:
    for (path, dirs, files) in os.walk(root):
      if path.endswith("/ref"):
        src = path
        dst = os.path.dirname(path) + "/" + "train"
        msg = "copy {0} --> {1}".format(src,dst)
        if os.path.exists(dst):
          print("[skip]   {0} already exists".format(dst))
        elif opts.dryrun:
          print("[dryrun] {0}".format(msg))
        else:
          print(msg)
          shutil.copytree(src, dst)

class Options:
  def __init__(self):
    self.dryrun = False
  def __repr__(self):
    return "Options(dryrun=" + str(self.dryrun)+")"

def parse_opts(argv):
  opts = Options()
  if "--dryrun" in argv:
    opts.dryrun = True
    argv = filter(lambda arg: arg != "--dryrun", argv)
  return (opts, list(argv))

if __name__ == "__main__":
  main()
