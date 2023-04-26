# Cheetah v3 Klipper Firmware

The firmware installation process for the Fysetc Cheetah v3 MCU.

### Prerequisites

* Klipper must be installed onto the Raspberry Pi
* It is desirable, though not strictly necessary to have a small sdcard available
* Even if you intend to power your Pi with the Cheetah v3, during this flashing process, you will find it far more convenient to power your Pi from some other source, such as a regular USB power supply
* Voron Design recommends using USB to control the Cheetah v3, which simply requires connecting a USB-A to USB-C cable between the Cheetah v3 and Pi.  If you prefer a UART connection, please consult the fysetc documentation for the necessary configuration adjustments.

### Build Firmware Image

* Login to the Raspberry Pi via ssh
* Run the following:

   ```
   sudo apt install make
   cd ~/klipper
   make clean
   make menuconfig
   ```

* In the menu structure there are a number of items to be selected.
  * Select "Enable extra low-level configuration options"
  * Set the micro-controller architecture is set to `STMicroelectronics STM32`
  * Set the Processor model to `STM32F446`
  * Set the Bootloader offset to `No bootloader`
  * Set the Clock Reference to `12 MHz crystal`
  * Set the Communication interface to `USB (on PA11/PA12)`  (note: see Fysetc documentation if you intend to use UART rather than USB)

   ![](./makemenuconfig.jpg)

* Once the configuration is selected, press `q` to exit, and "Yes" when  asked to save the configuration.

* Run the command `make`
* The `make` command, when completed, creates a firmware file **klipper.bin** which is stored in the folder `/home/pi/klipper/out`.  

There are multiple options for getting this firmware file installed onto your Cheetah v3.

### Firmware Installation
#### DFU Firmware Install

* Requires a USB connection
* Requires the installation of an extra jumper on the Cheetah v3
* Does NOT require a microSD card

1. Power off the Cheetah v3
2. Install a jumper between BT0 and 3.3V
3. Connect Cheetah v3 & Pi via USB
4. Power on Cheetah v3
5. From your ssh session, run `cd ~/klipper` to make sure you are in the correct directory
6. Run `lsusb`. and find the ID of the DFU device.
7. Run `make flash FLASH_DEVICE=1234:5678`, replacing 1234:5678 with the ID from the previous step
8. Power off the Cheetah v3
9. Remove the jumper from BT0/3.3V
10. Power up the Cheetah v3
11. You can confirm that the flash was successful by running `ls /dev/serial/by-id`.  If the flash was successful, this should now show a klipper device, similar to:
 
   ![](./stm32f446_id.png)

   (note: this test is not applicable if the firmware was compiled for UART, rather than USB)
   
### Back to [Software Installation](./index.md#klipper-octoprint-configuration)
