package com.yi.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Component // 일반 class중 bean으로 인식시키고 싶은 것에 붙임
@Aspect //aop전용 클래스다
public class SampleAdvice {
	
	@Before("execution(* com.yi.service.ReplyService.insert(..))")
	public void startLog(JoinPoint jp) {
		System.out.println("=================================");
		System.out.println("[startLog] ===========");
		System.out.println("=================================");		
	}
//	@Around("execution(* com.yi.service.ReplyService.listPage(..))")
//	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable {
//		long startTime = System.currentTimeMillis();
//		System.out.println("=================================");
//		System.out.println("[timeLog] START");
//		System.out.println(Arrays.toString(pjp.getArgs()));
//		System.out.println("=================================");
//		
//		Object result = pjp.proceed(); // around 실행 함수(Point 프록시?
//		
//		long endTime = System.currentTimeMillis();
//		System.out.println("=================================");
//		System.out.println(pjp.getSignature().getName() + ":" + (endTime - startTime));
//		System.out.println("[timeLog] END");
//		System.out.println("=================================");
//		
//		return result;
//	}
	
	
	@Around("execution(* com.yi.service.ReplyService.listPageTest(..))")
	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable {
		long startTime = System.currentTimeMillis();
		System.out.println("=================================");
		System.out.println("[timeLog] START");
		System.out.println(Arrays.toString(pjp.getArgs()));
		System.out.println("=================================");
		
		Object result = pjp.proceed(); // around 실행 함수(Point 프록시?
		
		long endTime = System.currentTimeMillis();
		System.out.println("=================================");
		System.out.println(pjp.getSignature().getName() + ":" + (endTime - startTime));
		System.out.println("[timeLog] END");
		System.out.println("=================================");
		
		return result;
	}	
}
