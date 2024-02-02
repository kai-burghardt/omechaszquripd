#!/bin/sh
#        name: nibble (a group of four bits, four binary digits)
# description: Converts argument files into (code point, data) tuple. Example:
#              
#                 000041:003844447C444444
#              
#              This format was developed and popularized by the GNU Unifont.
#              Further processing can be done with GNU Unifont utilities.

# Prevent usage mistake: There must be at least one argument.
# The colon (`:`) is a shell built‐in null command (i. e. it does nothing).
: "${1:?Error: ${0} requires at least one argument, pathnames to pbm files.}"

# This function processes the contents of a file in `regular-07/08/*/*.pbm`.
nibble () {
	# `grep` – global, regular expression, print – utility removes comments.
	grep -v '#' | {
		read -r magic
		[ "${magic:?Error: Magic is empty.}" = 'P1' ] || exit 132
		
		read -r width height
		# The printed preamble says `Width: 6` and `Height: 8`.
		[ ${width:?Error: Width is empty.}   -eq 6 ] || exit 153
		[ ${height:?Error: Height is empty.} -eq 8 ] || exit 136
		
		# If the number of pixels in a line is not divisible by four,
		# remaining nibble positions are filled with don’t‐care‐bits.
		while read -r a b c d e f
		do
			printf '%X%X' $(( ${a} * 8 + ${b} * 4 + ${c} * 2 + ${d} )) \
			              $(( ${e} * 8 + ${f} * 4 ))
		done
	}
}

# The `Width:` and `Height:` comments are recognized by FreeBSD’s `vtfontcvt`.
[ "${NO_PREAMBLE}" ] || cat <<- 'EOT'
	# Omechaszquripd – a small public‐domain bitmap font for small screens.
	# 
	# Width:  6
	# Height: 8
	EOT

# Main loop over the shell script’s arguments.
for glyph
do
	code_point=$(basename `dirname ${glyph}`)
	[ -z "${code_point%%[0-9][0-9][0-9][0-9][0-9][0-9][0-9]}" ] || exit 170
	[ ${code_point} -le 1114111 ] || exit 255
	
	# We cannot use the `${code_point}` variable’s value directly.
	# `printf` interprets numbers with leading zeros as octal numbers.
	# We have established a fixed‐width `$code_point` string above,
	# so we can prepend a `1` digit and subtract the surplus value.
	encode=$(printf '%06X' $(( 1${code_point} - 10000000 )))
	
	# Store as a shell variable, so we can output an error mesage with `:?`.
	bitmap=$(nibble < ${glyph})
	
	printf '%s:%s\n' \
		"${encode:?Error: Cannot calculate code point ${code_point}.}" \
		"${bitmap:?Error: Cannot determine bitmap data for ${glyph}.}"
done
