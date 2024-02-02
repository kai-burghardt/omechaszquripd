# Omechaszquripd ###############################################################

1. [Short description](#short-description)
2. [Usage](#usage)
3. [Design](#design)
	1. [Technical](#technical)
	2. [Visual](#visual)
	3. [Metrics](#metrics)
4. [Miscellaneous](#miscellaneous)
	1. [Name](#name)
	2. [Sets](#sets)


## Short description ###########################################

Omechaszquripd is a single set fixed‐width monochrome raster font.
It is very small.
It is intended for memory‐constrained devices with small screen sizes.
Screens are monchrome; there is no correct support for colored code points.


## Design ######################################################

### Technical ##################################

As the source, the PBM, portable bitmap, format was chosen.
This is a text‐based format to describe bitmap graphics.
Anyone who can operate a text editor like Nano, VI, or EMACS, can contribute.
No further knowledge in specialized font editing tools like FontForge necessary.
Nevertheless, you may have a better editing experience with graphical tools.
For example, the GIMP can read and write PBM files.
The GNU Image Manipulation Program may however be too complicated to the novice.


### Visual #####################################

Many glyphs were adopted from pre‐existing designs.
For example many glyphs appear on Texas Instruments graphics calculators.
Characters may float, jump, be squeezed as suitable.
Separated elements may touch each other.


### Metrics ####################################

A glyph has a width of 5 pixels and a height of 7 pixels.
The full area of 35 square pixels is utilized.
Types add another pixel in width.
The present types add this pixel to the left.
This additional space is frequently used by semi‐graphics characters, too.


## Miscellaneous ###############################################

### Name #######################################

The name Omechaszquripd is meaningless.
The name was artificially restricted to 14 characters.
This is the minimum maximum file name length on any POSIX‐compliant platform.
POSIX is an industry standard for software, in particular operating systems.

Furthermore there are no repeating characters.
This is like [Hamburgefonstiv](https://en.WikiPedia.org/wiki/Hamburgevons).
It is a meaningless word for quickly assessing a font’s look.
The emphasis is on including characters of various classes.
That means there are characters which usually have descenders and ascenders.


### Sets #######################################

Omechaszquripd is a single set font.
That means there is only one size.
There is no intention to create and especially maintain any additional set.
You can use the `scale.sh` script to enlarge glyphs by an integral factor.


[//]: # ( vim: set filetype=markdown textwidth=80 tabstop=2 noexpandtab: )
