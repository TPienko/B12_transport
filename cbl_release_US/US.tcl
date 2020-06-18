# This script restrained the position of extended luminal domain during umbrella sampling
source prepare_btub.tcl
source prepare_pull.tcl 
source prepare_cbl.tcl
set timeStep {0} ; set forceFreq2 {500}
set kr {100.0} ; set kp {1.0} ; set ke {50.0} ; set v {0.000002}
set btubGroup [addgroup $btubatoms] ; set pullGroup [addgroup $pullatoms] ; set cblGroup [addgroup $cblatoms]
############################################################################################################
proc restrain_btub {rcx rcy rcz kr rrx rry rrz} {
    global btubGroup
    addforce $btubGroup "[expr {$kr*($rcx-$rrx)}] [expr {$kr*($rcy-$rry)}] [expr {$kr*($rcz-$rrz)}]"
}
proc restrain_end {pcy ke acy} {
    global pullGroup
    addforce $pullGroup "0.0 [expr {$ke*($pcy-$acy)}] 0.0"
}
##################################### CALCULATE FORCES #############################################
proc calcforces {} {
   if {[array exists coords]} {array unset coords}
   global cblGroup pullGroup btubGroup timeStep v kr kp ke forceFreq2
   loadcoords coords
   if {$timeStep==0} {
      set rcx [lindex $coords($btubGroup) 0]
      set rcy [lindex $coords($btubGroup) 1]
      set rcz [lindex $coords($btubGroup) 2]
      set pcy [lindex $coords($pullGroup) 1]
      set cby [lindex $coords($cblGroup) 1]
   }
   restrain_btub $rcx $rcy $rcz $kr [lindex $coords($btubGroup) 0] [lindex $coords($btubGroup) 1] [lindex $coords($btubGroup) 2]
   restrain_end $pcy $ke [lindex $coords($pullGroup) 1]
   incr timeStep
   return
}
