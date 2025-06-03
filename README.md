This is the set of all my code and notes as I go over the Elixir in action text book. This is a very interesting book and I plan on going over each page to see what I might not have been seeing over the course of my work and site building.  

Please feel free to check out any of the code here as it will always stay public. As I do more and more reading and sample exercises Ill try and maintain a bit more in this readme.md as I go.

Chapter 1
This chapter is all about the idea of Elixir as a functional language. It takes its time and tries to be sure that you know what you are getting into and that Elixir is not a NORMAL language.

Chapter 2
This chapter is all about setting the ground work for what you can use in Elixir and how to use the Shell. Although to be honest I prefer Livebook for all the coding examples. 

This chapter also starts to get into the idea of creating and using functions with modules.

Chapter 3
This chapter is about control flow and that all functions are just manipulating the data and structure of the data. Pattern matching is one of the biggest topics for this chapter and as such you will see it all throughout the Elixir language. Guards, Enum, and many other topics are covered here

Chapter 4
Data abstractions are covered in this chapter. You can use the struct data type to create almost any type of data you want and then use it to manipulate and control what happens to the data. Schemaless Ecto might be a better choice but it requires more of the reader and the book doesn't get into that as of yet.

Chapter 5
This chapter gets into the Idea of the Concurrent Elixir you start to work with spawn and the idea of sending and receiving messages. You use the TodoList you created in chapter 4 and make a server that can add and retrieve the events within a TodoList.

Chapter 6
This is all about taking the ideas from chapter 5 and turning them into the GenServer. You first start off will just using the boiler plate functions for sending and receiving messages, as well as manipulating the state of those servers. 

You then start to work with the GenServer module to get more concrete examples.