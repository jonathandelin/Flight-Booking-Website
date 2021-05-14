<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="common_things.LegNode"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.lang.Math"%>

<%!
public int changeFare(int currentF, int stop, String departure, String flight_num , int passengers){
	Date depart;
	double temp=currentF*(100-(stop-1)*2)*passengers/100;
	try{
		depart=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(departure);
	}catch(Exception e){
		return (int)temp;
	}
	Date date = Calendar.getInstance().getTime();
	long diff=depart.getTime()-date.getTime();
	diff=diff/(24*60*60);
	double factor=1;
	if(diff>3 && diff<=7){factor=0.95;}
	else if(diff>7&& diff<=14){factor=0.9;}
	else if(diff>14 && diff<=21){factor=0.85;}
	else if(diff>21){factor=0.8;}
	
	return (int) (factor*temp)+30*passengers;
}

%>>
<%
ArrayList<LegNode> multipleS1 = (ArrayList<LegNode>)session.getAttribute("multipleS1");
ArrayList<LegNode> multipleS2 = (ArrayList<LegNode>)session.getAttribute("multipleS2");
String userName=(String)session.getAttribute("userName");


String Fflightnum = request.getParameter("Fflightnum");
String FDeparture = request.getParameter("FDeparture");

int Findex=-1;
int Fpassengers=1;
String temp=request.getParameter("Findex");
if(temp.length()>=1){Findex = Integer.parseInt(request.getParameter("Findex"));}
temp=request.getParameter("Fpassengers");
if(temp.length()>=1){Fpassengers = Integer.parseInt(request.getParameter("Fpassengers"));}
String FClass = request.getParameter("FClass");
String Sflightnum = request.getParameter("Sflightnum");
String SDeparture = request.getParameter("SDeparture");
int Sindex=-1;
int Spassengers=1;
temp=request.getParameter("Sindex");
if(temp.length()>=1){Sindex = Integer.parseInt(request.getParameter("Sindex"));}
temp=request.getParameter("Spassengers");
if(temp.length()>=1){Spassengers = Integer.parseInt(request.getParameter("Spassengers"));}
String SClass = request.getParameter("SClass");
Random rand=new Random();


