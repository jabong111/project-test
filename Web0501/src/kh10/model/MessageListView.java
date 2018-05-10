package kh10.model;

import java.util.List;


//페이징을 하기위해 만들어준 클래스
public class MessageListView {	//메시지들의 리스트를 받아온다.
	private int messageTotalCount;
	private int currentPageNumber;
	private List<Message> messageList;
	private int pageTotalCount;
	private int messageCountPerPage;
	private int firstRow;
	private int endRow;
	
	public MessageListView(List<Message> messageList,int messageTotalCount,int currentPageNumber,
							int messageCountPerPage,int startRow, int endRow) {
		this.messageList = messageList;
		this.messageTotalCount = messageTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.messageCountPerPage = messageCountPerPage;
		this.firstRow = startRow;
		this.endRow = endRow;
		calcuratePageTotalCount();	
	}	//생성자를 통해 초기화한다.
	
	private void calcuratePageTotalCount() {
		if(messageTotalCount == 0) {
			pageTotalCount = 0;
		}else {
			pageTotalCount = messageTotalCount / messageCountPerPage;
			if(messageTotalCount % messageCountPerPage > 0) {
				pageTotalCount++;
			}
		}
	}
	
	public int getMessageTotalCount() {
		return messageTotalCount;
	}
	public int getCurrentPageNumber() {
		return currentPageNumber;
	}
	public List<Message> getMessageList() {
		return messageList;
	}
	public int getPageTotalCount() {
		return pageTotalCount;
	}
	public int getMessageCountPerPage() {
		return messageCountPerPage;
	}
	public int getFirstRow() {
		return firstRow;
	}
	public int getEndRow() {
		return endRow;
	}
	
	public boolean isEmpty() {
		return messageTotalCount==0;
	}
	
}
