package com.yi.ex02;


import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class DataSourceTest {
	
	@Autowired // spring container 안에 DataSource type을 가진 singleton을 자동 주입시킴
	private DataSource ds;
	
	@Test
	public void testDs() {
		System.out.println("ds값 : " + ds); //org.springframework.jdbc.datasource.DriverManagerDataSource@20140db9
	}
	
	
	@Test
	public void testConnection() {
		try(Connection con = ds.getConnection()){
			System.out.println("con값 : "+con); //com.mysql.jdbc.JDBC4Connection@2794eab6
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
