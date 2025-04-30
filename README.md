# DE1 PROJECT - DIGITAL CLOCK WITH ALARM AND STOPWATCH
________________________________________________
# Team members

Member 1: Ladislav Jonáš

Member 2: Martin Koleňák

Member 3: Matyas Heneberk

Member 4: Vojtěch Brhel
________________________________________________

# Program description

This project presents a digital clock design in VHDL. The program includes the functions of a classic digital clock, stopwatch and alarm. 

The digital clock works on the clock principle (1Hz), which counts pulses on the rising edge. The time setting itself is implemented using the yellow buttons on the board. The setting is done using the buttons. To set the time, you can select a given 7-segment display and set the exact time.

The stopwatch function is similar to the basic clock function. It works on the clock principle with a frequency of 1 Hz for counting numbers. The stopwatch is controlled by only one button (the middle yellow one). After the first press of the button, the stopwatch starts. After the second press, the counting stops. The stopwatch can be reset using switch 2.

The last function of the project is the alarm. The alarm provides the ability to set the time, when reached, a signal is generated. This is connected to the LED diode to control the alarm function.
  
________________________________________________

# Main benefits of the project

- simplicity
- teamwork

________________________________________________


# Hardware description and application


![image](https://github.com/user-attachments/assets/401f521a-6167-409a-97fc-6b2983f5d2f4)



## Video example:

Stopwatch:

https://www.youtube.com/watch?v=jS57hyXT2jQ

Clock verification:

Here is a video of the clock. You can see here that the clock and display functions have been verified.

https://youtu.be/vvPfmfUHTXw


## Hardware on the board:

Here is descibed our hardware implementation of each project part. 



### CLOCK:

![image](https://github.com/user-attachments/assets/16890e77-a17b-4454-aa7d-61bd1990a89b)


### ALARM:

![image](https://github.com/user-attachments/assets/788b4b2e-ddad-4721-9b7d-fe0ae90c4b68)


### STOPWATCH:

![image](https://github.com/user-attachments/assets/9c47d99e-c75b-4603-8956-6100cd4f809f)




________________________________________________

# Software description

## Block Scheme:
![image](https://github.com/user-attachments/assets/eb087970-55d7-4c71-9f35-b385362d16a3)

## Main component simulation:

### Clock:

![image](https://github.com/user-attachments/assets/cefaf0c0-360e-49ea-add1-5658e99d4cbf)

After one period of the clk_1hz signal, the seconds overflow from 59 to 00. The same thing happens with the minutes at 59, then they are also reset to 00.
Similarly, an overflow occurs for hours. From value 23 to 00. This triple transition is correctly captured in the simulation and verifies the correct functionality of the counter.


![image](https://github.com/user-attachments/assets/261d83d5-b7f8-4c2d-9b18-593602916f8b)

In this simulation was tested function of the stopwatch. If is switch 2 on - Stopwatch mode is displayed on the board. Then by pressing BTNC stopwatch starts couining using our CLK_1Hz. When you push BTNC once a again, then couting will stop. Switch 2 also works as a reset button.












________________________________________________

# References


https://www.edaplayground.com/

https://vhdl.lapinoo.net/

https://github.com/tomas-fryza/vhdl-labs









