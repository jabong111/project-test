package kh10.board.model;

import java.sql.Timestamp;

public class CommentRequest {
	private int content_num;	//�Խñ� ��ȣ
	private int comment_num;	//�ڸ�Ʈ��ȣ
	private String commenter;	//�ڸ�Ʈ�ۼ���
	private String commentt;	//�ڸ�Ʈ ����
	private String passwd;		//��й�ȣ
	private Timestamp reg_date;	//������¥
	
	public int getContent_num() {
		return content_num;
	}
	public void setContent_num(int content_num) {
		this.content_num = content_num;
	}
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public String getCommenter() {
		return commenter;
	}
	public void setCommenter(String commenter) {
		this.commenter = commenter;
	}
	public String getCommentt() {
		return commentt;
	}
	public void setCommentt(String commentt) {
		this.commentt = commentt;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	

	

}
