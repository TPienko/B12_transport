#!/bin/env tclsh
set residlist {}
set a1atoms {}
set a2atoms {}
set a3atoms {}
set start {}
set end {}

lappend start 177 229 276 323 395 442 487 525 569
lappend end 196 241 289 333 412 458 499 542 584
foreach first $start last $end {
   for {set x $first} {$x<=$last} {incr x} {
      lappend residlist $x
   }
}
set atomID {1}
lappend forbiddenres WAT LPS POP PSP OSP QMP PMP PGM Na+ Cl- CA 
lappend prolines 235 238 279 324 396 408 412 494 535  
set pdbSource "btub_fb_cbl_cut4.pdb"
set inStream [open $pdbSource r]        
set r [split [read $inStream] \n]
for {set x 0} {$x<=[llength $r]} {incr x} {
   set line [lindex $r $x]
   set residname [lindex $line 3]
   set atomname [lindex $line 2]
   set residnum [lindex $line 5]
   if {$residnum in $residlist && $residname ni $forbiddenres && $residnum ni $prolines} {
      if {$atomname=="N"} {
         set N($residnum) $atomID
      }
      if {$atomname=="H"} {
         set H($residnum) $atomID
      }
      if {$atomname=="CA"} {
         set CA($residnum) $atomID
      }
      if {$atomname=="CB"} {
         set CB($residnum) $atomID
      }
      if {$atomname=="CG"} {
         set CG($residnum) $atomID
      }
      if {$atomname=="CG1"} {
         set CG1($residnum) $atomID
      }
      if {$atomname=="SG"} {
         set SG($residnum) $atomID
      }
      if {$atomname=="OG"} {
         set OG($residnum) $atomID
      }
      if {$atomname=="OG1"} {
         set OG1($residnum) $atomID
      }
      if {$atomname=="SG1"} {
         set SG1($residnum) $atomID
      }
      if {$atomname=="CD"} {
         set CD($residnum) $atomID
      }
      if {$atomname=="CE"} {
         set CE($residnum) $atomID
      }
      if {$atomname=="NZ"} {
         set NZ($residnum) $atomID
      }
      if {$atomname=="CZ"} {
         set CZ($residnum) $atomID
      }
      if {$atomname=="NE"} {
         set NE($residnum) $atomID
      }
      if {$atomname=="SD"} {
         set SD($residnum) $atomID
      }
      if {$atomname=="CD1"} {
         set CD1($residnum) $atomID
      }
      if {$atomname=="C"} {
         set C($residnum) $atomID 
      }
      if {$atomname=="O"} {
         set O($residnum) $atomID 
      }
      incr atomID
   } else {
      incr atomID
   }
}

foreach res $residlist {
   if {[info exists CA($res)] && [info exists C($res)] && [info exists O($res)]} {
      lappend atoms1 $CA($res)
      lappend atoms2 $C($res) 
      lappend atoms3 $O($res)
   }
   if {[info exists CA($res)] && [info exists CB($res)] && [info exists CG($res)]} {
      lappend atoms1 $CA($res)
      lappend atoms2 $CB($res)
      lappend atoms3 $CG($res)
   }
   if {[info exists CA($res)] && [info exists CB($res)] && [info exists OG1($res)]} {
      lappend atoms1 $CA($res)
      lappend atoms2 $CB($res)
      lappend atoms3 $OG1($res)
   }
   if {[info exists CA($res)] && [info exists CB($res)] && [info exists SG1($res)]} {
      lappend atoms1 $CA($res)
      lappend atoms2 $CB($res)
      lappend atoms3 $SG1($res)
   }
   if {[info exists CA($res)] && [info exists CB($res)] && [info exists SG($res)]} {
      lappend atoms1 $CA($res)
      lappend atoms2 $CB($res)
      lappend atoms3 $SG($res)
   }
   if {[info exists CA($res)] && [info exists CB($res)] && [info exists OG($res)]} {
      lappend atoms1 $CA($res)
      lappend atoms2 $CB($res)
      lappend atoms3 $OG($res)
   }
   if {[info exists CA($res)] && [info exists CB($res)] && [info exists CG1($res)]} {
      lappend atoms1 $CA($res)
      lappend atoms2 $CB($res)
      lappend atoms3 $CG1($res)
   }
}
