# This script enabled controlled permeation of Cbl through BtuB using constant-velocity SMD at the restrained position of extended luminal domain
source prepare_btub.tcl
source prepare_pull.tcl 
source prepare_cbl.tcl
set timeStep {0} ; set forceFreq2 {500}
set kr {100.0} ; set kp {1.0} ; set ke {50.0} ; set v {0.000002}
set btubGroup [addgroup $btubatoms] ; set pullGroup [addgroup $pullatoms] ; set cblGroup [addgroup $cblatoms]
set output "Force_CBL.dat"
############################################################################################################
proc restrain_btub {rcx rcy rcz kr rrx rry rrz} {
    global btubGroup
    addforce $btubGroup "[expr {$kr*($rcx-$rrx)}] [expr {$kr*($rcy-$rry)}] [expr {$kr*($rcz-$rrz)}]"
}
proc restrain_end {pcy ke acy} {
    global pullGroup
    addforce $pullGroup "0.0 [expr {$ke*($pcy-$acy)}] 0.0"
}
proc pull {cby kp v timeStep cry} {
    global forceFreq2 output cblGroup
    addforce $cblGroup "0.0 [expr {$kp*($cby-$cry-$v*$timeStep)}] 0.0"
    if {[expr {$timeStep%$forceFreq2}]==0} {
       set outforce [open $output a]
       puts $outforce "$timeStep [expr {$cby-$cry}] [expr {69.48*$kp*($cby-$cry-$v*$timeStep)}]"
       close $outforce
    }
}
##################################### CALCULATE FORCES #############################################
proc calcforces {} {
   if {[array exists coords]} {array unset coords}
   global output cblGroup pullGroup btubGroup timeStep v kr kp ke forceFreq2 rcx rcy rcz pcy cby
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
   pull $cby $kp $v $timeStep [lindex $coords($cblGroup) 1]
   incr timeStep
   return
}

