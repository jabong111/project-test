package net.member.action;

public class ActionForward {
	private boolean isRedirect=false;	//리다이렉트 여부
	private String path=null;	//경로
		
	public boolean isRedirect(){	
		return isRedirect;	
	}
	
	public String getPath(){
		return path;
	}
	
	public void setRedirect(boolean b){
		isRedirect=b;	//리타이렉트 여부를 저장한다
	}
	
	public void setPath(String string){
		path=string;	//경로를 저장한다.
	}
}