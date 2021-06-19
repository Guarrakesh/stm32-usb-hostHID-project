# stm32-usb-hostHID-project


### **PROCEDIMENTO FATTO**

1. abbiamo provato a farcelo noi partendo da demo del 412g, ma ci stavano problemi relativi al clock ecc(roba board specific)
2. progetto seguendo youtube generato da cubemx(magari possiamo far vedere come ce lo costruiamo a mano capendo ogni passo senza dire che lo abbiamo preso da youtube, pero almeno config clock dovevamo per forza copiarla da qualche parte)
		https://www.youtube.com/watch?v=Co4ChSgVSek&ab_channel=ControllersTech
3. costruzione makefile ad hoc per prendersi questo progetto di partenza. mi pare che ho tolto syscall e mem, ho incluso solo i file .c di cui avevo strett necessità(guardando halconf)
4. eliminata tutta la logica relativa all'uart (potevamo anche seguire gli step e generare progetto senza uart in effetti)
5. modificata la logica della callback del mouse 
6. COMPORTAMENTI MOLTO NON DETERMINISTICI DURANTE DEBUG(MOUSE NON ALIMENTATO, LED NON LAMPEGGIA MA SI BLOCCA ECC, BHO)
	
	
	
	
### **per farlo funzionare**
	
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






	
