This is the set of all my code and notes as I go over the Elixir in action text book. This is a very interesting book and I plan on going over each page to see what I might not have been seeing over the course of my work and site building.  
  
Please feel free to check out any of the code here as it will always stay public. As I do more and more reading and sample exercises Ill try and maintain a bit more in this readme.md as I go.  
  
**Chapter 1**  
This chapter is all about the idea of Elixir as a functional language. It takes its time and tries to be sure that you know what you are getting into and that Elixir is not a NORMAL language.  
  
**Chapter 2**  
This chapter is all about setting the ground work for what you can use in Elixir and how to use the Shell. Although to be honest I prefer Livebook for all the coding examples.   
  
This chapter also starts to get into the idea of creating and using functions with modules.*  
  
**Chapter 3**   
This chapter is about control flow and that all functions are just manipulating the data and structure of the data. Pattern matching is one of the biggest topics for this chapter and as such you will see it all throughout the Elixir language. Guards, Enum, and many other topics are covered here.  
  
**Chapter 4**  
Data abstractions are covered in this chapter. You can use the struct data type to create almost any type of data you want and then use it to manipulate and control what happens to the data. Schemaless Ecto might be a better choice but it requires more of the reader and the book doesn't get into that as of yet.  
  
**Chapter 5**  
This chapter gets into the Idea of the Concurrent Elixir you start to work with spawn and the idea of sending and receiving messages. You use the TodoList you created in chapter 4 and make a server that can add and retrieve the events within a TodoList.  
  
**Chapter 6**  
This is all about taking the ideas from chapter 5 and turning them into the GenServer. You first start off will just using the boiler plate functions for sending and receiving messages, as well as manipulating the state of those servers.  
  
You then start to work with the GenServer module to get more concrete examples. Once you figure out the general boiler-plate you will be able to set some code to take the Todo list into the GenServer.  
  
**Chapter 7**  
This chapter will start you on the process of learning the Mix architecture. We are also trying to take the Todo list structure and add more to it.   
  
We took the Todo Server and added in persistence (making it so that we can write to a disk).   
  
Then we took that same idea and made it so the process of reading/writing could be concurrent. To accomplish this we need to add in a DatabaseWorker module that took care of the read/write while passing the file to be written/read to/from. Then the Database needed to create x workers and then assign any given task to a worker. Before this step the Database took care of all the read/write so now any call to the database needs to go through DatabaseWorker.  
  
**Chapter 8**  
With this chapter we get to dive into the Supervisor module. We already have a lot of the implementation of the Todo list. So we really just need to set a supervisor and tell it what to do.   

Once you understand the process to create and work with a supervisor you still need to make sure that every start is now a start_link() as this will ensure that when things are restarted they are cleaned up as well as the state will be maintained. 

**Chapter 9**  
This chapter gets into the idea od supervisors and crash handling. We start off by making sure the workers for the database are supervised then we move on to the entire system being supervised.    

One thing to add is that in this chapter you might start to become more comfortable with the idea of a crash and what to do in that case. Crashes (when supervised) can be beneficial, as it starts you in a known state. YOu can use this to just get back on track or to try and replicate the crash.  

**Chapter 10**  
In this chapter we started off talking about Tasks. We learned about ways in which we can synchronize tasks or perform them asynchronously.  
  
We then went into Agents, this has more detail and ways of dealing with concurrent tasks. They are not as robust as GenServer but if you only need init/1 cast and call you should be fine.  
    
Lastly we went into ETS tables. They are a lightweight module that can do a lot of what a GenServer state can do. There will be places that it won't work. But with everything we have learned so far start with GenServer and then reduce the implementation until it works with what you need.  

**Chapter 11**  
This was a chapter that went into adding in other libraries and how to deploy at least on the localhost. Cowboy and Plug or plug_cowboy is a great library for this. Once we had the deps set we then could change a few setting and change the child_spec and then add it to the supervisor tree. Cowboy and Plug have a lot of built-in functions that will do a lot of the heavy lifting.  
  
**Chapter 12**  
