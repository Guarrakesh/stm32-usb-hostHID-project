# stm32-usb-hostHID-project
Progetto per Embedded Systems a.a. 2020-2021 - P1. \
\
Utilizzo della libreria STM32-USB Host HID per il collegamento di un mouse attraverso un connettore USB OTG a una scheda STM32F407VG. \
\
L'output del movimento del mouse è dato dall'accensione dei 4 led, uno per direzione. 
<br><br>

### **Requisiti**
* st-link
* toolchain GNU ``arm-none-eabi``
* gdb server per on-chip debug
* USB OTG adapter
* Mouse **con cavo**, compliant a USB 2.0
* Board STM32F4
* Repository ``STM32CubeF4``

<br>

### **Eseguire il progetto**
1. Copiare la cartella ``STM32CubeF4`` un livello su rispetto al path del makefile. Altrimenti, per configurarne il percorso, modificare la variabile ``STM_DIR`` sul makefile.
2. >make
3. Verranno generate le cartelle
    * ``bin``, contenente i file in output alla compilazione tra cui il ``.elf`` da flashare sulla scheda.
    * ``dep``, contente i file ``.d`` necessari alla tracciamento delle dipendenze
    * ``obj``, contente i file oggetto
4. Avviare il gdbserver
5. >make debug
6. >continue

<br><br>

### **Procedura estesa per replicare il progetto (da aggiornare)**

***NOTA: Necessario STM32CubeIDE***
1. Aprire STM32CubeIDE new → stm32 project
2. board selector → modello board selezioni e next
3. nome progetto c exec stm32cube
4. perif default mode yes
5. pinout → clear pinout
6. a → z
7. rcc → HSE → CRYSTAL
8. usb_otg_fs → mode hostonly e activate vbus 
9. usb_host → human interface host hid 
10. pc0 → gpio_output 
11. usb_host → platform settings metti activatevbusfs    gpio_output e PC0
12. (verifica clock 168 Mhz e 48 verso USB)
13. ctrl s e generate project 
14. copia directory progetto appena generato nella directory WORKSPACE (dove sta progetto github e STM32F4)
	oppure devi cambiare le variabili relative a questi path nel makefile(sconsigliato perche ci da problemi poi su git se non abbiamo tutti il workspace organizzato allo stesso modo)
	
15. >make prepare 

16. Modificare ``main.c``
    * private includes:\
    <code>#include "usbh_hid.h"</code>\
    * private macro:\
    <code>#define MOUSE_COORD_THRESHOLD 5   </code>\
    <code>#define     MOUSE_INVERTED_AXIS 0 </code>
    * private user code:\
    *Inserire codice callback*
    
    * in <code>mx_gpio init</code> aggiungere: \
	  <code>__HAL_RCC_GPIOD_CLK_ENABLE(); </code>\
	  <code>/*Configure GPIO pins : LD4_Pin LD3_Pin LD5_Pin LD6_Pin */ </code>\
	  <code>GPIO_InitStruct.Pin = GPIO_PIN_12|GPIO_PIN_13|GPIO_PIN_14|GPIO_PIN_15; </code>\
	  <code>GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP; </code>\
	  <code>GPIO_InitStruct.Pull = GPIO_NOPULL; </code>\
	  <code>GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW; </code>\
	  <code>HAL_GPIO_Init(GPIOD, &GPIO_InitStruct); </code>		
		
17. >make
18. avviare gdbserver
19. >make debug 
20. enjoy
	
	
<br><br><br>

### **Possibili sviluppi**

* lcd
* pwm rgb
* led + descrittori
* tastiera
* documentazione
    * flow-chart
    * cubemx
        * ambiente
        * generazione progetto template e impatto sul codice
    * debug (openocd vs gdbserver st-link)
* problemi mouse wireless
    * alimentazione (indagare su voltaggio, in particolare 3.3V vs 5V)
    * strutture dati (come *mouse_info*) possono dipendere da specifico device
    * allineamento assi e wrap-around	
