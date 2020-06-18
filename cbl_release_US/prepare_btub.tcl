#!/bin/env tclsh
set one {138}
set fin {594}
for {set y $one} {$y<=$fin} {incr y} {
   lappend btub $y
}
set btubatoms {}
set pullatoms {}
set ythreshold {-27}
set atomID {1}
lappend forbiddenres WAT LPS POP PSP OSP QMP PMP PGM Na+ Cl- CA 
set pdbSource "btub_fb_cbl_cut4.pdb"
set inStream [open $pdbSource r]        
set r [split [read $inStream] \n]
for {set x 0} {$x<=[llength $r]} {incr x} {
   set line [lindex $r $x]
   set residname [lindex $line 3]
   set atomname [lindex $line 2]
   set residnum [lindex $line 5]
   set coory [lindex $line 7] 
   if {$residnum in $btub && $atomname=="CA" && $residname ni $forbiddenres && $coory<$ythreshold} {
      lappend btubatoms $atomID
      incr atomID
   } else {
      incr atomID
   }
}
puts $btubatoms 
