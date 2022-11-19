package com.example.util;

import com.example.bean.BoardVO;
import com.example.dao.BoardDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy; // 파일 이름이 같을 때 알아서 뒤에 123숫자 붙여주는 기능

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;

import java.util.Date;

public class FileUpload {
    public BoardVO uploadPhoto(HttpServletRequest request){
        String filename="";
        int sizeLimit= 15 * 1024 * 1024; //15MB

        String realPath = request.getServletContext().getRealPath("upload"); // upload폴더에서 경로를 얻음
        //System.out.println(realPath); //이건 어떻게 확인하는 거지..

        File dir = new File(realPath);
        if(!dir.exists()) dir.mkdirs();

        BoardVO one = null;
        MultipartRequest multipartRequest = null;
        try{
            multipartRequest = new MultipartRequest(request, realPath, sizeLimit,
                    "utf-8", new DefaultFileRenamePolicy());
            filename = multipartRequest.getFilesystemName("photo");
            one = new BoardVO();
            String seq = multipartRequest.getParameter("seq");
            if(seq != null && !seq.equals("")) { // seq가 있는 경우 = 수정할 때
                one.setSeq(Integer.parseInt(seq));
            }
            one.setCategory(multipartRequest.getParameter("category"));
            one.setTitle(multipartRequest.getParameter("title"));
            one.setWriter(multipartRequest.getParameter("writer"));
            one.setContent(multipartRequest.getParameter("content"));
            //one.setRegdate(multipartRequest.getParameter("regdate")); //추가든 수정이든 등록일은 입력받지 않기 때문에 필요 x
            //one.setCnt(Integer.parseInt(multipartRequest.getParameter("cnt")));

            if(seq != null && !seq.equals("")){
                BoardDAO dao = new BoardDAO();
                String oldfilename = dao.getPhotoFileName(Integer.parseInt(seq));
                if(filename != null & oldfilename != null)
                    FileUpload.deleteFile(request, oldfilename);
                else if(filename == null && oldfilename != null)
                    filename = oldfilename;
            }
            one.setPhoto(filename);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return one;
    }

    public static void deleteFile(HttpServletRequest request, String filename){
        String filePath = request.getServletContext().getRealPath("upload");
        File f = new File(filePath + "/" + filename);
        if (f.exists()) f.delete();
    }


}
