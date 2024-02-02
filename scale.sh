#!/bin/sh
#        name: scale
# description: You can use this script as follows:
#                mkdir -p regular-14/16
#                cd       regular-14/16
#                ../../scale.sh 2 ../../regular-07/08/*/*

# Assign a more human‐friendly identifier for the first argument.
factor="${1:?Error: ${0} requires at least one argument, the scale factor.}"

# This the function performing the actual scaling.
scale() {
	# `pnmenlarge` does the scaling according to `${factor}`.
	# `pnmtoplainpnm` converts the binary output do ASCII.
	# The stream editor (`sed`) script does the following:
	#   ⁃ Starting with the third line (`3`)
	#   ⁃ until (`,`)
	#   ⁃ the end of input (`$`)
	#   ⁃ substitute (`s/`)
	#   ⁃ all occurrences of characters (`.`)
	#   ⁃ with (`/`)
	#   ⁃ the matched string preceded by a space (` \0`)
	#   ⁃ globally (`g`), i. e. not just the first match,
	#   ⁃ and then (`;`) remove the first space (`s/ //`).
	
	pnmenlarge ${factor} | \
	pnmtoplainpnm | \
	sed -e '3,$ { s/./ \0/g ; s/ // }'
}

# Drop the first argument from the argument array; it is `${factor}` now.
shift 1

# Use standard input and standard output if there are no further arguments.
[ ${#} -eq 0 ] && { scale ; exit ; }

# Otherwise iterate over all arguments.
for glyph
do
	code_point=$(basename `dirname ${glyph}`)
	[ -d ${code_point} ] || mkdir ${code_point}
	scale < $glyph > ${code_point}/${glyph##*/}
done
