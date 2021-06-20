# stm32-usb-hostHID-project

NON SO FORMATTARE I README E MI SCOCCIO DI CAPIRE COME SI FA, QUINDI APRITELO IN MODIFICA E LO POTETE VEDERE FORMATTATO COME INTENDEVO FORMATTARLO THANKS STRONZI


### **PROCEDIMENTO FATTO**

1. abbiamo provato a farcelo noi partendo da demo del 412g, ma ci stavano problemi relativi al clock ecc(roba board specific)
2. progetto seguendo youtube generato da cubemx(magari possiamo far vedere come ce lo costruiamo a mano capendo ogni passo senza dire che lo abbiamo preso da youtube, pero almeno config clock dovevamo per forza copiarla da qualche parte)
		https://www.youtube.com/watch?v=Co4ChSgVSek&ab_channel=ControllersTech
3. costruzione makefile ad hoc per prendersi questo progetto di partenza. mi pare che ho tolto syscall e mem, ho incluso solo i file .c di cui avevo strett necessità(guardando halconf)
5. modificata la logica della callback del mouse e qualche altra piccola modifica (fare riferimento a procedimento completo) 
6. COMPORTAMENTI MOLTO NON DETERMINISTICI DURANTE DEBUG(MOUSE NON ALIMENTATO, LED NON LAMPEGGIA MA SI BLOCCA ECC, BHO)
7. alla fine abbiamo scoperto che con gdb server funzionava tutto a meraviglia

	
### **nuovo procedimento completo**

1. new->stm32 project
2. board selector->modello board selezioni e next
3. nome progetto c exec stm32cube
4. perif default mode yes
5. pinout->clear pinout
6. a->z
7. rcc->HSE->CRYSTAL
8. usb_otg_fs->mode hostonly e activate vbus 
9. usb_host->human interface host hid 
10. pc0->gpio_output 
11. usb_host->platform settings metti activatevbusfs    gpio_output e PC0
12. (verifica clock 168 Mhz e 48 verso USB)
13. ctrl s e generate project 
14. copia directory progetto appena generato nella directory WORKSPACE (dove sta progetto github e STM32F4)
	oppure devi cambiare le variabili relative a questi path nel makefile(sconsigliato perche ci da problemi poi su git se non abbiamo tutti il workspace organizzato allo stesso modo)
	
15. make prepare 

16. main
private includes metti #include "usbh_hid.h"
private macro metti #define MOUSE_COORD_THRESHOLD 5 #define MOUSE_INVERTED_AXIS 0
private user code copia tal e qual la callback da noi prodotta  (prevede anche estensione per tastiera)
in mx_gpio init aggiungi:
	  __HAL_RCC_GPIOD_CLK_ENABLE();
	  
	  /*Configure GPIO pins : LD4_Pin LD3_Pin LD5_Pin LD6_Pin */
		GPIO_InitStruct.Pin = GPIO_PIN_12|GPIO_PIN_13|GPIO_PIN_14|GPIO_PIN_15;
		GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
		GPIO_InitStruct.Pull = GPIO_NOPULL;
		GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
		HAL_GPIO_Init(GPIOD, &GPIO_InitStruct);
		
		
17. make
18. avvia gdbserver.bat
19. make debug 

20. fai quel che cazz ti pare 
	
	
	
### **per farlo funzionare(old)**
	
1. clona progetto
2. configura correttamente il percorso di cubeF4 nelmakefile. Di default si trova a un livello su
3. make 
4. mouse attaccato alla scheda
5. scheda attaccata al pc 
6. avvia openocd 
7. make debug
8. continue
9. stacca scheda da porto usb pc 
10. chiudi msys e cmd (openocd)
11. riattacca
12. aspetta che si accenda laser mouse (se non va prova astaccare e riattaccare un paio di volte)
13. usa mouse 


### **da fare**

1. COME PROCEDERE COME MODIFICHE ULTERIORI
	lcd
	pwm rgb
	led + descrittori


	
DONE -2. MODIFICHE DA FARE AL MAKEFILE
	magari due directory in src che distinguono i file da customizzare e quelli di libreria 
	header descrittivo delle funzionalita(?)
	
3. MODIFICHE DA FARE NEL CODICE 
	CONSIDERA ANCHE TASTIERA(?)
	
5. DOCUMENTAZIONE 
	capire il flow di chiamate del codice 
	DONE -documenta tutto il procedimento seguito dall'inizio con le difficolta incontrate e i motivi che ci hanno spinto a cambiare strada 
		vedi sopra procedimento fatto e procedura per farlo funzionare(problema che abbiamo avuto con debugger ecc)
	
6. SPIEGA CUBEMX
	DONE -spiegare per bene il flow con il quale abbiamo generato il template da cube mx 
	guardando anche dove ha messo mano 
	spiega qualcosa di base di come si usa 
	
7. AFFRONTA LA QUESTIONE DEL DEBUG CHE NON VA CHISA PERCHE
	DEFINITIVA:
		cubemx:
			openocd work (swd)
			gdbserver work(swd)
		cmd:
			openocd doesnt work 
			gdbserver work 
	
	
8. PERCHE MOUSE WIRELESS NON FUNZIONA 
	forse struttura dati che contiene bottoni e coordinate viene gestita diversamente a parità di spostamento(magari centrata su 127 o 0 in casi diversi)
	magari usb 2.0 non supporta mouse wiki 
	ricorda che comunque da 3.3 V non 5 V come chiede lo standard(shcematic user manual e lo dice anche tut youtube)

	
