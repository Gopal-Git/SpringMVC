package com.example.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Logger logger = LoggerFactory.getLogger(test.class);
		logger.debug("In main method");
		logger.error("Error ", new NullPointerException());
	}

}
