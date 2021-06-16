package com.gjw.websocket;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/16 14:26
 * @desc:
 */
@Component
@Configuration
@EnableWebMvc
@EnableWebSocket
public class WebSocketConfig  implements WebSocketConfigurer {

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
    	/* 当客户端发起 websocket 连接，把 /path 交给对应的 handler 处理，而不实现具体的业务逻辑，
    	   第一个参数用来注册 websocket server 实现类，第二个参数是访问 websocket 的地址  */
        registry.addHandler(myHandler(), "/ws").addInterceptors(new HandShake());
        registry.addHandler(myHandler(), "/ws/sockjs").addInterceptors(new HandShake()).withSockJS();
    }

    @Bean
    public WebSocketHandler myHandler() {
        return new MyWebSocketHandler();
    }
}
