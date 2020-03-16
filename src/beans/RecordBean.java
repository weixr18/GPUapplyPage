package beans;

import java.util.Date;

public class RecordBean {
	private int id;
	private String username;
	private Date appointmentDay;
	private byte appointmentPeriod;
	private Date applyTime;
	private Boolean passState;
	private int sysUserId;

	public int getId() {
		return this.id;
	}

	public String getUsername() {
		return this.username;
	}

	public Date getAppointmentDay() {
		return this.appointmentDay;
	}

	public byte getAppointmentPeriod() {
		return this.appointmentPeriod;
	}

	public Date getApplyTime() {
		return this.applyTime;
	}

	public Boolean getPassState() {
		return this.passState;
	}

	public int getSysUserId() {
		return this.sysUserId;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setAppointmentDay(Date appointmentDay) {
		this.appointmentDay = appointmentDay;
	}

	public void setAppointmentPeriod(byte appointmentPeriod) {
		this.appointmentPeriod = appointmentPeriod;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public void setPassState(Boolean passState) {
		this.passState = passState;
	}

	public void setSysUserId(int sysUserId) {
		this.sysUserId = sysUserId;
	}

}
