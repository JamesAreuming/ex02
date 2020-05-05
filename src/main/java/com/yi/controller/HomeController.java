package com.yi.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.yi.service.ReplyService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	ReplyService service;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value="replyTest", method = RequestMethod.GET)
	public String replyTest() {
		return "replyTest";
	}
	
	
	@RequestMapping(value="temp1", method = RequestMethod.GET)
	public String temp1() {
		return "handlebars1";
	}
	
	@RequestMapping(value="temp2", method = RequestMethod.GET)
	public String temp2() {
		return "handlebars2";
	}		
	
	
	@RequestMapping(value="temp3", method = RequestMethod.GET)
	public String temp3() {
		return "handlebars3";
	}		
	
//	@RequestMapping(value="upload", method = RequestMethod.GET)
//	public String upload() {
//		return "innerUploadForm";
//	}
//	
//	@RequestMapping(value="upload", method = RequestMethod.POST)
//	public String uploadResult(String test, MultipartFile file) {
//		System.out.println("test : " + test);
//		System.out.println("file : " + file);
//		System.out.println(file.getOriginalFilename());
//		System.out.println(file.getSize());
//		return "";
//	}
	
}
