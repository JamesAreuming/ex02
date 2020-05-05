package com.yi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.yi.util.UploadFileUtils;

@Controller
public class UploadController {
	private String innerUploadPath = "/resources/upload";
	
	// cf. @Autowired // 클래스 명에 맞춰 주입시킴
	@Resource(name="uploadPath") // 널리쓰이는 경우는 id명으로 주입시킴 : <beans:bean id="uploadPath" class="java.lang.String">
	private String uploadPath;
	
	@RequestMapping(value="inUp", method = RequestMethod.GET)
	public String upload() {
		return "innerUploadForm";
	}
	
	//파일한개
	@RequestMapping(value="inUp", method = RequestMethod.POST)
	public String uploadResult(String test, MultipartFile file, HttpServletRequest request, Model model) throws IOException {
		System.out.println("test : " + test);
		System.out.println("file : " + file);
		System.out.println(file.getOriginalFilename());
		System.out.println(file.getSize());
		
		String root = request.getSession().getServletContext().getRealPath("/");
		
		File dir = new File(root+innerUploadPath); //resources아래에 upload폴더
		                                               //* resources아래 js, css 폴더
		
		if(dir.exists() == false) { //upload폴더가 없다면
			dir.mkdir(); //upload 폴더만들기
		}
		
		//파일 넣기
		UUID uid = UUID.randomUUID(); //중복되지 않는 고유한 키값을 반환함
		String savedName = uid.toString() + "_" + file.getOriginalFilename(); //중복되지 않게 이름 맞춤 : 5ad4ad49-ef72-448e-9acc-7605f4eaa5a8_areuming
		File target = new File(root + innerUploadPath+"/" + savedName);
		FileCopyUtils.copy(file.getBytes(), target); //서버 upload폴더 안에 파일이 생성됨
		
		//파일이름, jsp에 값을 보낼려면 - Model model
		model.addAttribute("test", test);
		model.addAttribute("file", savedName);
		return "innerUploadResult";
	}
	
	//파일여러개
	@RequestMapping(value="inMultiUp", method = RequestMethod.GET)
	public String uploadMulti() {
		return "innerMultiUploadForm";
	}
	
	@RequestMapping(value="inMultiUp", method = RequestMethod.POST)
	public String uploadMultiResult(String test, List<MultipartFile> files, HttpServletRequest request, Model model) throws IOException {
		System.out.println("test : " + test);
		
		for(MultipartFile file : files) {
			//System.out.println(file.getOriginalFilename());
			//System.out.println(file.getSize());
		}
		
		String root = request.getSession().getServletContext().getRealPath("/");
		
		File dir = new File(root+innerUploadPath+"/"); //resources아래에 upload폴더
		                                               //* resources아래 js, css 폴더
		
		if(dir.exists() == false) { //upload폴더가 없다면
			dir.mkdir(); //upload 폴더만들기
		}
		
		//이미지 여러개 업로드
		List<String> fileList = new ArrayList<String>();
		for(MultipartFile file : files) {
			//파일 넣기
			UUID uid = UUID.randomUUID(); //중복되지 않는 고유한 키값을 반환함
			String savedName = uid.toString() + "_" + file.getOriginalFilename(); //중복되지 않게 이름 맞춤 : 5ad4ad49-ef72-448e-9acc-7605f4eaa5a8_areuming
			File target = new File(root + innerUploadPath+"/"+ savedName); //innerUploadForm + "/"
			FileCopyUtils.copy(file.getBytes(), target); //서버 upload폴더 안에 파일이 생성됨
			
			fileList.add(savedName);
		}

		
		//파일이름, jsp에 값을 보낼려면 - Model model
		model.addAttribute("test", test);
		model.addAttribute("fileList", fileList);		


		return "innerMultiUploadResult";
	}
	
	
	//c드라이브(서버밖에 파일) - 외부저장(파일한개)
	@RequestMapping(value="outUp", method = RequestMethod.GET)
	public String outUpload() {
		return "outUploadFile";
	}
	
