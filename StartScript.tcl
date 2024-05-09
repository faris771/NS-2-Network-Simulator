# Create the simulator object
set ns [new Simulator]

# Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

# Open the output trace file
set f [open out.tr w]
$ns trace-all $f

#####################################################
#       INSERT YOUR NETWORK DEFINTION HERE          #

# Define network nodes
# create newtwork node 

set src1 [$ns node]
set src2 [$ns node]
set edge1 [$ns node]
set edge2 [$ns node]
set core [$ns node]
set dest1 [$ns node]
set dest2 [$ns node]

# Creating links between nodes
$ns duplex-link $src1 $edge1 5Mb 1ms DropTail
$ns duplex-link $src2 $edge1 5Mb 1ms DropTail
$ns duplex-link $edge1 $core 5Mb 1ms DropTail
$ns duplex-link $core $edge2 3Mb 1ms DropTail

# Limit queue size $ns queue-limit $node1 $node2 numberOfPackets
# $ns queue-limit $node1 $node2 numberOfPackets

$ns queue-limit $core $edge2  10 
$ns duplex-link $edge2 $dest1 5Mb 1ms DropTail
$ns duplex-link $edge2 $dest2 5Mb 1ms DropTail



# Define traffic sources and sinks
# UDP Source and Sink
set udpSrc [new Agent/UDP]
set nullSink1 [new Agent/Null]
$ns attach-agent $src1 $udpSrc
$ns attach-agent $dest1 $nullSink1
$ns connect $udpSrc $nullSink1

# CBR Traffic on UDP Source
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 500

# 500 *8 / 2*10^6
$cbr set interval_ 0.002
$cbr attach-agent $udpSrc
$ns at 1.0 "$cbr start"
$ns at 45.0 "$cbr stop"

#####################################################



$ns at 50.0 "finish"




proc finish {} {
    
  # Use the following external variables
  global ns nf f
  $ns flush-trace
	
  # Close the trace files
  close $nf
  close $f 

  # Show on the command line that we are running NAM
  puts "running NAM..."

  # Run NAM with the out.nam file 
  exec nam out.nam &

  exit 0
}

# Run the simulation
$ns run
