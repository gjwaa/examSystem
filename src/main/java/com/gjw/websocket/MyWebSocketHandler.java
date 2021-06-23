package com.gjw.websocket;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/16 14:36
 * @desc:
 */

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.*;

import java.io.IOException;
import java.util.*;

@Component
@Service
public class MyWebSocketHandler implements WebSocketHandler {

    // 当 MyWebSocketHandler 类被加载时就会创建该 Map
    private static final Map<String, WebSocketSession> userSocketSessionMap;

    static {
        userSocketSessionMap = new HashMap<String, WebSocketSession>();
    }

    /**
     * 连接成功后
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session)
            throws Exception {

        // 此处为 WebSocketSession，uid 是由拦截器已绑定好的，用于区分用户
        String uid = session.getAttributes().get("uid").toString();

        // 绑定session
        if (userSocketSessionMap.get(uid) == null) {
            userSocketSessionMap.put(uid, session);
        }
//        try {
//            if (session.getAttributes().get("state").toString().equals("startExam")){
//                session.sendMessage(new TextMessage("startExam"));
//            }
//        }catch (NullPointerException e){
//            System.out.println("为空");
//        }
//        String state = session.getAttributes().get("state").toString();
//        System.err.println(state);
//        session.sendMessage(new TextMessage("startExam"));

    }

    /**
     * 消息处理
     */
    @Override
    public void handleMessage(WebSocketSession session,
                              WebSocketMessage<?> message) throws Exception {

        if (message.getPayloadLength() == 0) return;
        // 把消息发送给消息来源方
//        session.sendMessage(message);
        // 自己定义的函数，发送给在线的所有人
        sendMessageToAllUsers(message);

    }

    /**
     * 消息传输错误处理
     */
    @Override
    public void handleTransportError(WebSocketSession session,
                                     Throwable exception) throws Exception {

        String uid = session.getAttributes().get("uid").toString();
        if (session.isOpen()) {
            session.close();
        }
        System.out.println(uid + " 连接失败");
        userSocketSessionMap.remove(session);

    }

    /**
     * 关闭连接后
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session,
                                      CloseStatus closeStatus) throws Exception {

        String uid = session.getAttributes().get("uid").toString();
        System.out.println("UserWebSocket:" + uid + " close connection");
        Iterator<Map.Entry<String, WebSocketSession>> iterator = userSocketSessionMap.entrySet().iterator();

        // 移除
        while (iterator.hasNext()) {
            // 取值查询
            Map.Entry<String, WebSocketSession> entry = iterator.next();
            String s = (String) entry.getValue().getAttributes().get("uid");
            if (s.equals(uid) && !s.equals("admin")) {
                iterator.remove();
                System.out.println("WebSocket in UserMap:" + uid + " removed");
            }
        }

    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }


    // 发送给所有用户
    private boolean sendMessageToAllUsers(WebSocketMessage message) {
        boolean allSendSuccess = true;
        Set<String> clientIds = userSocketSessionMap.keySet();
        WebSocketSession session = null;
        for (String clientId : clientIds) {
            System.err.println(clientId);
            try {
//                if (!clientId.equals("admin")) {
                session = userSocketSessionMap.get(clientId);
                if (session.isOpen()) {
                    session.sendMessage(message);
                }
//                }

            } catch (IOException e) {
                e.printStackTrace();
                allSendSuccess = false;
            }
        }
        return allSendSuccess;
    }


}

