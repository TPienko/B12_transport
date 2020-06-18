proc simAnneal {} {
   global cbx cby cbz simFlag simSteps numA dev atoms1 atoms2 atoms3 cblGroup pullGroup btubGroup timeStep kc rcx rcy rcz pcx pcy pcz kr kp ke addforceFreq forceFreq2
   set simFlag "on"
   ## SIMULATED ANNEALING ##
   set maxdev {35.0} ; set mindev {0.0}
   set steps {100} ; set minstep {-100} ; set maxstep {100}
   set n {2.0} ; set b $maxdev ; set a [expr -$maxdev/(pow($steps,$n))]
   #set b $maxdev ; set a1 [expr {$maxdev/$steps}] ; set a2 [expr {-$maxdev/$steps}]
   set heatSteps {2000} ; set maintainSteps {250000} ; set coolSteps {30000}
   set relaxSteps {50000}
   set simSteps [expr {$steps*$heatSteps+$steps*$coolSteps+$maintainSteps+$relaxSteps}]
   ####### HEATING #########
   while {$minstep<0} {
      set dev [expr {$a*pow($minstep,$n)+$b}]
      #set dev [expr {$a1*$minstep+$b}]
      run norepeat $heatSteps
      incr minstep
   }
   ##### MAINTAINING #######
   set dev [expr {$a*pow($minstep,$n)+$b}]
   #set dev $maxdev
   run norepeat $maintainSteps
   incr minstep
   ####### COOLING #########
   while {$minstep<=$maxstep} {
      set dev [expr {$a*pow($minstep,$n)+$b}]
      #set dev [expr {$a2*$minstep+$b}]
      run norepeat $coolSteps
      incr minstep
   }
   ######## RELAX ##########
   set simFlag "relax"
   run norepeat $relaxSteps
   #########################
   set numA [expr {$numA+1}]
}

proc normalRun {} {
   global cbx cby cbz firstStep simFlag simSteps numA dev atoms1 atoms2 atoms3 cblGroup pullGroup btubGroup timeStep kc rcx rcy rcz pcx pcy pcz v kr kp ke addforceFreq forceFreq2

   set heatSteps {2000} ; set maintainSteps {250000} ; set coolSteps {30000}
   set relaxSteps {50000} ; set steps {100}
   set simSteps [expr {$steps*$heatSteps+$steps*$coolSteps+$maintainSteps+$relaxSteps}]
   set simFlag "off"
   set runSteps {3500000}
   run norepeat $runSteps
}
