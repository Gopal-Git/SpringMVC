package com.example.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class ControllerDemo {
	@Value("${azure.application-insights.instrumentation-key}")
	String keyValue;
	@RequestMapping(method = RequestMethod.POST, path = "/aa")
	public void sayHello() {
		
		Logger logger = LoggerFactory.getLogger(ControllerDemo.class);
		logger.info("Pushed  log to azure app insight at 7 : 17");
		logger.error("Error ", new NullPointerException());
//		System.out.println(keyValue +"___________");
//		System.out.println(java.lang.management.ManagementFactory.getRuntimeMXBean().getInputArguments()
//);
	}
}
