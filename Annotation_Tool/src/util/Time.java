package util;

public class Time {
	
	public static java.sql.Timestamp getCurrentTimeStamp() {

		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime());
		//Usado para gerar o DateTime do mysql
	}
}
