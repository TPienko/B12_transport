source prepare_decouple.tcl
source prepare_btub.tcl 
source prepare_pull.tcl 
source prepare_cbl.tcl
set firstStep {0} ; set timeStep {0} ; set forceFreq2 {500} ; set addforceFreq {2}
set kc {10.0} ; set kr {100.0} ; set kp {1.0} ; set ke {100.0}
set btubGroup [addgroup $btubatoms] ; set pullGroup [addgroup $pullatoms] ; set cblGroup [addgroup $cblatoms]
foreach at1 $atoms1 at2 $atoms2 at3 $atoms3 {
   addatom $at1 ; addatom $at2 ; addatom $at3
}
load ./vectors.so
############################################################################################################
proc forcecalc {c1 c2 c3 a3 accel} {
   set coor1 [new_Vector [lindex $c1 0] [lindex $c1 1] [lindex $c1 2] ]
   set coor2 [new_Vector [lindex $c2 0] [lindex $c2 1] [lindex $c2 2] ]
   set coor3 [new_Vector [lindex $c3 0] [lindex $c3 1] [lindex $c3 2] ]
   set vec [calc_force $coor1 $coor2 $coor3 $accel]
   addforce $a3 "[get_vector $vec 0] [get_vector $vec 1] [get_vector $vec 2]"
   delete_vector $coor1 ; delete_vector $coor2 ; delete_vector $coor3; delete_vector $vec
}
proc restrain_cbl {cbx cby cbz kc crx cry crz} {
   global cblGroup
   addforce $cblGroup "[expr {$kc*($cbx-$crx)}] [expr {$kc*($cby-$cry)}] [expr {$kc*($cbz-$crz)}]"
}
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
   global simFlag simSteps numA dev atoms1 atoms2 atoms3 cblGroup pullGroup btubGroup timeStep kc kr kp ke addforceFreq forceFreq2
   loadcoords coords
   restrain_btub $rcx $rcy $rcz $kr [lindex $coords($btubGroup) 0] [lindex $coords($btubGroup) 1] [lindex $coords($btubGroup) 2]
   restrain_end $pcy $ke [lindex $coords($pullGroup) 1]
   if {$timeStep==0} {
      set cbx [lindex $coords($cblGroup) 0]
      set cby [lindex $coords($cblGroup) 1]
      set cbz [lindex $coords($cblGroup) 2]
      set rcx [lindex $coords($btubGroup) 0] 
      set rcy [lindex $coords($btubGroup) 1]
      set rcz [lindex $coords($btubGroup) 2]
      set pcy [lindex $coords($pullGroup) 1]
   }
   if {$simFlag=="on"} {
      restrain_cbl $cbx $cby $cbz $kc [lindex $coords($cblGroup) 0] [lindex $coords($cblGroup) 1] [lindex $coords($cblGroup) 2]
      if {[expr {($timeStep-1)%$addforceFreq}]==0} {
         foreach a1 $atoms1 a2 $atoms2 a3 $atoms3 {
            forcecalc $coords($a1) $coords($a2) $coords($a3) $a3 [random_num $dev]
         }
      }
      incr timeStep
      return
   }
   if {$simFlag=="relax"} {
      incr timeStep
      return
   }
   if {$simFlag=="off"} {
      incr timeStep
      return
   }
}
