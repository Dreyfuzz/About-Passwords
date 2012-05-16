#!/usr/bin/env ruby -wKU

def line(prompt)
  puts prompt
  gets
end

def crypt(password)
  chars = []

  password.each_byte do |s|
    chars.push(s)
  end

  chars.map! do |c|
    (c + 1).chr
  end
  chars.join
end

def checker (user, guess)
end

#introduction
puts "How do passwords work?"
line("(press return to continue)")
line("When you create a password on a website, there are one of two things they do with it.  Let's talk about the bad way first.")

#the bad way
puts "In the bad way, the website just saves your password as plain text.  Let's try this out."
password = ""
while password.length == 0
  puts "Type a password below:"
  password = gets.chomp
end
line("Here I go, I'm saving your password in my database along with a bunch of other information about you:")
user = {:email => "dude@example.com", :password => password, :username => "thedudester", :member_since => Time.now }
puts user
puts "When you go back to my site and type in your password, I check it against the one you already gave me.  Try entering the wrong password below:\n"

guess = nil
while guess != user[:password]
  guess = gets.chomp
  puts "\nGuess: " + guess
  puts "#{guess} = #{password}?"
  puts guess == user[:password]
  unless guess == user[:password]
    puts "\nNow enter the right one."
  end
  puts "\n"
end

line("This is really convenient for my users, because if you forget your password, I can just email it to you!")
line("But on the other hand, if my database gets hacked, whoever steals it knows your email, username and password.")
line("If you're like most people, you reuse your passwords a lot. Hey, I know, let's go see if that same email and password works on Facebook!")
line("Or Gmail!")
line("Or the five most popular sites for online banking!")
line("Get the idea?  Saving password as plain text is a pretty bad idea.")

#the good way
line("Now, there's a better way to do this.  It's called hashing.")
line("A 'hashed' password is encrypted as soon as it's entered, and only saved as an encrypted value. ")
line("What's encrypted?")
line("It means encoded.  I use a secret method to encode your password, so that even if someone steals it, it's just gibberish!")
line("How about an example?  Here's what your password looks like if I move every letter over one space on the alphabet (a->b, b->c, etc.)")

puts crypt(password)+"\n"

line("This is called a 'Caesar Cipher.'  A cipher is a method of encryption, and moving letters around like this is how Julius Caesar sent secret messages!")
user[:password] = crypt(password)

line("Let's look at your user data now:")
puts user
puts "\n"
line("Now if my database gets hacked, nobody knows your password!")
puts "But how can I check it when you sign in?  Easy!  Run what you enter through the same cipher and see if it matches your hashed password! (Try the wrong password first)"

guess = nil
while guess != user[:password]
  guess = gets.chomp
  puts "\nGuess: " + guess
  guess = crypt(guess)
  puts "\nHashed guess: " + guess
  puts "#{guess} = #{password}?"
  puts guess == user[:password]
  unless guess == user[:password]
    puts "\nNow enter the right one."
  end
  puts "\n"
end

line("Now, there's one disadvantage here when compared to plain text storage.  If you forget your password, it has to be reset.  I can't tell you your password, because I don't even know it.")
line("Another thing you might notice is that the Caesar Cipher is pretty simple, and easy to break.  That's why the real ciphers used by web servers are much more complicated.")
puts("Here's what your password looks like using a much stronger cipher:")
puts user[:password] = password.hash
puts "Of course, the same system still works for checking passwords:"

guess = nil
while guess != user[:password]
  guess = gets.chomp
  puts "\nGuess: " + guess
  guess = guess.hash
  puts "\nHashed guess: #{guess}"
  puts "#{guess} = #{user[:password]}?"
  puts guess == user[:password]
  unless guess == user[:password]
    puts "\nNow enter the right one."
  end
  puts "\n"
end

line("Hey, you've reached the end!  You know what you should do now? Check out the source code for this little program, and see how I created a user and checked passwords!")