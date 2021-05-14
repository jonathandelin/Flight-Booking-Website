package common_things;

public class LegNode {
	public String flightNum;
	public String d_airport;
	public String a_airport;
	public String d_time;
	public String a_time;
	public int fare;
	public LegNode next;
	public LegNode(String flightNum, String d_airport, String a_airport, String d_time,String a_time,int fare,LegNode next){
		this.flightNum=flightNum;
		this.d_airport=d_airport;
		this.a_airport=a_airport;
		this.d_time=d_time;
		this.a_time=a_time;
		this.fare=fare;
		this.next=next;
	}
}
