package net.member.action;

public class ActionForward {
	private boolean isRedirect=false;	//�����̷�Ʈ ����
	private String path=null;	//���
		
	public boolean isRedirect(){	
		return isRedirect;	
	}
	
	public String getPath(){
		return path;
	}
	
	public void setRedirect(boolean b){
		isRedirect=b;	//��Ÿ�̷�Ʈ ���θ� �����Ѵ�
	}
	
	public void setPath(String string){
		path=string;	//��θ� �����Ѵ�.
	}
}