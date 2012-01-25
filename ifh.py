#!/usr/bin/env python3
# Script to install the FibonHelper.hs file into the Fibon/Run directory of a benchmark
# The script does nothing unless the --force argument is given

import sys
import os
import glob
import shutil
import filecmp

def log(dry, msg):
    out = msg
    if dry:
        out = "would "+out
    print(out)

def install_file(dry, src, fibon_helper):
    log(dry, "copy {0} to {1}".format(src, fibon_helper))
    if not dry:
        shutil.copyfile(src, fibon_helper)

def main(args):
    dry = True # by default do nothing

    if args.count('--force'):
        dry = False
        args.remove('--force')

    src = '../../../tools/fibon-run/Fibon/Run/BenchmarkHelper.hs'
    if len(args) > 0:
        src = args[0]

    if not os.path.exists(src):
        print('ERROR: fibon helper '+src+' does not exist')
        sys.exit(1)

    fibon_dirs = filter(lambda d: not d.startswith('_'), glob.glob('*/*/Fibon'))
    fibon_run_dirs = map(lambda d: os.path.join(d, 'Run'), fibon_dirs)

    for d in fibon_run_dirs:
        if not os.path.exists(d):
            log(dry, "create dir "+d)
            if not dry:
                os.mkdir(d)

        fibon_helper = os.path.join(d, os.path.basename(src))
        if not os.path.exists(fibon_helper):
            install_file(dry, src, fibon_helper)
        elif not filecmp.cmp(src, fibon_helper):
            install_file(dry, src, fibon_helper)

if __name__ == "__main__":
    main(sys.argv[1:])
