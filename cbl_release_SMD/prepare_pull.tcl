#!/bin/env tclsh

set pullatoms {}
set atomID {1}
lappend res GLN
set pdbSource "btub_fb_cbl_cut4.pdb"
set inStream [open $pdbSource r]
set r [split [read $inStream] \n]

for {set x 0} {$x<=[llength $r]} {incr x} {
   set line [lindex $r $x]
   set residname [lindex $line 3]
   set atomname [lindex $line 2]
   set residnum [lindex $line 5]
   set first [string index $atomname 0]

   if {$residnum==1 && $first!="H" && $residname in $res} {
      lappend pullatoms $atomID
      incr atomID
   } else {
      incr atomID
   }
}
puts $pullatoms
