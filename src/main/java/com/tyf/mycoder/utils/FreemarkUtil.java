package com.tyf.mycoder.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.ObjectWrapper;
import freemarker.template.Template;

public class FreemarkUtil {
	
	public static String saveDir = "/home/tyf/桌面/files/";
	//你模板放置的路径
	public static String basePath = "/home/tyf/Workspaces/xSpace/GenWebModel/ftl";

	public static File loadTemplateFile = null;

	private static Configuration cfg = new Configuration();
	
	public static boolean  entity_flag = false;
	public static boolean  dao_flag = false;
	public static boolean  service_flag = false;
	public static boolean  controller_flag = false;
	public static boolean  js_flag = false;
	public static boolean  jsp_flag = false;

	
	public static void SetJavaCode(Template temp,Map<String, Object> dataMap) {
        
        String ClassName = dataMap.get("entityName").toString();
        // 使首字母大写
        // 存入，作为参数给页面 className：作为引用名 ClassName：作为类名
        String fileNameEntityPath = saveDir + "/"+ConnectionUtil.tablename+"/entity/" + ClassName + ".java";
        String fileNameDaoPath = saveDir + "/"+ConnectionUtil.tablename+"/dao/" + ClassName + "Dao.java";
        String fileNameServicePath = saveDir + "/"+ConnectionUtil.tablename+"/service/" + ClassName+ "Service.java";
        String fileNameControllerPath = saveDir + "/"+ConnectionUtil.tablename+"/controller/" + ClassName + "Controller.java";
        String fileNameJsPath = saveDir + "/"+ConnectionUtil.tablename+"/js/" + BeanConvertUtil.toLowerCaseFirstOne(ClassName) + ".js";
        String fileNameJspPath = saveDir + "/"+ConnectionUtil.tablename+"/jsp/" + BeanConvertUtil.toLowerCaseFirstOne(ClassName) + ".jsp";
        
        
        File newsDir = new File(saveDir);
        File newsDir1 = new File(saveDir + "/"+ConnectionUtil.tablename+"/entity/");
        File newsDir2 = new File(saveDir + "/"+ConnectionUtil.tablename+"/dao/");
        File newsDir3= new File(saveDir + "/"+ConnectionUtil.tablename+"/service/");
        File newsDir4 = new File(saveDir + "/"+ConnectionUtil.tablename+"/controller/");
        File newsDir5 = new File(saveDir + "/"+ConnectionUtil.tablename+"/js/");
        File newsDir6 = new File(saveDir + "/"+ConnectionUtil.tablename+"/jsp/");
        boolean flag = false;
	    flag = (Boolean) (newsDir.exists() == false ? newsDir.mkdirs() : true);

	    try {
	    	if(entity_flag){
	    		flag = (Boolean) (newsDir1.exists() == false ? newsDir1.mkdirs() : true);
        		Writer out = new OutputStreamWriter(new FileOutputStream(fileNameEntityPath), "utf-8");
        		temp = cfg.getTemplate("entity.ftl");
                temp.process(dataMap, out,ObjectWrapper.BEANS_WRAPPER);
                System.out.println("----------"+ClassName+"--entity生成完毕-------------");
        	}
            if(dao_flag){
            	flag = (Boolean) (newsDir2.exists() == false ? newsDir2.mkdirs() : true);
            	Writer out2 = new OutputStreamWriter(new FileOutputStream(fileNameDaoPath), "utf-8");
            	temp = cfg.getTemplate("dao.ftl");
                temp.process(dataMap, out2,ObjectWrapper.BEANS_WRAPPER);
                System.out.println("----------"+ClassName+"--dao生成完毕-------------");
        	}
            if(service_flag){
            	flag = (Boolean) (newsDir3.exists() == false ? newsDir3.mkdirs() : true);
            	Writer out3 = new OutputStreamWriter(new FileOutputStream(fileNameServicePath), "utf-8");
            	temp = cfg.getTemplate("service.ftl");
                temp.process(dataMap, out3,ObjectWrapper.BEANS_WRAPPER);
                System.out.println("----------"+ClassName+"--service生成完毕-------------");
        	}
            if(controller_flag){
            	flag = (Boolean) (newsDir4.exists() == false ? newsDir4.mkdirs() : true);
            	Writer out4 = new OutputStreamWriter(new FileOutputStream(fileNameControllerPath), "utf-8");
            	temp = cfg.getTemplate("controller.ftl");
                temp.process(dataMap, out4,ObjectWrapper.BEANS_WRAPPER);
                System.out.println("----------"+ClassName+"--controller生成完毕-------------");
        	}
            if(js_flag){
            	flag = (Boolean) (newsDir5.exists() == false ? newsDir5.mkdirs() : true);
            	Writer out5 = new OutputStreamWriter(new FileOutputStream(fileNameJsPath), "utf-8");
            	temp = cfg.getTemplate("js.ftl");
                temp.process(dataMap, out5,ObjectWrapper.BEANS_WRAPPER);
                System.out.println("----------"+ClassName+"--js生成完毕-------------");
        	}
            if(jsp_flag){
            	flag = (Boolean) (newsDir6.exists() == false ? newsDir6.mkdirs() : true);
            	Writer out6 = new OutputStreamWriter(new FileOutputStream(fileNameJspPath), "utf-8");
            	temp = cfg.getTemplate("jsp.ftl");
                temp.process(dataMap, out6,ObjectWrapper.BEANS_WRAPPER);
                System.out.println("----------"+ClassName+"--jsp生成完毕-------------");
        	}
		} catch (Exception e) {
			// TODO: handle exception
		}
	    
        	
            
           
       
    }
	
	public static void genateCode(){
		Map<String, Object> dataMap = ConnectionUtil.getEntityData();
		Template temp = null;

		try {
			cfg.setDirectoryForTemplateLoading(loadTemplateFile);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SetJavaCode(temp,dataMap);
	}
	
	
}
