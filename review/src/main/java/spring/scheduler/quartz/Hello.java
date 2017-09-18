package spring.scheduler.quartz;

import java.util.Calendar;

public class Hello {
	
	public void print() {
		Calendar date = Calendar.getInstance();
		String stamp = date.get(Calendar.HOUR_OF_DAY)+":"
					+ date.get(Calendar.MINUTE)+":"
					+ date.get(Calendar.SECOND)+":"
					+ date.get(Calendar.MILLISECOND);
		
		System.out.println(stamp + " " + "Generating report");
	}

}
