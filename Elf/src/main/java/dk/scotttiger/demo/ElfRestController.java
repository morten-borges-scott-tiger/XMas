package dk.scotttiger.demo;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ElfRestController {
	
	@PostMapping(value = "/produce")
	public ResponseEntity<Present> produce(@RequestBody String description) {
		Present present = new Present(description);
		return new ResponseEntity<Present>(present, HttpStatus.OK);
	}
	
	

}
