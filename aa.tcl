set val(chan)           Channel/WirelessChannel    ;# channel type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         50                         ;# max packet in ifq
set val(nn)             4                          ;# number of mobilenodes
set val(rp)             AODV                     ;# routing protocol
set val(x)              500
set val(y)              500




set ns_         [new Simulator]
set tracefd     [open out.tr w]
$ns_ trace-all $tracefd

set namtrace [open out.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)


set topo       [new Topography]

$topo load_flatgrid 500 500

create-god $val(nn)

set chan_1_ [new $val(chan)]

$ns_ node-config -adhocRouting $val(rp) \
	 -llType $val(ll) \
	 -macType $val(mac) \
	 -ifqType $val(ifq) \
	 -ifqLen $val(ifqlen) \
	 -antType $val(ant) \
	 -propType $val(prop) \
	 -phyType $val(netif) \
	 -channel $chan_1_ \
	 -topoInstance $topo \
	 -agentTrace ON \
	 -routerTrace ON \
	 -macTrace OFF \
	 -movementTrace ON                      

for {set i 0} {$i < $val(nn) } {incr i} {
        set node_($i) [$ns_ node]       
        $node_($i) random-motion 1
}
for {set i 0} {$i < $val(nn) } {incr i} {
        $ns_ initial_node_pos $node_($i) 25            
}

$node_(0) set X_ 50.0
$node_(0) set Y_ 50.0
$node_(1) set X_ 400.0
$node_(1) set Y_ 400.0
for {set i 2} {$i < $val(nn) } {incr i} {
$node_($i) set X_ 225.0
$node_($i) set Y_ 225.0
$node_($i) set Z_ 0.0
}
#

$ns_ at 0.1 "$node_(1) setdest 50.0 400.0 5.0"
$ns_ at 0.1 "$node_(0) setdest 400.0 50.0 5.0"
$ns_ at 0.1 "$node_(2) setdest 225.0 50.0 10.0"
$ns_ at 0.1 "$node_(3) setdest 225.0 400.0 5.0"


set udp1 [new Agent/UDP]
$ns_ attach-agent $node_(1) $udp1
$udp1 set class_ 0

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set packetSize_ 1000
$cbr1 set interval_ 0.02

set null1 [new Agent/Null]
$ns_ attach-agent $node_(0) $null1

$ns_ connect $udp1 $null1
$ns_ at 2.0 "$cbr1 start"

$ns_ at 160.0 "finish"
$ns_ at 160.01 "puts \"NS EXITING...\" ; $ns_ halt"

proc finish {} {
    global ns_ tracefd namtrace
    $ns_ flush-trace
    close $tracefd
    close $namtrace
    exec nam out.nam &
    exit 0
}

$ns_ run