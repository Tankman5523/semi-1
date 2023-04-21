package com.bbbox.board.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/webSocket")
public class WebSocket {
	//클라이언트들의 세션을 저장할 Set
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

    // WebSocket 접속하면 요청되는 함수
    @OnOpen
    public void handleOpen(Session session) {
        // 세션을 세션 리스트에 추가
        clients.add(session);
        // 콘솔에 접속 로그를 출력
        System.out.println("클라이언트 접속");
    }

    @OnMessage
    public void handleMessage(String message, Session session) throws IOException {
        // 모든 클라이언트에게 메시지 전송
        for (Session s : clients) {
            if (s.isOpen()) {
            	//세션이 열려있는사람에게 메세지 투척!
                s.getBasicRemote().sendText(message);
            }
        }
        
        //메세지전송후 세션에 등록된 메세지 삭제.
        session.getUserProperties().remove("message");
    }

    @OnClose
    public void handleClose(Session session) {
        // 세션을 세션 리스트에서 제거
        clients.remove(session);
        // 콘솔에 접속 끊김 로그를 출력
        System.out.println("클라이언트 접속 해제");
    }

    @OnError
    public void handleError(Throwable t) {
        t.printStackTrace();
    }
}