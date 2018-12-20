package dk.scotttiger.demo;

import java.time.LocalDate;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Present {
	private String description = "Tubesocks";
	private LocalDate productionDate = LocalDate.now();

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public Present(String description) {
		this.description = description;
	}

	public LocalDate getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(LocalDate productionDate) {
		this.productionDate = productionDate;
	}

	public String logString() {
		return productionDate.toString() + ':' + description;
	}
}
