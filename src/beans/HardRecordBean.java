package beans;

import java.util.Date;

public class HardRecordBean {
	private int id;
	private String username;
	private Date appointmentStartDay;
	private Date appointmentEndDay;
	private Date applyTime;
	private Boolean passState;

	public int getId() {
		return this.id;
	}

	public String getUsername() {
		return this.username;
	}

	public Date getAppointmentStartDay() {
		return this.appointmentStartDay;
	}

	public Date getAppointmentEnd() {
		return this.appointmentEndDay;
	}

	public Date getApplyTime() {
		return this.applyTime;
	}

	public Boolean getPassState() {
		return this.passState;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setAppointmentStartDay(Date appointmentStartDay) {
		this.appointmentStartDay = appointmentStartDay;
	}

	public void setAppointmentEndDay(Date appointmentEndDay) {
		this.appointmentEndDay = appointmentEndDay;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public void setPassState(Boolean passState) {
		this.passState = passState;
	}

	@Override
    public String toString() {
		String apl_start = appointmentStartDay.toString();
		String apl_time = applyTime.toString();
        return "HardRecord(username:" + username + ",apl_start:" + apl_start + ")";
    }
}