	@RequestMapping(value="outUp", method = RequestMethod.POST)
	public String outUploadResult(String test, MultipartFile file, Model  model) throws IOException {
		
		//c드라이브 
		//String uploadPath = "c:/zzz/upload/";
		String savedName = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
		
//클래스로 따로 뺌 - UploadFileUtils
//		File dir = new File(uploadPath); 
//		if(dir.exists() == false) { //upload폴더가 없다면
//			dir.mkdir(); //upload 폴더만들기
//		}
//		
//		//년,월,일
//		
//		UUID uid = UUID.randomUUID(); //중복되지 않는 고유한 키값을 반환함
//		String savedName = uid.toString() + "_" + file.getOriginalFilename(); //중복되지 않게 이름 맞춤 : 5ad4ad49-ef72-448e-9acc-7605f4eaa5a8_areuming
//		File target = new File(uploadPath +"/"+ savedName); 
//		FileCopyUtils.copy(file.getBytes(), target); //서버 upload폴더 안에 파일이 생성됨
		
		model.addAttribute("test", test);
		model.addAttribute("file", savedName);	
		
		return "outUploadFileResult";
	}
	
	//아작스처리
	@ResponseBody
	@RequestMapping(value="displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String filename){
		ResponseEntity<byte[]> entity = null;
		
		//System.out.println("displayFile------" + filename);
		
		InputStream in = null;
		try {
			in = new FileInputStream(uploadPath+filename);
			
			//while문 처리 없이 IOUtils.toByteArray(in)
			
			String format = filename.substring(filename.lastIndexOf(".")+1); //확장자 뽑아내기
			MediaType mType = null;
			if (format.equalsIgnoreCase("png")) {
				mType = MediaType.IMAGE_PNG;
			}else if(format.equalsIgnoreCase("jpg") || format.equalsIgnoreCase("jpeg")){
				mType = MediaType.IMAGE_JPEG;
			}else if(format.equalsIgnoreCase("gif")){
				mType = MediaType.IMAGE_GIF;
			}else {
				//mType = MediaType.T
			}
			
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mType);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.OK);
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="drag", method = RequestMethod.GET)
	public String dragUpload() {
		return "dragUploadFile";
	}
	
	@ResponseBody
	@RequestMapping(value="drag", method = RequestMethod.POST)
	public ResponseEntity<List<Map<String, String>>> dragResult(String test, List<MultipartFile> files) throws IOException {
		ResponseEntity<List<Map<String, String>>> entity = null;
		//System.out.println("test : " + test);
		for(MultipartFile file:files) {
			//System.out.println("파일명 : "+file.getOriginalFilename()+"파일사이즈 : "+file.getSize());
		}
		
		//폴더만들기
		//String uploadPath = "c:/zzz/upload/";
		
		File dir = new File(uploadPath); 
		if(dir.exists() == false) { //upload폴더가 없다면
			dir.mkdir(); //upload 폴더만들기
		}
		
		try {
			//업로드처리(여러개)
			List<Map<String, String>> fileList = new ArrayList<Map<String, String>>();
			for(MultipartFile file : files) {
				UUID uid = UUID.randomUUID(); //중복되지 않는 고유한 키값을 반환함
				String savedName = uid.toString() + "_" + file.getOriginalFilename(); //중복되지 않게 이름 맞춤 : 5ad4ad49-ef72-448e-9acc-7605f4eaa5a8_areuming
				File target = new File(uploadPath +"/"+ savedName); 
				FileCopyUtils.copy(file.getBytes(), target); //서버 upload폴더 안에 파일이 생성됨
				Map<String, String> map = new HashMap<String, String>();
				map.put("file", savedName);
				fileList.add(map);
			}
			entity = new ResponseEntity<List<Map<String, String>>>(fileList, HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Map<String, String>>>(HttpStatus.OK);
		}


		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="deleteFile", method = RequestMethod.GET)
	public ResponseEntity<String> deleteFile(String filename){
		ResponseEntity<String> entity = null;
		
		System.out.println(filename);
		try {
			//file 삭제
			File file = new File(uploadPath + filename);
			
			System.out.println(filename);
			file.delete();
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e){
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="outUp2", method = RequestMethod.GET)
	public String outUpMultiload() {
		return "outMultiUploadFile";
	}
	
	@RequestMapping(value="outUp2", method = RequestMethod.POST)
	public String outUpMultiloadResult(String test, List<MultipartFile> files, Model  model) throws IOException {
		
		System.out.println("test------ : " + test);
		System.out.println("MultipartFile------ : " + files.toString());
		
		for(MultipartFile file : files) {
			System.out.println(file.getOriginalFilename());
			System.out.println(file.getSize());
		}
		
		
		
		List<String> fileList = new ArrayList<String>();
		for(MultipartFile file : files) {
			String savedName = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
			fileList.add(savedName);
		}
		
		model.addAttribute("test", test);
		model.addAttribute("fileList", fileList);	
		
		return "outMultiUploadFileResult";
	}
	
}
