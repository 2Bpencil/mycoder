package com.tyf.mycoder.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class FileToZIP {
	
	private FileToZIP(){};  
	   /** 
	     * 创建ZIP文件 
	     * @param sourcePath 文件或文件夹路径 
	     * @param zipPath 生成的zip文件存在路径（包括文件名） 
	     */  
	    public static void createZip(String sourcePath, String zipPath) {  
	        FileOutputStream fos = null;  
	        ZipOutputStream zos = null;  
	        try {  
	            fos = new FileOutputStream(zipPath);  
	            zos = new ZipOutputStream(fos);  
	            //zos.setEncoding("gbk");//此处修改字节码方式。  
	            //createXmlFile(sourcePath,"293.xml");  
	            writeZip(new File(sourcePath), "", zos);  
	        } catch (FileNotFoundException e) {  
	        } finally {  
	            try {  
	                if (zos != null) {  
	                    zos.close();  
	                }  
	            } catch (IOException e) {  
	            }  
	  
	        }  
	    }  
	  
	    private static void writeZip(File file, String parentPath, ZipOutputStream zos) {  
	        if(file.exists()){  
	            if(file.isDirectory()){//处理文件夹  
	                parentPath+=file.getName()+File.separator;  
	                File [] files=file.listFiles();  
	                if(files.length != 0)  
	                {  
	                    for(File f:files){  
	                        writeZip(f, parentPath, zos);  
	                    }  
	                }  
	                else  
	                {       //空目录则创建当前目录  
	                        try {  
	                            zos.putNextEntry(new ZipEntry(parentPath));  
	                        } catch (IOException e) {  
	                            // TODO Auto-generated catch block  
	                            e.printStackTrace();  
	                        }  
	                }  
	            }else{  
	                FileInputStream fis=null;  
	                try {  
	                    fis=new FileInputStream(file);  
	                    ZipEntry ze = new ZipEntry(parentPath + file.getName());  
	                    zos.putNextEntry(ze);  
	                    byte [] content=new byte[1024];  
	                    int len;  
	                    while((len=fis.read(content))!=-1){  
	                        zos.write(content,0,len);  
	                        zos.flush();  
	                    }  
	  
	                } catch (FileNotFoundException e) {  
	                } catch (IOException e) {  
	                }finally{  
	                    try {  
	                        if(fis!=null){  
	                            fis.close();  
	                        }  
	                    }catch(IOException e){  
	                    }  
	                }  
	            }  
	        }  
	    }   
	      
	    public static void main(String[] args) {  
	    	FileToZIP.createZip("/home/tyf/develop/apache-tomcat-8.0.41/webapps/myAdmin/asset/createFiles/zip", "/home/tyf/develop/apache-tomcat-8.0.41/webapps/myAdmin/asset/createFiles/code"+new Date().getTime()+".zip");  
	    }    
}