if(Findex==-1){//non-stop, call leg directly
	
	try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");

	PreparedStatement leginfo = con.prepareStatement("SELECT L.seat, L.fare FROM loginschema.legs L WHERE L.flight_num=? AND timediff(?, L.departure)=0 AND L.seat-?>=0;");
	leginfo.setString(1, Fflightnum);
	leginfo.setString(2, FDeparture);
	leginfo.setInt(3, Fpassengers);
	ResultSet resuleg = leginfo.executeQuery();
	
	if(resuleg.next()){
		int seat=resuleg.getInt("seat");
		int fare=resuleg.getInt("fare");
		int res_num=rand.nextInt(10000);
		fare=changeFare(fare, 1, FDeparture, Fflightnum, Fpassengers);
		
		//update reservation
				PreparedStatement ps2 =  con.prepareStatement("INSERT INTO `loginschema`.`reservations` (`res_num`, `login`, `bookingfee`, `passengers`, `date`, `total_fare`, `booked_flightnum`, `booking_date`) VALUES (?, ?, '30', ?, date(?), ?, ?, curdate());");
				ps2.setInt(1, res_num);
				ps2.setString(2, userName);
				ps2.setInt(3, Fpassengers);
				ps2.setString(4, FDeparture);
				ps2.setInt(5, fare);
				ps2.setString(6, Fflightnum);
				ps2.executeUpdate();
				//update leg_reservation
				PreparedStatement ps = con.prepareStatement("INSERT INTO `loginschema`.`reserved_legs` (`res_numR`, `flight_numR`, `class`, `departure`) VALUES (?, ?, ?, ?);");
				ps.setInt(1, res_num);
				ps.setString(2, Fflightnum);
				ps.setString(3, FClass);
				ps.setString(4, FDeparture);
				ps.executeUpdate();
				//update legs--change the seat
				PreparedStatement ps3 =  con.prepareStatement("UPDATE `loginschema`.`legs` SET `seat` = ? WHERE (`flight_num` = ?) and (`departure` = ?);");
				ps3.setInt(1, seat-Fpassengers);
				ps3.setString(2, Fflightnum);
				ps3.setString(3, FDeparture);
				ps3.executeUpdate();
	}
	}catch(Exception e){
		out.print(e);
	}
}else{
	//multiple stop, use arraylist
	LegNode ptr=multipleS1.get(Findex);
	Fflightnum=ptr.flightNum;
	FDeparture=ptr.d_time;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");

		PreparedStatement leginfo = con.prepareStatement("SELECT L.seat, L.fare FROM loginschema.legs L WHERE L.flight_num=? AND timediff(?, L.departure)=0 AND L.seat-?>=0;");
		leginfo.setString(1, Fflightnum);
		leginfo.setString(2, FDeparture);
		leginfo.setInt(3, Fpassengers);
		ResultSet resuleg = leginfo.executeQuery();
		
		if(resuleg.next()){
			int fare=0;
			int res_num=rand.nextInt(10000);
			int numLeg=0;
			
			
			//update reservation
			PreparedStatement ps2 =  con.prepareStatement("INSERT INTO `loginschema`.`reservations` (`res_num`, `login`, `bookingfee`, `passengers`, `date`, `total_fare`, `booked_flightnum`, `booking_date`) VALUES (?, ?, '30', ?, date(?), ?, ?, curdate());");
			ps2.setInt(1, res_num);
			ps2.setString(2, userName);
			ps2.setInt(3, Fpassengers);
			ps2.setString(4, FDeparture);
			ps2.setInt(5, fare);
			ps2.setString(6, Fflightnum);
			ps2.executeUpdate();
			//change fare later
			while(ptr!=null){
				//get required info
				Fflightnum=ptr.flightNum;
				FDeparture=ptr.d_time;
				
				leginfo = con.prepareStatement("SELECT L.seat, L.fare FROM loginschema.legs L WHERE L.flight_num=? AND timediff(?, L.departure)=0 AND L.seat-?>=0;");
				leginfo.setString(1, Fflightnum);
				leginfo.setString(2, FDeparture);
				leginfo.setInt(3, Fpassengers);
				resuleg = leginfo.executeQuery();
				
			if(resuleg.next()){	
				int seat=resuleg.getInt("seat");
				fare+=resuleg.getInt("fare");
				
				numLeg++;
			//update leg_reservation
			PreparedStatement ps = con.prepareStatement("INSERT INTO `loginschema`.`reserved_legs` (`res_numR`, `flight_numR`, `class`, `departure`) VALUES (?, ?, ?, ?);");
			ps.setInt(1, res_num);
			ps.setString(2, Fflightnum);
			ps.setString(3, FClass);
			ps.setString(4, FDeparture);
			ps.executeUpdate();
			//update legs--change the seat
			PreparedStatement ps3 =  con.prepareStatement("UPDATE `loginschema`.`legs` SET `seat` = ? WHERE (`flight_num` = ?) and (`departure` = ?);");
			ps3.setInt(1, seat-Fpassengers);
			ps3.setString(2, Fflightnum);
			ps3.setString(3, FDeparture);
			ps3.executeUpdate();
			}
			ptr=ptr.next;
			}
			fare=changeFare(fare, numLeg, FDeparture, Fflightnum, Fpassengers );
			
			PreparedStatement ps4 = con.prepareStatement("UPDATE `loginschema`.`reservations` SET `date` = date(?), `total_fare` = ?, `booked_flightnum` = ? WHERE (`res_num` = ?);");
			ps4.setString(1, FDeparture);
			ps4.setInt(2, fare);
			ps4.setString(3, Fflightnum);
			ps4.setInt(4, res_num);
			ps4.executeUpdate();
			
		}
		}catch(Exception e){
			out.print(e);
		}
	
	
}

