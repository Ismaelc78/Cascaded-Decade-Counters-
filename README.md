# Cascaded-Decade-Counters-
Bidirectional counter (0.00-99.9) driven by a 10Hz clock. 
Counter is shown on 7-Segment Displays 

###### Hardware: 
Altera De1-SoC.


###### Software:
Quartus Prime 18.1 & LogiSim


###### Language:
Verilog HDL


## Objective: 
To design a decimal decade counter created from bidirectional counters. Throughout the process, will design
an up counter, down counter, bidirectional counter, and finally, the cascaded decade counter. The purpose is to
understand how counters work by design.

## Prelim work:
###### 1. D Flip Flop Verilog Module
###### 2. Up Counter state table
###### 3. Down Counter sate table

## 1. D Flip Flop Verilog Module
The D Flip Flop requires the following:
  1. Positive edge clock
  2. Output = 0 when reset = 1
  3. Output = Input when reset = 0
  4. Output = 1 when preset = 1
This was accomplished using an always @ block

## 2. Up Counter
The requirements for this counter are:
  1. Counts from 0 – 9
  2. Starts at 0 again after reaching 9
  3. Overflow state after reaching 9 (lasts one clock)
  4. Preset to 9
  5. Reset to 0
  6. Use D Flip Flops and some glue
  
Since the number 9 uses 4 bits, I will use the output of 4 D Flip Flops.

First, I’ll tackle the easy parts (Reset/Preset)

The D Flip Flop output resets to 0 when reset is 1. That means I can use 1 Reset for all 4 D Flip Flops.

The Preset we want is 1001. Since the D Flip Flop output is 1 when preset is 1, I can use the input of Preset to DFF 0 and
DFF 3. Since resetting the D Flip Flops brings their output to 0, I make the Preset input an option for the Resets of DFF2 &
DFF1. The outcome will be as shown in figure 1.

Also have to keep in mind that the DFF’s reset to 0 when the count reaches 1001 (9). 

###### _Figure 1: Reset & Presets Up Counter_
![alt text](https://github.com/Ismaelc78/Cascaded-Decade-Counters-/blob/main/iamgesCDC/Fig.png)

Next will be the actual counting. For this I will build a state table: 
![alt text](https://github.com/Ismaelc78/Cascaded-Decade-Counters-/blob/main/iamgesCDC/Fig2.png)

For a counter/flip flop, the next state is what in the read at the D input
Therefore, D = Q next.
Now I need to find the expressions for each D input.
  D3 = 0111, 1000 = Q[3] ^ (Q[2] & Q[1] & Q[0])
  D2 = 0011, 0100, 0101, 0110 = 0011, 010x, 01x0 = Q[2] ^ (Q[1] & Q[0]
  D1 = 0001, 0010, 0101, 0110 = xx10 , xx01 = Q[1] ^ Q[0]
  D0 = With Behavioral analysis, I see that D0 is the opposite of Q0 = ~Q[0]
  
Now we have the input and output (count) settled.

Next, lets take another look at the reset. I want it to reset once the output is 1001.

This means, once the out put is Q[3] & Q[1]. I can add that into the reset behavior of each DFF as seen in figure 2

###### _Figure 2: Resets and Presets Up Counter_
![alt text](https://github.com/Ismaelc78/Cascaded-Decade-Counters-/blob/main/iamgesCDC/Fig3.png)

Next is the overflow detector. Since I want the overflow to signal after the counter reaches nine and once it goes back to
zero, then I can add it as another DFF. Through behavioral analysis, I can see that I will want the overflow DFF to clock in
a 1 when the Counter’s output is 1001. So, we make the Din for the overflow DFF = Q[3] & Q[0].

## 3. Down Counter

The requirements for this counter are:
  1. Counts from 9 – 0
  2. Starts at 9 again after reaching 0
  3. Overflow state after reaching 0 (lasts one clock)
  4. Preset to 9
  5. Reset to 0
  6. Use D Flip Flops and some glue 

###### _Down Counter state table_
![alt text](https://github.com/Ismaelc78/Cascaded-Decade-Counters-/blob/main/iamgesCDC/fig4.png)

D3 = 0000, 1001 = (Q[3] ~^ Q[0]) & ~Q[2] & ~Q[1]
D2 = 0101, 0110, 0111, 1000 = (~Q[3] & Q[2] & (Q[1]|Q[0])) | (Q[3] & ~Q[2] & ~Q[1] & ~Q[0])
D1 = 0011, 0100, 0111, 1000 = (Q[3] ^ (Q[1] & Q[0]) ) | (~Q[3] & Q[2] & ~Q[1] & ~Q[0])
D0 = ~Q[0]

The reset and preset requirements are the same as the up counter.
This results in resets for:
D3 = Reset
D2 = Reset | Preset (reset when 1001)
D1 Reset | Preset (reset when 1001)
D0 = Reset

Presets only apply to D3 and D0 to get them to equal 1 when the counter is at 1001.


Overflow: Like the Up Counter, we want the overflow DFF to have the input of 1 when the counter reaches its end
(0000). When the clock comes, it will simultaneously reset the counter to 1001 and clock in the value of 1 into the
overflow DFF. 


## Simulation and Testing
###### _Part 1 Decimal Up Counter with Overflow_

With the use of DFF’s and some glue gates, as described earlier, I was able to meet the requirements of the Up Counter.
OR gates were used for the many inputs of the reset (preset, reset, end of count). The DFF D inputs were based on the
Boolean expressions found using the state table and diagrams. As seen in the below simulation , the results are as
expected. A total of 5 DFF’s were used. 
![alt text](https://github.com/Ismaelc78/Cascaded-Decade-Counters-/blob/main/iamgesCDC/Sim5.png)


###### _Part 2 Decimal Down Counter with Overflow_

Similar to the Up Counter, OR gates were used for the many inputs of the reset (preset, reset, end of count). The DFF D
inputs were based on the Boolean expressions found using the state table and diagrams. As seen in the below
simulation, the results are as expected. A total of 5 DFF’s were used. 
![alt text](https://github.com/Ismaelc78/Cascaded-Decade-Counters-/blob/main/iamgesCDC/Sim6.png)


###### _Part 3 Simulation: Bidirectional Decimal Counter_
For this counter, I can use the same logic from each of the up and down counters. The only difference is having a mode
input that will switch the input into the DFF’s. For this, I can use 2x1 mux. This will allow for mode selection between Up
and Down counter logic. The 2x1 multiplexers were used between each DFF and for the reset inputs. A total of 5 DFF’s
were used.

This will allow for selection between the differences of the up and down counters. Below are the simulation results 
![alt text](https://github.com/Ismaelc78/Cascaded-Decade-Counters-/blob/main/iamgesCDC/Sim7.png)

###### _Part 4 Simulation: Cascaded Decade Counters_

For this design, a clock module provided by the instructor was used. It effectively reduced the 50Hz signal to 10Hz.
Instances of the Bidirectional Counters were used in cascades to count from 00.0 to 99.9 or 99.9 to 00.0 depending on
the mode select (up/down counters). This was accomplished with the help of some glue gates, the clock Enable module
and, seven segment decoder modules to display the outputs on HEX displays. 

The clock period here is at 0.5ns to show that the enable Clock module produces an increase period 10x slower (5ns).
This new clock pulse is set as the input for the bidirectional flip flops.
design. Below is the simulation result from Quartus.
Key[0] = Reset
Key[1] = Preset
3 Images were provided to see a closer look at HEX0 values. 
![alt text](https://github.com/Ismaelc78/Cascaded-Decade-Counters-/blob/main/iamgesCDC/Sim8.png)

