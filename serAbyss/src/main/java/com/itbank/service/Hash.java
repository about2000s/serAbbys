package com.itbank.service;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Hash {

	public static String getHash(String authNumber) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			md.reset();
			md.update(authNumber.getBytes("UTF-8"));
			String ret = String.format("%0128x", new BigInteger(1, md.digest()));
			return ret;
		}catch(NoSuchAlgorithmException | UnsupportedEncodingException e) {
			System.out.println("해시 알고리즘 틀렸거나 인코딩 문제");
			e.printStackTrace();
		}
		return null;
	}

}
