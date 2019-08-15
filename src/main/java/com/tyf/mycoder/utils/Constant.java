package com.tyf.mycoder.utils;

import java.text.SimpleDateFormat;

public interface Constant {
	
	//数据库类型
	int MYSQL = 0;
	int SQL_SERVER = 1;
	
	String SQL_SERVER_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	
	String SQL_SERVER_URL1 = "jdbc:sqlserver://";
	String SQL_SERVER_URL2 = ":1433;DatabaseName=";
	
	
	String MYSQL_DRIVER = "com.mysql.jdbc.Driver";
	String MYSQL_URL1 = "jdbc:mysql://";
	String MYSQL_URL2 = ":3306/";
	
	
	
	
	
	//文件类型
	int ENTITY = 1;
	int CONTROLLER = 2;
	int SERVICE = 3;
	int DAO = 4;
	int JS = 5;
	int JSP = 6;
	
	
	//你模板放置的路径
	String FTL_PATH = "ftl";

	SimpleDateFormat SDF = new SimpleDateFormat("yyyy年MM月dd日");

}
