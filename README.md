# MIPS-16bit-Processor
16-bit MIPS Processor Using VHDL


## Datapath Schematic
![full datapath](https://user-images.githubusercontent.com/74878922/218163874-4b7e99d9-e874-45b5-a2a0-1b02af4a7e1a.jpg)

## 16-bit Instruction Format
| opcode | rd     | rs     | rt / i     
|--------|--------|--------|--------|
| 4 bits | 4 bits | 4 bits | 4 bits |
- opcode -- 4 bits (16 operations)
- rd -- Destination register in 16x16 register file
- rs - Source register in 16x16 register file
- rt / i -- Second source register OR immediate value

## Intruction Tests
Number
|Instruction|op|rd|rs|rt / i|output value|
|:----|:----|:----|:----|:----|:----|
|Addi r3 r0 5|4|3|0|5|5|
|Addi r4 r0 2|4|4|0|2|2|
|Slt r11 r3 r4|7|b|3|4|0|
|Sw r3 0(r0)|c|3|0|0|5|
|Sw r4 4(r0)|c|4|4|0|2|
|Addi r6 r0 4|4|6|0|4|4|
|Lw r7 0(r6)|8|7|0|6|2|
|Lw r8 0(r0)|8|8|0|0|5|
|Add r9 r7 r8|0|9|7|8|7|
|Slt r10 r0 r1|7|a|0|1|1|
|Slt r10 r1 r0|7|a|1|0|0|
|Or r5 r10 r9|3|5|10|9|7|
|Subi r10 r5 7|5|a|5|7|0|
|Sub r11 r10 r7|1|b|a|7|fffe|
|Sw r11 5(r8)|c|b|5|8|fffe|


## Simulation Data
![](https://lh3.googleusercontent.com/q9r_GU3_vELe9OhE2AeOe6Lb0dThx2pqFlfxfluP1ADDsWCHHD3gCvCwvNbZcOf7xbq73B9UFxggz4XYjTEEzkvhareuRpay4avqfnLorubPOCGC1O3qXgwcctHZiXf-5peDWUlLE_H2URufbUxwyA)![](https://lh4.googleusercontent.com/U3V-S_tzdWXNugEtpki3ZM4WYJ_lq_dw1JB4FgmfDjnylLfaaXjkB4MxFLneO_XUIgF4wPtGupKr9eFWum4RRV2cTN-rfys1kjqxukpSADkSLupWDAFgmIF5P2VvBj_JWXX9YlBZNLzorCbS_WvxTw)
