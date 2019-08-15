package com.tyf.mycoder.controller;

import com.alibaba.fastjson.JSONArray;
import com.tyf.mycoder.utils.ConnectionUtil;
import com.tyf.mycoder.utils.Constant;
import com.tyf.mycoder.utils.FreemarkUtil;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("codemaker")
public class CodeController {

    @RequestMapping("/")
    public String toCoder(){
        return "codemaker";
    }
    @RequestMapping(value = "/codemakeFunction", method = RequestMethod.POST)
    public void codemakeFunction(HttpServletRequest request, HttpServletResponse response) {

        String databaseType = request.getParameter("databaseType");
        String databaseIp = request.getParameter("databaseIp");
        String databaseName = request.getParameter("databaseName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Integer databaseType_int = Integer.parseInt(databaseType);
        if (databaseType_int == Constant.MYSQL) {
            ConnectionUtil.driver = Constant.MYSQL_DRIVER;
            ConnectionUtil.url = Constant.MYSQL_URL1 + databaseIp + Constant.MYSQL_URL2 + databaseName;
        } else if (databaseType_int == Constant.SQL_SERVER) {
            ConnectionUtil.driver = Constant.SQL_SERVER_DRIVER;
            ConnectionUtil.url = Constant.SQL_SERVER_URL1 + databaseIp + Constant.SQL_SERVER_URL2 + databaseName;
        }
        ConnectionUtil.user = username;
        ConnectionUtil.pwd = password;
        List<String> list = ConnectionUtil.getAllTableNames(databaseName);
        String json = JSONArray.toJSONString(list);
        try {
            response.getWriter().print(json);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/createFiles", method = RequestMethod.POST)
    public void createFiles(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int flag = 1;
        String tables = request.getParameter("tables");
        String fileTypes = request.getParameter("fileTypes");
        String project = request.getParameter("project");
        String savedir = request.getParameter("savedir");

        Resource resource = new ClassPathResource("static/ftl/controller.ftl");
        File file = resource.getFile();
        String ftlPath = request.getSession().getServletContext().getRealPath("").replace("codemaker/createFiles", "")
                + "asset/ftl";
        FreemarkUtil.loadTemplateFile = file.getParentFile();
        FreemarkUtil.basePath = ftlPath;
        ConnectionUtil.project = project;
        FreemarkUtil.saveDir = savedir;
        List<String> tableList = new ArrayList<String>();

        String[] tempTables = tables.split(", ");

        for (String string : tempTables) {
            tableList.add(string);
        }
        List<String> fileTypeList = Arrays.asList(fileTypes.split(","));
        fileTypeList.forEach(type -> changeFlag(Integer.parseInt(type)));
        tableList.forEach(table -> createFileByTableName(table.trim(), fileTypeList));
        System.out.println("生成完毕!");
        /*
         * System.out.println("准备打包!");
         *
         * String path = FreemarkUtil.saveDir;
         *
         * for (String table : tableList) {//复制到一个文件夹下 try {
         * FileUtil.copyDir(path+"/"+table, path+"/zip");
         * FileUtil.delAllFile(path+"/"+table); } catch (IOException e) { //
         * TODO Auto-generated catch block e.printStackTrace(); } } String
         * zipName = "code"+System.currentTimeMillis()+".zip";
         * FileToZIP.createZip(path+"/zip", path+"/"+zipName);//压缩
         * System.out.println("打包完毕!"); FileUtil.delAllFile(path+"/zip");
         * System.out.println("清空临时文件!"); System.out.println("输出文件!"); File
         * zipFile = new File(path+"/"+zipName); try { if (zipFile.exists()) {
         * response.setHeader("Content-Disposition", "attachment;filename=" +
         * new String((zipName).getBytes(), "iso-8859-1"));// 设置在下载框默认显示的文件名
         * response.setContentType("application/octet-stream");//
         * 指明response的返回对象是文件流 // 读出文件到response // 这里是先需要把要把文件内容先读到缓冲区 //
         * 再把缓冲区的内容写到response的输出流供用户下载 FileInputStream fileInputStream = new
         * FileInputStream(zipFile); BufferedInputStream bufferedInputStream =
         * new BufferedInputStream(fileInputStream); byte[] b = new
         * byte[bufferedInputStream.available()]; bufferedInputStream.read(b);
         * OutputStream outputStream = response.getOutputStream();
         * outputStream.write(b); // 人走带门 bufferedInputStream.close();
         * outputStream.flush(); outputStream.close(); } } catch (IOException e)
         * { e.printStackTrace(); }
         */
        FreemarkUtil.entity_flag = false;
        FreemarkUtil.controller_flag = false;
        FreemarkUtil.service_flag = false;
        FreemarkUtil.dao_flag = false;
        FreemarkUtil.js_flag = false;
        FreemarkUtil.jsp_flag = false;

        response.getWriter().print(flag);
    }

    private void changeFlag(Integer type) {
        switch (type) {
            case Constant.ENTITY:
                FreemarkUtil.entity_flag = true;
                break;
            case Constant.CONTROLLER:
                FreemarkUtil.controller_flag = true;
                break;
            case Constant.SERVICE:
                FreemarkUtil.service_flag = true;
                break;
            case Constant.DAO:
                FreemarkUtil.dao_flag = true;
                break;
            case Constant.JS:
                FreemarkUtil.js_flag = true;
                break;
            case Constant.JSP:
                FreemarkUtil.jsp_flag = true;
                break;
            default:
                break;
        }
    }

    private void createFileByTableName(String name, List<String> fileTypeList) {

        if (name.indexOf(" ") != -1) {
            name = name.replace(" ", "");
        }

        ConnectionUtil.tablename = name;
        FreemarkUtil.genateCode();
    }

}
