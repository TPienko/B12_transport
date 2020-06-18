source prepare_decouple.tcl ; source prepare_btub2.tcl ; source prepare_pull2.tcl ; source prepare_cbl.tcl
set firstStep {0} ; set timeStep {0} ; set forceFreq2 {500} ; set addforceFreq {2}
set kc {10.0} ; set kr {100.0} ; set kp {1.0} ; set ke {100.0} ; set v {0.000002}
set rcx {-5.099559783935547} ; set rcy {-6.722764015197754} ; set rcz {8.205121040344238}
#set rcx {-5.109748363494873} ; set rcy {-6.550665378570557} ; set rcz {8.316502571105957}
#set rcx {-5.03742790222168} ; set rcy {-6.561867713928223} ; set rcz {8.426807403564453}
#set rcx {-5.111755847930908} ; set rcy {-6.566164016723633} ; set rcz {8.443937301635742}
set pcx {-0.4434114694595337} ; set pcy {-210.22451782226563} ; set pcz {14.940774917602539}
#set pcx {8.139363288879395} ; set pcy {-247.25694274902344} ; set pcz {-4.584955215454102}
#set pcx {-12.085713386535645} ; set pcy {-277.61505126953125} ; set pcz {5.279555797576904}
#set pcx {6.301041603088379} ; set pcy {-302.9212646484375} ; set pcz {3.214073896408081}
#set cby {31.8}
#set cby {32.76}
#set cby {32.47}
#set cby {32.55}
set btubGroup [addgroup $btubatoms] ; set pullGroup [addgroup $pullatoms] ; set cblGroup [addgroup $ligatoms]
foreach at1 $atoms1 at2 $atoms2 at3 $atoms3 {
   addatom $at1 ; addatom $at2 ; addatom $at3
}
#set output "btub_fb_cbl_pull_smd_197.dat"
load ./vectors3.so
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
   global cbx cby cbz firstStep simFlag simSteps numA dev atoms1 atoms2 atoms3 cblGroup pullGroup btubGroup timeStep kc rcx rcy rcz pcx pcy pcz v kr kp ke addforceFreq forceFreq2
   loadcoords coords
   restrain_btub $rcx $rcy $rcz $kr [lindex $coords($btubGroup) 0] [lindex $coords($btubGroup) 1] [lindex $coords($btubGroup) 2]
   restrain_end $pcy $ke [lindex $coords($pullGroup) 1]
   if {$timeStep==$firstStep} {
      set cbx [lindex $coords($cblGroup) 0]
      set cby [lindex $coords($cblGroup) 1]
      set cbz [lindex $coords($cblGroup) 2]
      puts "cbl coords are $cbx $cby $cbz"
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
