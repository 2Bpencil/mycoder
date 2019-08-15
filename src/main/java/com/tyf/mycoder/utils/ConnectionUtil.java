package com.tyf.mycoder.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;


public class ConnectionUtil {

	public static String url = "jdbc:sqlserver://192.168.20.185:1433;DatabaseName=security";
	public static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	public static String project = "project";
	public static String user = "sa";

	public static String pwd = "123qweA";

	public static String tablename = "economy";
	
	private static String[] cols;// 数据库字段
	private static String[] colnames; // 列名数组

	private static String[] colTypes; // 列名类型数组

	private static int[] colSizes; // 列名大小数组

	private static String entityName;// 实体名称
	private static boolean f_util = false; // 是否需要导入包java.util.*

	private static boolean f_sql = false; // 是否需要导入包java.sql.*
	
	public static List<String> getAllTableNames(String databaseName){
		//初始化参数
		//ParamsInitUtil.initParams();
		Connection conn = null;
		List<String> tableNameList = new ArrayList<String>();
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pwd);
			String sql = "";
			if("com.microsoft.sqlserver.jdbc.SQLServerDriver".equals(driver)){
				String dbName = databaseName;
				sql = "SELECT name FROM "+dbName+"..SysObjects WHERE XType='U' ORDER BY name";
			}else if("com.mysql.jdbc.Driver".equals(driver)){
				String dbName = databaseName;
				sql = "SELECT table_name name FROM information_schema.`TABLES` WHERE TABLE_SCHEMA = '"+dbName+"'";
			}
			Statement statement = conn.createStatement();
			ResultSet resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				if(!"case".equals(resultSet.getString("name"))){
					tableNameList.add(resultSet.getString("name"));
				}
				
			}
			return tableNameList;
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return tableNameList;
	}
	
	
	/**
	 * 获取数据库中的数据 
	 * @param tableName
	 * @return
	 */
	public static Map<String, Object> getEntityData() {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		List<String> importList = new ArrayList<String>();//存放import
		
		List<Map<String, String>> propertyMapList =  new ArrayList<>();
		List<Map<String, String>> methodMapList =  new ArrayList<>();
		
		Connection conn = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pwd);
			String strsql = "select * from " + tablename;
			entityName = BeanConvertUtil.fieldToProperty(tablename);
			entityName = BeanConvertUtil.initcap(entityName);//首字母大写
			PreparedStatement pstmt = conn.prepareStatement(strsql);
			ResultSetMetaData rsmd = pstmt.getMetaData();
			int size = rsmd.getColumnCount(); // 共有多少列
			cols = new String[size];
			colnames = new String[size];
			colTypes = new String[size];
			colSizes = new int[size];
			
			for (int i = 0; i < rsmd.getColumnCount(); i++) {
				cols[i] = rsmd.getColumnName(i + 1);
				colnames[i] = rsmd.getColumnName(i + 1).toLowerCase();
				colnames[i] = BeanConvertUtil.fieldToProperty(colnames[i]);
				colTypes[i] = rsmd.getColumnTypeName(i + 1);
				if (colTypes[i].equalsIgnoreCase("datetime")) {
					f_util = true;
				}
				if (colTypes[i].equalsIgnoreCase("image") || colTypes[i].equalsIgnoreCase("text")) {
					f_sql = true;
				}
				colSizes[i] = rsmd.getColumnDisplaySize(i + 1);
			}
			//*********************************************************
			if(f_util){
				importList.add("import java.util.*;");
			}
			if(f_sql){
				importList.add("import java.sql.*;");
			}
			//*********************************************************
			String[] propertyType = new String[colTypes.length];
			for (int i = 0; i < colTypes.length; i++) {
				String type = colTypes[i];
				propertyType[i] = sqlType2JavaType(type);
			}
			List<String> commentlist = new ArrayList<String>();//ReadFileUtil.readFileByLinesReturnComment(tablename);
			String commentSql = "show full FIELDS FROM "+tablename;
			pstmt = conn.prepareStatement(commentSql);
			ResultSet rs = pstmt.executeQuery(commentSql);
			while(rs.next()){
				commentlist.add(rs.getString("Comment"));
			}
			for (int i = 0; i < cols.length; i++) {
				Map<String, String> propertyMap = new HashMap<String, String>();
				Map<String, String> methodMap = new HashMap<String, String>();
				propertyMap.put("col", cols[i]);
				propertyMap.put("colName", BeanConvertUtil.toLowerCaseFirstOne(colnames[i]));
				propertyMap.put("colType", propertyType[i]);
				propertyMap.put("comment", commentlist.get(i));
				propertyMapList.add(propertyMap);
				
				methodMap.put("colType", propertyType[i]);
				methodMap.put("colName", BeanConvertUtil.toLowerCaseFirstOne(colnames[i]));
				methodMap.put("colNameUp", BeanConvertUtil.initcap(colnames[i]));//首字母大写
				methodMapList.add(methodMap);
			}
			dataMap.put("tableName", tablename);
			dataMap.put("entityName", entityName);
			dataMap.put("entityNameLower", BeanConvertUtil.toLowerCaseFirstOne(entityName));//首字母小写的实体名
			dataMap.put("propertyMapList", propertyMapList);
			dataMap.put("methodMapList", methodMapList);
			dataMap.put("importList", importList);
			dataMap.put("ctx", "${ctx}");
			dataMap.put("contextPath", "${pageContext.request.contextPath}");
			dataMap.put("project",project);
			dataMap.put("datetime", Constant.SDF.format(new Date()));
			return dataMap;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
	
	//首字母转大写
	public static String toUpperCaseFirstOne(String s){
	  if(Character.isUpperCase(s.charAt(0)))
	    return s;
	  else
	    return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
	}
	
	
	/**
	 * 
	 * @Description: 获取数据库字段类型对应的java类型
	 * @param sqlType
	 * @return   
	 * @return String 
	 * @throws
	 * @author tyf
	 * @date 2017年11月15日
	 */
	private static String sqlType2JavaType(String sqlType) {
		if (sqlType.equalsIgnoreCase("bit")) {
			return "Boolean";
		} else if (sqlType.equalsIgnoreCase("tinyint")) {
			return "Integer";
		} else if (sqlType.equalsIgnoreCase("smallint")) {
			return "Integer";
		} else if (sqlType.equalsIgnoreCase("int")) {
			return "Integer";
		} else if (sqlType.equalsIgnoreCase("bigint")) {
			return "Long";
		} else if (sqlType.equalsIgnoreCase("float")) {
			return "Float";
		} else if (sqlType.equalsIgnoreCase("decimal") || sqlType.equalsIgnoreCase("numeric") || sqlType.equalsIgnoreCase("real") || sqlType.equalsIgnoreCase("double")) {
			return "Double";
		} else if (sqlType.equalsIgnoreCase("money") || sqlType.equalsIgnoreCase("smallmoney")) {
			return "Double";
		} else if (sqlType.equalsIgnoreCase("varchar") || sqlType.equalsIgnoreCase("char") || sqlType.equalsIgnoreCase("nvarchar") || sqlType.equalsIgnoreCase("nchar")) {
			return "String";
		} else if (sqlType.equalsIgnoreCase("datetime")) {
			return "Date";
		} else if (sqlType.equalsIgnoreCase("date")) {
			return "String";
		} else if(sqlType.equalsIgnoreCase("varbinary") || sqlType.equalsIgnoreCase("longblob")){
			return "Byte[]";
		}

		else if (sqlType.equalsIgnoreCase("image")) {
			return "Blob";
		} else if (sqlType.equalsIgnoreCase("text")) {
			return "Clob";
		}
		return null;
	}
	public static void main(String[] args) {
		String url = "jdbc:mysql://192.168.30.202:3306/nssa";
		
		System.out.println(url.substring(url.lastIndexOf("/")+1));  
		
	}
	
}
