package spring.scheduler.quartz;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * Created by red on 2014. 10. 27..
 */
public class MyJobBean extends QuartzJobBean {

    private Hello hello;
    private Flag flag;
    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
    	flag.status();
    	flag.reset();
    }

    public void setHello(Hello hello){
        this.hello = hello;
    }
	public void setFlag(Flag flag) {
		this.flag = flag;
	}
}