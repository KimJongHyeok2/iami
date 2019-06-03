package com.web.iami.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.web.iami.domain.ImageDTO;
import com.web.iami.service.MemberService;

@RestController
@RequestMapping("/upload")
public class RestUploadController {

	@Inject
	private MemberService memberService;
	
	// 포트폴리오 섬네일 업로드
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
	
	// 회원 프로필 사진 업로드
	@PostMapping("/profile")
	public ImageDTO profile(HttpServletRequest request) {
		
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
			
			dto.setUrl(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/resources/upload/" + FileSystemName);
			dto.setName(FileSystemName);
			
			int mem_no = 0;
			
			if(multi.getParameter("mem_no") != null) {
				mem_no = Integer.parseInt(multi.getParameter("mem_no")); 
			}
			
			if(mem_no != 0) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("no", String.valueOf(mem_no));
				map.put("profile", FileSystemName);
				
				int count = memberService.updateMemberProfile(map);
				if(count == 1) {
					request.getSession().setAttribute("mem_profile", FileSystemName);
					dto.setUploaded(true);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 공지사항 이미지 업로드
	@PostMapping("/notice/image")
	public ImageDTO noticeImage(HttpServletRequest request) {
		
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload");
		int maxPostSize = 10 * 1024 * 1024;
		String encoding = "UTF-8";
		FileRenamePolicy policy = new DefaultFileRenamePolicy();
		ImageDTO dto = new ImageDTO();
		
		try {
			MultipartRequest multi = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			
			Enumeration<String> enums = multi.getFileNames();
			while(enums.hasMoreElements()) {
				String name = enums.nextElement();
				String value = multi.getFilesystemName(name);
				
				dto.setUrl(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/resources/upload/" + value);
				dto.setName(value);
				dto.setUploaded(true);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
}
