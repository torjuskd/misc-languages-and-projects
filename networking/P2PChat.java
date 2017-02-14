import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.*;
import java.util.Scanner;

class P2PChat{
	public static void main(String[] args){
		MultiChatClient multi = new MultiChatClient();
		multi.getStarted();
	}
}

class MultiChatClient extends Thread{
	public static Scanner keyboard;
	public final static int port = 7001;
	public static Socket socket = null;
	ClientModule client = null;
	
	public void setSocket(Socket socket){
		MultiChatClient.socket = socket;
	}
	public void getStarted(){
		keyboard = new Scanner(System.in);
		//Choose to start as server or client:
		System.out.println("want to connect(1), or listen(2) for connections?");
		String ans = "";
		ans = keyboard.nextLine();
		//If user typed "connect" or "1", we connect actively,
		//for every other input we listen passively.
		if(ans.equalsIgnoreCase("connect") || ans.equals("1")){
			//User inputs the client address
			System.out.println("enter address of the other client:");
			String address = keyboard.nextLine();
			address.trim();
			
			//starting client module
			client = new ClientModule(address, port, socket);
			Socket clientConnection = client.client();
			setSocket(clientConnection);
			Listener listener = new Listener(socket, null);
			Thread t = new Thread(listener);
			t.start();
			chat();
		}else{
			//Starting server module
			//Listens on a port; does not need to know ipadr
			ServerModule server = new ServerModule(port, socket, this);
			Thread t = new Thread(server);
			t.start();
			while(socket == null){
				
			}
			client = new ClientModule(socket.getInetAddress().getHostName(), port, socket);
			client.client();
			chat();
		}
		//done, free up resources
		keyboard.close();
		if(socket != null){
			try {
				socket.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	//Keep chatting until keywords exit or quit is typed.
	public void chat(){
		while(true){
			String message = client.sendMessage(keyboard);
			if(message.equalsIgnoreCase("exit") || message.equalsIgnoreCase("quit")) break;
		}
	}
}

//Class used for accepting a connection
//concurrency used for setting up connection
//and receiving incoming data
class ServerModule implements Runnable{
	ServerSocket server;	
	int port;
	Listener listener;
	Socket socket;
	MultiChatClient multi;
	
	ServerModule(int port, Socket socket, MultiChatClient multi){
		this.port = port;
		this.socket = socket;
		this.multi = multi;
	}
	
	public void run(){
		try{
		    server = new ServerSocket(port);
		  } catch (IOException e) {
		    System.out.println("Could not listen on port "+port);
		    System.exit(-1);
		  }
		  while(true){
		    try{
		    	//server.accept returns a client connection
		    	System.out.println("listening for connections.");
		    	if(socket == null){
		    		listener = new Listener( server.accept(), multi );
		    	}else{
		    		listener = new Listener(socket, multi);
		    	}
		    	Thread t = new Thread(listener);
	    		t.start();
		    } catch (IOException e) {
		      System.out.println("Accept failed: "+port);
		      System.exit(-1);
		    }
		  }
	}
	protected void finalize(){
	//Objects created in run method are finalized when
	//program terminates and thread exits
	     try{
	        server.close();
	    } catch (IOException e) {
	        System.out.println("Could not close socket");
	        System.exit(-1);
	    }
	}	  

}

//Class used for reading incoming data
//when connection is set up
//concurrent.
class Listener implements Runnable {
	  private Socket client;
	  MultiChatClient multi;

	//Constructor
	  Listener(Socket client, MultiChatClient multi) {
	    this.client = client;
	    this.multi = multi;
	  }

	  public void run(){
	    String line;
	    BufferedReader in = null;
	    //PrintWriter out = null;
	    System.out.println("Now connected to "+ client.getInetAddress().getHostName());
	    if(multi != null)multi.setSocket(client);
	    try{
	      in = new BufferedReader(new InputStreamReader(client.getInputStream()));
	      //out = new PrintWriter(client.getOutputStream(), true);
	    } catch (IOException e) {
	      System.out.println("in or out failed");
	      System.exit(-1);
	    }

	    while(true){
	      try{
	        line = in.readLine();
	        //Send data back to client
	        //out.println(line);
	        //Append data to text area
	        System.out.println("Incoming message from "+client.getInetAddress().getHostName()+": ");
	        System.out.println(line);
	       }catch (IOException e) {
	        System.out.println("Read failed");
	        System.exit(-1);
	       }
	    }
	  }
	  
	}

//client part of program
class ClientModule extends Thread{
	Socket socket;
	//BufferedReader in;
	PrintWriter out;
	String address;
	Scanner scanner;
	int port;
	
	ClientModule(String address, int port, Socket socket){
		this.address = address;
		this.port = port;
		this.socket = socket;
	}
	
	//Create socket connection, initializing client.
	public Socket client(){
		
		   try{
			 if(socket == null){
				 socket = new Socket(address, port);
			 }
		     if(socket != null){
		    	 System.out.println("socket creation successful");
		    	 
		     }
		     System.out.println("Now connected to"+ socket.getInetAddress().getHostName());
		     out = new PrintWriter(socket.getOutputStream(), true);
		     out.flush();
		     out.println("Client is connected.");
		     
		    // in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
		   } catch (UnknownHostException e) {
		     System.out.println("Unknown host: "+address);
		     System.exit(1);
		   } catch  (IOException e) {
		     System.out.println("No I/O");
		     e.printStackTrace();
		     System.exit(1);
		   }
		   return socket;
	}
	//Here messages are sent.
	public String sendMessage(Scanner scanner){
		try {
			sleep(100);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     System.out.print("Send message: ");
	     String message = "";
	     message = scanner.nextLine();
	     System.out.println("");
	     out.println(message);
	     out.flush();
	     return message;
	}
}
