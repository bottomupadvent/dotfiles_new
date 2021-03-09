#!/usr/bin/tclsh8.6
# opens a PDF in mupdf(1)--unless that file has already been opened
# with this tool, in which case a HUP signal is instead sent to that
# mupdf process

if {[llength $argv] != 1} {
    puts stderr "Usage: mopen pdf-file"
    exit 64
}
set file [file normalize [lindex $argv 0]]

set fh [open "| ps xwwo pid,command" r]
while {[gets $fh line] >= 0} {
    if {[regexp "^\[ ]*(\\d+) mupdf $file" $line -> pid]} {
        exec kill -HUP $pid
        exit
    }
}

exec mupdf $file
