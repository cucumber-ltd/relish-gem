module Relish
  class Ui
    def get_credentials
      puts "Please enter your Relish credentials."

      print "Email: "
      user = ask

      print "Password: "
      password = running_on_windows? ? ask_for_password_on_windows : ask_for_password

      [ user, password ]
    end
    
  private
  
    def running_on_windows?
      RUBY_PLATFORM =~ /mswin32|mingw32/
    end
    
    def ask_for_password_on_windows
      require "Win32API"
      char = nil
      password = ''

      while char = Win32API.new("crtdll", "_getch", [ ], "L").Call do
        break if char == 10 || char == 13 # received carriage return or newline
        if char == 127 || char == 8 # backspace and delete
          password.slice!(-1, 1)
        else
          # windows might throw a -1 at us so make sure to handle RangeError
          (password << char.chr) rescue RangeError
        end
      end
      puts
      return password
    end

    def ask_for_password
      echo_off
      password = ask
      puts
      echo_on
      return password
    end
    
    def echo_off
      system "stty -echo"
    end

    def echo_on
      system "stty echo"
    end
    
    def ask
      gets.strip
    end
    
  end
end