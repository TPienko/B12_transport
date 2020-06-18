# This script enabled simultaneous unfolding of the luminal domain and release of Cbl from BtuB using constant-velocity and constant-force SMD
source prepare_btub.tcl
source prepare_pull.tcl
source prepare_cbl.tcl
############# SETTING VARIABLES ############################## 
set firstStep {0} ; set timeStep $firstStep ; set forceFreq {1} ; set forceFreq2 {500}; set kr {100.0} ; set kp {1.0} ; set v {0.000002} ; set cblforce {-8.0}
set btubGroup [addgroup $btubatoms]
set pullGroup [addgroup $pullatoms]
set cblGroup [addgroup $cblatoms]
set output "Force_8.dat"
##############################################################
################## RESTRAIN ##################################
##############################################################
proc restrain {rcx rcy rcz kr rrx rry rrz} {
   global btubGroup
   addforce $btubGroup "[expr {$kr*($rcx-$rrx)}] [expr {$kr*($rcy-$rry)}] [expr {$kr*($rcz-$rrz)}]" 
}
##############################################################
#################### PULL ####################################
##############################################################
proc pull {pcy kp v timeStep pry cblforce cblcy cblry} {
   global pullGroup forceFreq2 cblGroup output
   if {[expr {$cblcy-$cblry}] > 300.0} {
      set process [pid]
      exec kill -9 $process
   }
   addforce $pullGroup "0.0 [expr {$kp*($pcy-$pry-$v*$timeStep)}] 0.0"
   addforce $cblGroup "0.0 $cblforce 0.0"
   if {[expr {$timeStep%$forceFreq2}]==0} {
      set outforce [open "${output}" a]
      puts $outforce "$timeStep [expr {$pcy-$pry}] [expr {69.48*$kp*($pcy-$pry-$v*$timeStep)}] [expr {$cblcy-$cblry}]"
      close $outforce
   }
}
########## CALCULATE FORCES ################################
proc calcforces {} {
   if {[array exists coords]} {array unset coords}
   global timeStep forceFreq forceFreq2 btubGroup pullGroup cblGroup kp kr v cblforce
   loadcoords coords
   if {$timeStep==0} {
      set rcx [lindex $coords($btubGroup) 0] 
      set rcy [lindex $coords($btubGroup) 1]
      set rcz [lindex $coords($btubGroup) 2]
      set pcy [lindex $coords($pullGroup) 1]
      set cblcy [lindex $coords($cblGroup) 1]
   }
   restrain $rcx $rcy $rcz $kr [lindex $coords($btubGroup) 0] [lindex $coords($btubGroup) 1] [lindex $coords($btubGroup) 2]
   pull $pcy $kp $v $timeStep [lindex $coords($pullGroup) 1] $cblforce $cblcy [lindex $coords($cblGroup) 1]
   incr timeStep
   return
}
