package com.yi.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.yi.domain.SampleVO;

@RestController //data만 전송하는 controller(화면은 없음)  --- 댓글의 경우 화면의 전환이 없이 바로 그 화면에서 처리 / 데이터 전용 컨트롤러만 사용할때 사용
@RequestMapping("/sample/")
public class SampleController {

	
	@RequestMapping(value = "hello", method = RequestMethod.GET)
	public String sayHello() { //화면아닌 데이터(글자만) 가겠다 --  @ResponseBody
		return "Hello world";
	}
	
//	@ResponseBody // - 제이슨 스트링으로 보낼때 // 일반컨트롤러와, 제이슨 컨트롤러 섞일 경우 사용
	@RequestMapping(value = "sendVO", method = RequestMethod.GET)
	public SampleVO sendVO() {
		SampleVO vo = new SampleVO();
		vo.setNo(1);
		vo.setFirstName("아름");
		vo.setLastName("정");
		
		return vo;
	}

	@RequestMapping(value = "sendList", method = RequestMethod.GET)
	public List<SampleVO> sendList(){
		List<SampleVO> list  = new ArrayList<>();
		
		for(int i = 1;i<50;i++) {
			SampleVO vo = new SampleVO();
			vo.setNo(i);
			vo.setFirstName("아름"+i);
			vo.setLastName("정"+i);
			list.add(vo);
		}
		return list;	
	}
	
	@RequestMapping(value = "sendAuth", method = RequestMethod.GET)
	public ResponseEntity<String> sendAuth(){
		ResponseEntity<String> entity = new ResponseEntity<>("hello", HttpStatus.OK);
		return entity;
	}
	
	
	@RequestMapping(value = "sendListAuth", method = RequestMethod.GET)
	public ResponseEntity<List<SampleVO>> sendListAuth(){
		List<SampleVO> list  = new ArrayList<>();
		
		for(int i = 1;i<50;i++) {
			SampleVO vo = new SampleVO();
			vo.setNo(i);
			vo.setFirstName("아름"+i);
			vo.setLastName("정"+i);
			list.add(vo);
		}
		
		ResponseEntity<List<SampleVO>> listEntity = new ResponseEntity<List<SampleVO>>(list,HttpStatus.NOT_FOUND);
		
		return listEntity;
	}
}
