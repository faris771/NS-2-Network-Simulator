# -*- coding: utf-8 -*-
import pandas # used to read the input
import numpy as np # matlab type functions

def rate(trace_file,event_type_requested,to_node_requested,packet_type_requested, granularity):
    '''
    This function reas tracefiles of ns2 and counts the datarate of certain packet stream identified by its packet type, destination node and event type. 

    Parameters
    ----------
    trace_file : path of the file we want to analyze.
        DESCRIPTION.
    event_type_requested : event type
        DESCRIPTION.
    to_node_requested : destination node
        DESCRIPTION.
    packet_type_requested : packet type
        DESCRIPTION.
    granularity : is the time window (in seconds) over which averages are taken
        DESCRIPTION.

    Returns
    -------
    time_axis : time axis
        DESCRIPTION.
    computed_rate : computed rate
        DESCRIPTION.
    '''
    column_names=[  'event_type',
                    'time',    
                    'from_node',
                    'to_node',
                    'packet_type', 
                    'packet_size', 
                    'flags',       
                    'flow_id',     
                    'packet_src',  
                    'packet_dst', 
                    'seq',         
                    'packet_id']
    data_frame = pandas.read_csv(trace_file,' ',names=column_names)
    
    selection_criteria=( (data_frame['event_type']  == event_type_requested) &
                        (data_frame['to_node']     == to_node_requested) &
                        (data_frame['packet_type'] == packet_type_requested) );
    
    selected_events=data_frame[selection_criteria];
    
    time_axis=np.arange(start=0,stop=data_frame['time'].max(),step=granularity ) 
    computed_rate=[]
    
    for t in time_axis:
        bits_in_interval=0.0
        my_data=selected_events[(selected_events['time']>=t) & (selected_events['time']<(t+granularity))] 
        my_iter=my_data.iterrows(); 
        for idx,row in my_iter:
            bits_in_interval=bits_in_interval+8.0*row['packet_size'];
        
        computed_rate.append(bits_in_interval/(granularity))

        
            
    #time_axis=np.array(time_axis)       
    computed_rate=np.array(computed_rate) #convert from list to array  
    return (time_axis,computed_rate)

