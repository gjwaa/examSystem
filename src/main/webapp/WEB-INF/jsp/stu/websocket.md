# websocket



## 1.什么是websokect

WebSocket使得客户端和服务器之间的数据交换变得更加简单，允许服务端主动向客户端推送数据。在WebSocket API中，浏览器和服务器只需要完成一次握手，两者之间就直接可以创建持久性的连接，并进行双向数据传输。

## 2.与servlet的区别

```
servlet是单例对象  但是websokect是多例对象  因为它需要实时链接
```

## 3.建立websocket

### 服务器端：

####    1.添加注解

​    @ServerEndpoint("/websocket/{name}")

####    2.设定变量：

```
private static volatile int onlineCount = 0;

//用来存放每个客户端对应的WebSocketTest对象，适用于同时与多个客户端通信（线程安全的无序的集合）
public static CopyOnWriteArraySet<Websocket> webSocketSet = new CopyOnWriteArraySet<Websocket>();
//若要实现服务端与指定客户端通信的话，可以使用Map来存放，其中Key可以为用户标识（适用于并发）
public static ConcurrentHashMap<Session, Object> webSocketMap = new ConcurrentHashMap<Session, Object>();

//与某个客户端的连接会话，通过它实现定向推送(只推送给某个用户)
private Session session;
```

#### 3.建立连接，发送数据

```
/**
 * 建立连接成功调用的方法
 */
@OnOpen
public void onOpen(Session session) {
    this.session = session;
    webSocketSet.add(this);  // 添加到set中
    webSocketMap.put(session, this);    // 添加到map中
    addOnlineCount();    // 添加在线人数
    System.out.println("新人加入，当前在线人数为：" + getOnlineCount());
}

/**
 * 收到客户端调用的方法
 */
@OnMessage
public void onMessage(String message, Session mysession) throws Exception {
    for (Websocket item :
            webSocketSet) {
        item.sendAllMessage(message);
    }
}

public void sendAllMessage(String message) throws IOException {
    this.session.getBasicRemote().sendText(message);
}
```

#### 4.关闭连接，记录在线人数

```
/**
 * 关闭连接调用的方法
 */

public void onClose(Session closeSession) {
    webSocketMap.remove(session);
    webSocketSet.remove(this);
    subOnlineCount();
    System.out.println("有人离开，当前在线人数为：" + getOnlineCount());
}



// 获取在线人数
public static synchronized int getOnlineCount() {
    return onlineCount;
}

// 添加在线人+1
public static synchronized void addOnlineCount() {
    onlineCount++;
}

// 减少在线人-1
public static synchronized void subOnlineCount() {
    onlineCount--;
}
```

### 客户端：

#### 1.页面标签搭建

```
<button id="connBtn">连接</button>
<input type="text" id="msg">
<button id="sendBtn" onclick="send()">发送</button>
<button id="closeBtn"  onclick="closeWebsocket()">关闭</button>
<div id="message">
</div>
```

#### 2.js建立连接

```
var ws = null;
if ('WebSocket' in window){
    ws = new WebSocket("ws:localhost:8089/Servlet/websocket/23")
}else {
    alert("浏览器不支持");
}
var connBtn = document.getElementById("connBtn");
var sendBtn = document.getElementById("sendBtn");
var closeBtn = document.getElementById("closeBtn");

// 连接安生错误的回调方法
ws.onerror = function () {
    setMessageInnerHTML("WEBSOCKET发生链接错误");
}

// 连接成功的回调方法
ws.onopen = function (ev) {
    setMessageInnerHTML("WebSocket连接成功！");
}

// 收到消息的回调方法
ws.onmessage = function (ev) {
    console.log(1)
    setMessageInnerHTML(ev.data);
}

// 连接关闭的回调方法
ws.onclose = function () {
    setMessageInnerHTML("WebSocket连接关闭");
}


// 监听窗口关闭事件，防止连接没断关闭窗口。
window.onbeforeunload = function () {
    closeWebSocket();
}


// 将消息显示在网页上
function setMessageInnerHTML(innerHtml){
    document.getElementById("message").innerHTML += innerHtml + '<br />'
}

// 关闭websocket连接
function closeWebsocket(){
    ws.close();
}

// 发送消息
function send(){
    var message = document.getElementById("msg").value;
    ws.send(message);
}
```