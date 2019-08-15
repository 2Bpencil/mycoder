package com.tyf.mycoder.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

public class ParamsInitUtil {

	
	public static void initParams(){
		
		String path = ParamsInitUtil.class.getClass().getResource("/").getPath();
		Properties pro = new Properties();
		try {
			FileInputStream in = new FileInputStream(path+"config/params.properties");
			pro.load(new InputStreamReader(in, "utf-8"));
			in.close();
			ConnectionUtil.driver = pro.get("driverClassName").toString();
			ConnectionUtil.url = pro.get("url").toString();
			ConnectionUtil.pwd = pro.get("password").toString();
			ConnectionUtil.user = pro.get("username").toString();
			ConnectionUtil.tablename = pro.get("tableName").toString();
			FreemarkUtil.saveDir = pro.get("saveDir").toString();
			FreemarkUtil.basePath = path.replace("bin/", "ftl");
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
	
	
}
