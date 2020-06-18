set windows {145}
set sets {200}
set ref [open "pmf200_extracted_all.dat" r]
set refa [read $ref]
set refb [split $refa "\n"]
set refc [llength $refb]
for {set l 0} {$l<=$refc} {incr l} {
   set line [lindex $refb $l]
   if {[string first "#" $line]=={-1}} {
      set coord [lindex $line 0]
      set energy [lindex $line 1]
      lappend ref_pmf $energy
   }
}
unset energy ; unset coord ; unset line ; unset l

for {set x 1} {$x<=${sets}} {incr x} {
   set calc [open "pmf${x}_extracted_all.dat" r]
   set calca [read $calc]
   set calcb [split $calca "\n"]
   set calcc [llength $calcb]

   for {set l 0} {$l<=$calcc} {incr l} {
      set line [lindex $calcb $l]
      if {[string first "#" $line]=={-1}} {
         set coord [lindex $line 0]
         set energy [lindex $line 1]
         lappend calc_pmf($x) $energy
      }
   }
}

set out [open "rmsd_pmf_all.dat" w]

for {set k 1} {$k<=${sets}} {incr k} {
   set rmsd_sum {0}
   for {set v 0} {$v<=[expr $windows-1]} {incr v} {
      set r [lindex $ref_pmf $v]
      set c [lindex $calc_pmf($k) $v]
      set rmsd_sum [expr $rmsd_sum + ($c-$r)*($c-$r)]
   }
   set rmsd [expr sqrt($rmsd_sum/$windows)]
   puts $out "$k $rmsd"
}
close $out
