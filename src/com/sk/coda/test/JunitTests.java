package com.sk.coda.test;

import org.junit.Test;

import com.sk.coda.iot.myutil.MyUtil;

import static org.junit.Assert.assertEquals;

public class JunitTests {
	private MyUtil m;
	
	public JunitTests() {
		m = new MyUtil();
	}
	@Test
	public void testGetUserId() {
		String email = "shiva@my.com";
		int id = m.getUserId(email);
		assertEquals(10,id);
	}
	@Test
	public void testLogin() {
		String email = "shiva@my.com";
		String pass = "kishore";
		boolean isValid = m.isValidLogin(email, pass);
		assertEquals(true, isValid);
		
		pass = "wrong";
		isValid = m.isValidLogin(email, pass);
		assertEquals(false, isValid);
	}
}
