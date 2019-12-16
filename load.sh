#!/bin/bash
#(set -o igncr) 2>/dev/null
set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

psql -Uopenchpl_dev -f v-next.sql openchpl
