package api.runners;

import com.intuit.karate.junit5.Karate;

public class SmokeRunner {
	
	@Karate.Test
	public Karate renTests() {
		//run() method requied path ot feature files.
		//you can use tags() method to specify the Tags.
		return Karate.run("classpath:features")
				.tags("Smoke");
	}

}
