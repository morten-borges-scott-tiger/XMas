package dk.scotttiger.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ElfRestController {
	
	PrintWriter logger;
	Properties props = new Properties();
	
    private String logLocation = "/tmp/default.log";
	
	ElfRestController(){
		File config = new File("/config/config.properties");
		try {
			if(config.exists()) {
				props.load(new FileInputStream(config));
				logLocation = props.getProperty("LOGPATH", "/tmp/yule.log");
			}	
			logger = new PrintWriter( new FileWriter(logLocation, true) );
		} catch (IOException e) {
			logger = null;
		}
	}
	
	@GetMapping(value = "/produce/{description}")
	public ResponseEntity<Present> produce(@PathVariable String description) {
		Present present = new Present(description);
		//Logging
		if(logger != null) {
			logger.println(present.logString());
			logger.flush();
			
		}
		return new ResponseEntity<Present>(present, HttpStatus.OK);
	}
	
	

}