//round trip--just copy what you have above
if(Sindex!=-1||Sflightnum.length()>0){
	if(Sindex==-1){//non-stop, call leg directly
		
		try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");

		PreparedStatement leginfo = con.prepareStatement("SELECT L.seat, L.fare FROM loginschema.legs L WHERE L.flight_num=? AND timediff(?, L.departure)=0 AND L.seat-?>=0;");
		leginfo.setString(1, Sflightnum);
		leginfo.setString(2, SDeparture);
		leginfo.setInt(3, Spassengers);
		ResultSet resuleg = leginfo.executeQuery();
		
		if(resuleg.next()){
			int seat=resuleg.getInt("seat");
			int fare=resuleg.getInt("fare");
			int res_num=rand.nextInt(10000);
			fare=changeFare(fare, 1, SDeparture, Sflightnum, Spassengers);
			
			//update reservation
					PreparedStatement ps2 =  con.prepareStatement("INSERT INTO `loginschema`.`reservations` (`res_num`, `login`, `bookingfee`, `passengers`, `date`, `total_fare`, `booked_flightnum`, `booking_date`) VALUES (?, ?, '30', ?, date(?), ?, ?, curdate());");
					ps2.setInt(1, res_num);
					ps2.setString(2, userName);
					ps2.setInt(3, Spassengers);
					ps2.setString(4, SDeparture);
					ps2.setInt(5, fare);
					ps2.setString(6, Sflightnum);
					ps2.executeUpdate();
					//update leg_reservation
					PreparedStatement ps = con.prepareStatement("INSERT INTO `loginschema`.`reserved_legs` (`res_numR`, `flight_numR`, `class`, `departure`) VALUES (?, ?, ?, ?);");
					ps.setInt(1, res_num);
					ps.setString(2, Sflightnum);
					ps.setString(3, SClass);
					ps.setString(4, SDeparture);
					ps.executeUpdate();
					//update legs--change the seat
					PreparedStatement ps3 =  con.prepareStatement("UPDATE `loginschema`.`legs` SET `seat` = ? WHERE (`flight_num` = ?) and (`departure` = ?);");
					ps3.setInt(1, seat-Spassengers);
					ps3.setString(2, Sflightnum);
					ps3.setString(3, SDeparture);
					ps3.executeUpdate();
		}
		}catch(Exception e){
			out.print(e);
		}
	}else{
		//multiple stop, use arraylist
		LegNode ptr=multipleS1.get(Sindex);
		Sflightnum=ptr.flightNum;
		SDeparture=ptr.d_time;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");

			PreparedStatement leginfo = con.prepareStatement("SELECT L.seat, L.fare FROM loginschema.legs L WHERE L.flight_num=? AND timediff(?, L.departure)=0 AND L.seat-?>=0;");
			leginfo.setString(1, Sflightnum);
			leginfo.setString(2, SDeparture);
			leginfo.setInt(3, Spassengers);
			ResultSet resuleg = leginfo.executeQuery();
			
			if(resuleg.next()){
				int fare=0;
				int res_num=rand.nextInt(10000);
				int numLeg=0;
				
				
				//update reservation
				PreparedStatement ps2 =  con.prepareStatement("INSERT INTO `loginschema`.`reservations` (`res_num`, `login`, `bookingfee`, `passengers`, `date`, `total_fare`, `booked_flightnum`, `booking_date`) VALUES (?, ?, '30', ?, date(?), ?, ?, curdate());");
				ps2.setInt(1, res_num);
				ps2.setString(2, userName);
				ps2.setInt(3, Spassengers);
				ps2.setString(4, SDeparture);
				ps2.setInt(5, fare);
				ps2.setString(6, Sflightnum);
				ps2.executeUpdate();
				//change fare later
				while(ptr!=null){
					//get required info
					Sflightnum=ptr.flightNum;
					SDeparture=ptr.d_time;
					
					leginfo = con.prepareStatement("SELECT L.seat, L.fare FROM loginschema.legs L WHERE L.flight_num=? AND timediff(?, L.departure)=0 AND L.seat-?>=0;");
					leginfo.setString(1, Sflightnum);
					leginfo.setString(2, SDeparture);
					leginfo.setInt(3, Spassengers);
					resuleg = leginfo.executeQuery();
					
				if(resuleg.next()){	
					int seat=resuleg.getInt("seat");
					fare+=resuleg.getInt("fare");
					
					numLeg++;
				//update leg_reservation
				PreparedStatement ps = con.prepareStatement("INSERT INTO `loginschema`.`reserved_legs` (`res_numR`, `flight_numR`, `class`, `departure`) VALUES (?, ?, ?, ?);");
				ps.setInt(1, res_num);
				ps.setString(2, Sflightnum);
				ps.setString(3, SClass);
				ps.setString(4, SDeparture);
				ps.executeUpdate();
				//update legs--change the seat
				PreparedStatement ps3 =  con.prepareStatement("UPDATE `loginschema`.`legs` SET `seat` = ? WHERE (`flight_num` = ?) and (`departure` = ?);");
				ps3.setInt(1, seat-Spassengers);
				ps3.setString(2, Sflightnum);
				ps3.setString(3, SDeparture);
				ps3.executeUpdate();
				}
				ptr=ptr.next;
				}
				
				fare=changeFare(fare, numLeg, SDeparture, Sflightnum , Spassengers);
				
				
				PreparedStatement ps4 = con.prepareStatement("UPDATE `loginschema`.`reservations` SET `date` = date(?), `total_fare` = ?, `booked_flightnum` = ? WHERE (`res_num` = ?);");
				ps4.setString(1, SDeparture);
				ps4.setInt(2, fare);
				ps4.setString(3, Sflightnum);
				ps4.setInt(4, res_num);
				ps4.executeUpdate();
				
			}
			}catch(Exception e){
				out.print(e);
			}
		
		
	}
}
%>

<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/profile/view/flight_history.jsp";
	</script>