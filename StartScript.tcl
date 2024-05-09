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
$ns queue-limit $edge2 $core 10
$ns duplex-link $edge2 $dest1 5Mb 1ms DropTail
$ns duplex-link $edge2 $dest2 5Mb 1ms DropTail



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
