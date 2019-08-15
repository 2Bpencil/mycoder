package com.tyf.mycoder.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.RandomAccessFile;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FileUtil {
	/**
     * 以字节为单位读取文件，常用于读二进制文件，如图片、声音、影像等文件。
     */
    public static void readFileByBytes(String fileName) {
        File file = new File(fileName);
        InputStream in = null;
        try {
            System.out.println("以字节为单位读取文件内容，一次读一个字节：");
            // 一次读一个字节
            in = new FileInputStream(file);
            int tempbyte;
            while ((tempbyte = in.read()) != -1) {
                System.out.write(tempbyte);
            }
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
        try {
            System.out.println("以字节为单位读取文件内容，一次读多个字节：");
            // 一次读多个字节
            byte[] tempbytes = new byte[100];
            int byteread = 0;
            in = new FileInputStream(fileName);
            FileUtil.showAvailableBytes(in);
            // 读入多个字节到字节数组中，byteread为一次读入的字节数
            while ((byteread = in.read(tempbytes)) != -1) {
                System.out.write(tempbytes, 0, byteread);
            }
        } catch (Exception e1) {
            e1.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e1) {
                }
            }
        }
    }

    /**
     * 以字符为单位读取文件，常用于读文本，数字等类型的文件
     */
    public static void readFileByChars(String fileName) {
        File file = new File(fileName);
        Reader reader = null;
        try {
            System.out.println("以字符为单位读取文件内容，一次读一个字节：");
            // 一次读一个字符
            reader = new InputStreamReader(new FileInputStream(file));
            int tempchar;
            while ((tempchar = reader.read()) != -1) {
                // 对于windows下，\r\n这两个字符在一起时，表示一个换行。
                // 但如果这两个字符分开显示时，会换两次行。
                // 因此，屏蔽掉\r，或者屏蔽\n。否则，将会多出很多空行。
                if (((char) tempchar) != '\r') {
                    System.out.print((char) tempchar);
                }
            }
            reader.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            System.out.println("以字符为单位读取文件内容，一次读多个字节：");
            // 一次读多个字符
            char[] tempchars = new char[30];
            int charread = 0;
            reader = new InputStreamReader(new FileInputStream(fileName));
            // 读入多个字符到字符数组中，charread为一次读取字符数
            while ((charread = reader.read(tempchars)) != -1) {
                // 同样屏蔽掉\r不显示
                if ((charread == tempchars.length)
                        && (tempchars[tempchars.length - 1] != '\r')) {
                    System.out.print(tempchars);
                } else {
                    for (int i = 0; i < charread; i++) {
                        if (tempchars[i] == '\r') {
                            continue;
                        } else {
                            System.out.print(tempchars[i]);
                        }
                    }
                }
            }

        } catch (Exception e1) {
            e1.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
    }

    /**
     * 以行为单位读取文件，常用于读面向行的格式化文件
     */
    public static void readFileByLines(String fileName) {
    	
        File file = new File(fileName);
        BufferedReader reader = null;
        try {
            System.out.println("以行为单位读取文件内容，一次读一整行：");
            reader = new BufferedReader(new FileReader(file));
            String tempString = null;
            int line = 1;
            // 一次读入一行，直到读入null为文件结束
            while ((tempString = reader.readLine()) != null) {
                // 显示行号
                System.out.println("line " + line + ": " + tempString);
                line++;
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
    }

    /**
     * 随机读取文件内容
     */
    public static void readFileByRandomAccess(String fileName) {
        RandomAccessFile randomFile = null;
        try {
            System.out.println("随机读取一段文件内容：");
            // 打开一个随机访问文件流，按只读方式
            randomFile = new RandomAccessFile(fileName, "r");
            // 文件长度，字节数
            long fileLength = randomFile.length();
            // 读文件的起始位置
            int beginIndex = (fileLength > 4) ? 4 : 0;
            // 将读文件的开始位置移到beginIndex位置。
            randomFile.seek(beginIndex);
            byte[] bytes = new byte[10];
            int byteread = 0;
            // 一次读10个字节，如果文件内容不足10个字节，则读剩下的字节。
            // 将一次读取的字节数赋给byteread
            while ((byteread = randomFile.read(bytes)) != -1) {
                System.out.write(bytes, 0, byteread);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (randomFile != null) {
                try {
                    randomFile.close();
                } catch (IOException e1) {
                }
            }
        }
    }

    /**
     * 显示输入流中还剩的字节数
     */
    private static void showAvailableBytes(InputStream in) {
        try {
            System.out.println("当前字节输入流中的字节数为:" + in.available());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    
    /**
     * 以行为单位读取文件，常用于读面向行的格式化文件
     */
    public static List<String> readFileByLinesReturnComment(String fileName) {
    	fileName = "/home/tyf/桌面/De/"+fileName+".sql";
    	List<String> list = new ArrayList<>();
    	List<String> listTemp = new ArrayList<>();
        File file = new File(fileName);
        BufferedReader reader = null;
        try {
            System.out.println("以行为单位读取文件内容，一次读一整行：");
            reader = new BufferedReader(new FileReader(file));
            String tempString = null;
            int line = 1;
            // 一次读入一行，直到读入null为文件结束
            while ((tempString = reader.readLine()) != null) {
                // 显示行号
                //System.out.println("line " + line + ": " + tempString);
                
                if(isContainChinese(tempString)){
                	Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
                	Matcher m = p.matcher(tempString);
                	String content = "";
                	while(m.find()){
                		content += m.group();
                	}
                	list.add(content);
                }
                line++;
            }
            reader.close();
            
            
            for (String str : list) {
				System.out.println(str);
				/*if(!listTemp.contains(str)){
					listTemp.add(str);
				}*/
			}
           /* listTemp.remove(0);//特殊
            System.out.println("**************************");
            for (String str : listTemp) {
            	System.out.println(str);
			}*/
            
            return list;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
		return listTemp;
    }
    
    
    public static boolean isContainChinese(String str){
    	Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
    	Matcher m = p.matcher(str);
    	if(m.find()){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    
    public static List<String> getAllFileName(String path){
    	List<String> fileNames = new ArrayList<String>();
    	File file = new File(path);
    	File[] files = file.listFiles();
    	if(files != null){
    		for (int i = 0; i < files.length; i++) {
				if(files[i].isFile()){
					fileNames.add(files[i].getName());
				}
			}
    	}
    	return fileNames;
    }
    
    
    public static void copyDir(String oldPath, String newPath) throws IOException {
        File file = new File(oldPath);
        String[] filePath = file.list();
        
        if (!(new File(newPath)).exists()) {
            (new File(newPath)).mkdir();
        }
        
        
        for (int i = 0; i < filePath.length; i++) {
            if ((new File(oldPath + file.separator + filePath[i])).isDirectory()) {
                copyDir(oldPath  + file.separator  + filePath[i], newPath  + file.separator + filePath[i]);
            }
            
            if (new File(oldPath  + file.separator + filePath[i]).isFile()) {
                copyFile(oldPath + file.separator + filePath[i], newPath + file.separator + filePath[i]);
            }
        }
    }
    
    public static void copyFile(String oldPath, String newPath) throws IOException {
        File oldFile = new File(oldPath);
        File file = new File(newPath);
        FileInputStream in = new FileInputStream(oldFile);
        FileOutputStream out = new FileOutputStream(file);;

        byte[] buffer=new byte[2097152];
        
        while((in.read(buffer)) != -1){
            out.write(buffer);
        }
    
        
    }
    
    public static boolean delAllFile(String path) {  
        boolean flag = false;  
        File file = new File(path);  
        if (!file.exists()) {  
            return flag;  
        }  
        if (!file.isDirectory()) {  
            return flag;  
        }  
        String[] tempList = file.list();  
        File temp = null;  
        for (int i = 0; i < tempList.length; i++) {  
            if (path.endsWith(File.separator)) {  
                temp = new File(path + tempList[i]);  
            } else {  
                temp = new File(path + File.separator + tempList[i]);  
            }  
            if (temp.isFile()) {  
                temp.delete();  
            }  
            if (temp.isDirectory()) {  
                delAllFile(path + "/" + tempList[i]);// 先删除文件夹里面的文件  
                delFolder(path + "/" + tempList[i]);// 再删除空文件夹  
                flag = true;  
            }  
        }  
        return flag;  
    } 
    
//  // 删除完文件后删除文件夹  
//  // param folderPath 文件夹完整绝对路径  
    public static void delFolder(String folderPath) {  
        try {  
            delAllFile(folderPath); // 删除完里面所有内容  
            //不想删除文佳夹隐藏下面  
          String filePath = folderPath;  
          filePath = filePath.toString();  
          java.io.File myFilePath = new java.io.File(filePath);  
          myFilePath.delete(); // 删除空文件夹  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
    
    public static void main(String[] args) {
        /*String fileName = "classmates";
        FileUtil.readFileByLinesReturnComment(fileName);*/
    	/*List<String> list = getAllFileName("/home/tyf/develop/apache-tomcat-8.0.41/webapps/myAdmin/asset/createFiles/controller");
    	System.out.println(list.size());
    	for (String string : list) {
			System.out.println(string);
		}*/
    	
    	/*try {
			copyDir("/home/tyf/develop/apache-tomcat-8.0.41/webapps/myAdmin/asset/createFiles/s_user", "/home/tyf/develop/apache-tomcat-8.0.41/webapps/myAdmin/asset/createFiles/zip/s_user");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
    	delAllFile("/home/tyf/develop/apache-tomcat-8.0.41/webapps/myAdmin/asset/createFiles/zip");
    	
    }

}
