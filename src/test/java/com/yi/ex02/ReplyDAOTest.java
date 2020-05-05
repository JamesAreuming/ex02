package com.yi.ex02;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import com.yi.domain.ReplyVO;
import com.yi.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ReplyDAOTest {

	@Autowired
	public ReplyDAO dao;
	
	@Test
	public void testDao() {
		System.out.println(dao);
	}
	
	@Test
	public void testInsert() throws Exception {
		ReplyVO vo = new ReplyVO();
		vo.setBno(521); // 최신번호
		vo.setReplyer("user01");
		vo.setReplytext("댓글을 test해 봅니다.");
		dao.insert(vo);
	}
	
	@Test
	public void testList() throws Exception {
		dao.list(521);
	}
	
	//@Test
	public void testUpdate() throws Exception {
		ReplyVO vo = new ReplyVO();
		vo.setRno(3);
		vo.setReplytext("수정");
		vo.setUpdatedate(new Date());
		dao.update(vo);		
	}
	
	//@Test
	public void testDelete() throws Exception {
		dao.delete(2);
	}
}
