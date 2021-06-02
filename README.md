# stm32-usb-hostHID-project


PROCEDIMENTO FATTO:
	1 abbiamo provato a farcelo noi partendo da demo del 412g, ma ci stavano problemi relativi al clock ecc(roba board specific)
	2 progetto seguendo youtube generato da cubemx(magari possiamo far vedere come ce lo costruiamo a mano capendo ogni passo senza dire che lo abbiamo preso da youtube, pero almeno config clock dovevamo per forza copiarla da qualche parte)
		https://www.youtube.com/watch?v=Co4ChSgVSek&ab_channel=ControllersTech
	3 costruzione makefile ad hoc per prendersi questo progetto di partenza 
		mi pare che ho tolto syscall e mem, ho incluso solo i file .c di cui avevo strett necessità(guardando halconf)
	4 eliminata tutta la logica relativa all'uart (potevamo anche seguire gli step e generare progetto senza uart in effetti)
	5 modificata la logica della callback del mouse 
	6 COMPORTAMENTI MOLTO NON DETERMINISTICI DURANTE DEBUG(MOUSE NON ALIMENTATO, LED NON LAMPEGGIA MA SI BLOCCA ECC, BHO)
	
	
	
	
	per farlo funzionare:
	
		clona progetto
		configura correttamente il percorso di cubeF4 nel makefile 
		make 
		mouse attaccato alla scheda
		scheda attaccata al pc 
		avvia openocd 
		make debug
		continue
		stacca scheda da porto usb pc 
		chiudi msys e cmd (openocd)
		riattacca
		aspetta che si accenda laser mouse (se non va prova a staccare e riattaccare un paio di volte)
		usa mouse 






	
