#!/bin/env tclsh
#CBL
# C8-C41-C42
# C41-C42-C43
# C7-C37-C38
# C3-C30-C31
# C30-C31-C32
# C2-C26-C27
# C18-C60-C61
# C13-C48-C49
# C48-C49-C50
lappend cbllist C8 C41 C42 C43 C7 C37 C38 C3 C30 C31 C32 C2 C26 C27 C18 C60 C61 C13 C48 C49 C50
set residlist {}
set a1atoms {}
set a2atoms {}
set a3atoms {}
set start {}
set end {}
#PRO 235
#PRO 238
#PRO 279
#PRO 324
#PRO 396
#PRO 408
#PRO 412
#PRO 494
#PRO 535
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
set pdbSource "btub_fb_cbl_cut4_frame197.pdb"
set inStream [open $pdbSource r]        
set r [split [read $inStream] \n]
for {set x 0} {$x<=[llength $r]} {incr x} {
        set line [lindex $r $x]
        set residname [lindex $line 3]
        set atomname [lindex $line 2]
        set residnum [lindex $line 5]
	if {$residnum in $residlist && $residname ni $forbiddenres && $residnum ni $prolines || $residname=="CBL"} {
		#if {$residname=="CBL" && $atomname in $cbllist} {
		#	set ${atomname}($residnum) $atomID
		#}
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
        #if {[info exists C8($res)] && [info exists C41($res)] && [info exists C42($res)]} {
        #        lappend atoms1 $C8($res)
        #        lappend atoms2 $C41($res)
          #      lappend atoms3 $C42($res)
        #}
        #if {[info exists C41($res)] && [info exists C42($res)] && [info exists C43($res)]} {
         #       lappend atoms1 $C41($res)
         #       lappend atoms2 $C42($res)
         #       lappend atoms3 $C43($res)
        #}
        #if {[info exists C7($res)] && [info exists C37($res)] && [info exists C38($res)]} {
        #        lappend atoms1 $C7($res)
        #        lappend atoms2 $C37($res)
        #        lappend atoms3 $C38($res)
        #}
        #if {[info exists C3($res)] && [info exists C30($res)] && [info exists C31($res)]} {
        #        lappend atoms1 $C3($res)
        #        lappend atoms2 $C30($res)
        #        lappend atoms3 $C31($res)
        #}
        #if {[info exists C30($res)] && [info exists C31($res)] && [info exists C32($res)]} {
         #       lappend atoms1 $C30($res)
         #       lappend atoms2 $C31($res)
         #       lappend atoms3 $C32($res)
        #}
        #if {[info exists C2($res)] && [info exists C26($res)] && [info exists C27($res)]} {
        #        lappend atoms1 $C2($res)
        #        lappend atoms2 $C26($res)
        #        lappend atoms3 $C27($res)
        #}
        #if {[info exists C18($res)] && [info exists C60($res)] && [info exists C61($res)]} {
         #       lappend atoms1 $C18($res)
         #       lappend atoms2 $C60($res)
         #       lappend atoms3 $C61($res)
        #}
        #if {[info exists C13($res)] && [info exists C48($res)] && [info exists C49($res)]} {
         #       lappend atoms1 $C13($res)
         #       lappend atoms2 $C48($res)
         #       lappend atoms3 $C49($res)
        #}
        #if {[info exists C48($res)] && [info exists C49($res)] && [info exists C50($res)]} {
         #       lappend atoms1 $C48($res)
         #       lappend atoms2 $C49($res)
          #      lappend atoms3 $C50($res)
        #}
	#if {[info exists N($res)] && [info exists CA($res)] && [info exists CB($res)] && $res ni $prolinestart} {
        #        lappend atoms1 $N($res)
        #        lappend atoms2 $CA($res) 
        #        lappend atoms3 $CB($res) 
        #}
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
 	#if {[info exists CB($res)] && [info exists CG($res)] && [info exists CD1($res)]} {
                #lappend a1atoms $CB($res)
                #lappend a2atoms $CG($res)
                #lappend a3atoms $CD1($res)
       # }
	#if {[info exists CB($res)] && [info exists CG1($res)] && [info exists CD1($res)]} {
         #       lappend a1atoms $CB($res)
          #      lappend a2atoms $CG1($res)
           #     lappend a3atoms $CD1($res)
       # }
	#if {[info exists CB($res)] && [info exists CG($res)] && [info exists CD($res)]} {
         #       lappend a1atoms $CB($res)
          #      lappend a2atoms $CG($res)
           #     lappend a3atoms $CD($res)
       # }
	#if {[info exists CG($res)] && [info exists CD($res)] && [info exists NE($res)]} {
        #        lappend a1atoms $CG($res)
         #       lappend a2atoms $CD($res)
          #      lappend a3atoms $NE($res)
        #}
	#if {[info exists CD($res)] && [info exists NE($res)] && [info exists CZ($res)]} {
         #       lappend a1atoms $CD($res)
         #       lappend a2atoms $NE($res)
         #      lappend a3atoms $CZ($res)
        #}
	#if {[info exists CD($res)] && [info exists CE($res)] && [info exists NZ($res)]} {
          #      lappend a1atoms $CD($res)
         #       lappend a2atoms $CE($res)
          #      lappend a3atoms $NZ($res)
        #}	
	#if {[info exists CG($res)] && [info exists CD($res)] && [info exists CE($res)]} {
         #       lappend a1atoms $CG($res)
         #       lappend a2atoms $CD($res)
         #       lappend a3atoms $CE($res)
        #}
	#if {[info exists CG($res)] && [info exists SD($res)] && [info exists CE($res)]} {
         #       lappend a1atoms $CG($res)
         #       lappend a2atoms $SD($res)
         #       lappend a3atoms $CE($res)
        #}
	#if {[info exists CB($res)] && [info exists CG($res)] && [info exists SD($res)]} {
         #       lappend a1atoms $CB($res)
         #       lappend a2atoms $CG($res)
         #       lappend a3atoms $SD($res)
        #}
}


# #VALIDATION		
#puts "[llength a$back1atoms]"
#puts $atoms1
#puts $atoms2
#puts $atoms3
#puts $back5atoms
#puts $back6atoms
#puts "[llength $atoms1]"
#puts $side2atoms
#puts $side3atoms

#foreach a1 $back1atoms a2 $back2atoms a3 $back3atoms a4 $back4atoms a5 $back5atoms a6 $back6atoms {
#	puts "$a1 $a2 $a3 $a4 $a5 $a6"
#}

#foreach a1 $atoms1 a2 $atoms2 a3 $atoms3 {
#       puts "$a1 $a2 $a3"
#}

#puts [llength $atoms1]
#puts [llength $atoms2]
#puts [llength $atoms3]

foreach el $atoms1 el2 $atoms2 el3 $atoms3 {
	if {[lindex $el 1]==[lindex $el2 1] && [lindex $el2 1]==[lindex $el3 1] && "[lindex $el 2]"=="[lindex $el2 2]" && "[lindex $el2 2]"=="[lindex $el3 2]"} {
		lappend lista ok
	}
} 
 
#foreach el $side1atoms el2 $side2atoms el3 $side3atoms {
#        if {[lindex $el 1]==[lindex $el2 1] && [lindex $el2 1]==[lindex $el3 1] && "[lindex $el 2]"=="[lindex $el2 2]" && "[lindex $el2 2]"=="[lindex $el3 2]"} {
#                lappend lista ok
#        }
#}
puts $lista
puts [llength $lista]
#	puts $N($res)
#        puts $CA($res)
#	puts $CB($res)
#	puts $CG($res)
#	puts $C($res)	
#	puts $O($res)
#}
#set a [open "output" a]
#close $a
