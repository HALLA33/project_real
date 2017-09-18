package spring.scheduler.quartz;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * Created by red on 2014. 10. 27..
 */
public class MyJobBean extends QuartzJobBean {

    private Hello hello;
    private Visit visit;
    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        visit.Visitstatus();
    }

    public void setHello(Hello hello){
        this.hello = hello;
    }
	public void setVisit(Visit visit) {
		this.visit = visit;
	}
}