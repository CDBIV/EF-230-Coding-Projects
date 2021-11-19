# Nov 11
# Team G11, Python Team Project
# Fall EF230
# Charles Bailey, Even Hals, Sam Dixon
# Purpose- The purpose of this assignment was to use a while loop and and conditional statements in order to
# make the robot drive around avoiding obsticles and anyone that trys to catch it forever.
# Method- We used skeleton codes provided in the rover and on GitHub to import all the initializations into the code. We then 
# step up our variables and defined our main function. We used a while loop to make the robot continously drive around and check distance. We used 
# an if condition to tell the robot to turn anywhere from 90 to 180 degrees left and change from blue to red whenever something is 6 inches in front of it.
# We had to make it so our robot would turn if the distance between it and an object was greater than 6 because if there was nothing in front of it, it would 
# always say the distance was 2 inches. 

# Import
import qwiic_micro_oled
import sys
import os
sys.path.append('/home/pi/sphero-sdk-raspberrypi-python/')
import qwiic
import qwiic_vl53l1x
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../../')))
import time
import random
# import sphero sdk functions
# allow for Observer mode or Await/Async
import asyncio # allow concurrent code using async/await
from sphero_sdk import SerialAsyncDal
from sphero_sdk import SpheroRvrAsync
from sphero_sdk import RawMotorModesEnum
from sphero_sdk import SpheroRvrObserver
from sphero_sdk import Colors
# Initialize global variables
speed = 0
heading = 0
flags = 0

rvr = SpheroRvrObserver()

def main():

# Run the main control loop
    global speed
    global heading
    global flags
    rvr.wake()

# Give RVR time to wake up
    time.sleep(1)
# Reset yaw
    rvr.reset_yaw()
    time.sleep(1)
# Check time
    start_time = time.time()
    elapsed_time = time.time() - start_time

    ToF=qwiic.QwiicVL53L1X()
    ToF.sensor_init()
    print("\nSTAY AWAY\n")
    myOLED = qwiic_micro_oled.QwiicMicroOled()
    myOLED.begin()
    myOLED.clear(myOLED.PAGE)
    myOLED.clear(myOLED.ALL)  #  Clear display
    myOLED.set_font_type(0)
    myOLED.set_cursor(0,0)
    myOLED.print("Beep Boop Waaaaaaaaaaaoh")
    myOLED.set_cursor(0,15)
    myOLED.print("Dist(mm)")
    myOLED.display()

    if(ToF.sensor_init()==None):
        print("Sensor online\n")
    while True:
        try:
            rvr.reset_yaw() # Reset Yaw for Loop
            rvr.drive_with_heading(speed=60,heading=0,flags=0) # Initialize movement
            rvr.led_control.set_all_leds_rgb(red=0,green=0,blue=255)
            ToF.start_ranging()
            time.sleep(.25)
            distance = ToF.get_distance()    # Get the result of the measurement
            time.sleep(.25)
            ToF.stop_ranging()
            distI = distance / 25.4
            distF = distI / 12.0
            print("Distance(mm): %5.0f Distance(in): %5.3f" % (distance, distI))
            myOLED.set_cursor(0,30)
            myOLED.print("    ")
            myOLED.display()
            myOLED.print("%5.0f" % distance)
            myOLED.display()
            if distI > 6: # Distance Conditon for turning
                a = random.randint(90,180)
                rvr.led_control.set_all_leds_rgb(red=255,green=0,blue=0)
                rvr.drive_with_heading(speed=0,heading=0,flags=0)
                time.sleep(.1)
                rvr.drive_control.turn_left_degrees(heading=0,amount=a) # Turn left
        except Exception as e:
            print("Ctrl-C terminated process") # will terminate if you use ctrl-c
main()
