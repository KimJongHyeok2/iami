package com.web.iami.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.web.iami.domain.ImageDTO;

@RestController
@RequestMapping("/upload")
public class RestUploadController {

	@PostMapping("/thumbnail")
	public ImageDTO thumbnail(HttpServletRequest request) {
		
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload");
		int maxPostSize = 10 * 1024 * 1024;
		String encoding = "UTF-8";
		FileRenamePolicy policy = new DefaultFileRenamePolicy();
		ImageDTO dto = new ImageDTO();
		
		File file = new File(saveDirectory);
		
		if(!file.isDirectory()) {
			file.mkdirs();
		}
		
		try {
			MultipartRequest multi = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			Enumeration<String> names = multi.getFileNames();
			String FileSystemName = null;
			while(names.hasMoreElements()) {
				String name = names.nextElement();
				FileSystemName = multi.getFilesystemName(name);
			}
			
			dto.setUploaded(true);
			dto.setUrl(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/resources/upload/" + FileSystemName);
			dto.setName(FileSystemName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
}
