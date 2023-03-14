
class MasterMind

  @@turn = 1
  @@winner = ' '
  @@shared_XO = ""

  def initialize
    puts "Welcome to mastermind!"
    puts "\r\n"
  end

  def player_turn
    puts "\r\n"
    puts "Turn ##{@@turn}. Please enter your 4 digit code (0-5)"
    input = gets.chomp
    input_array = input.to_s.split(//).map { |x| x.to_i}
    if input_array.any? { |x| x > 6} || input_array.length > 4
      puts "Invalid selection! Try again!"
      player_turn
    else
      @@turn += 1
      @@shared_XO = ""
      until @@turn >= 13 do
        compare_0(input_array, @gen_code)
        compare_1(input_array, @gen_code)
        compare_2(input_array, @gen_code)
        compare_3(input_array, @gen_code)
        compare_arr(input_array, @gen_code)
        puts @@shared_XO
        compare(input_array, @gen_code)
      end
    end
  end

  def compare(input, code)
    if input == code
      puts "You win!!! "
      @@turn = 13
      @@winner = "user"
    else
      player_turn
    end
  end

  def compare_arr(input, code)
    shared = code.zip(input)
    comp, user = shared.reject { |c,u| c==u}.transpose
    if user == nil
      return
    else
      user.each do |n|
        i = comp.index(n)
        comp.delete_at(i) if i
      end

      if user.size-comp.size == 1
        @@shared_XO += "O"
      elsif user.size-comp.size == 2
        @@shared_XO += "OO"
      elsif user.size-comp.size == 3
        @@shared_XO += "OOO"
      elsif user.size-comp.size == 4
        @@shared_XO += "OOOO"
      else
        return
      end
    end
  end

  def compare_0(input, code)
    out = input[0] == code[0] ? "X" : return
    @@shared_XO += "X"
    @@four_code += code[0].to_s
  end

  def compare_1(input, code)
    out = input[1] == code[1] ? "X" : return
    @@shared_XO += "X"
    @@four_code += code[0].to_s
  end

  def compare_2(input, code)
    out = input[2] == code[2] ? "X" : return
    @@shared_XO += "X"
    @@four_code += code[0].to_s
  end

  def compare_3(input, code)
    out = input[3] == code[3] ? "X" : return
    @@shared_XO += "X"
    @@four_code += code[0].to_s
  end
#---------
@@arry_num = 0
@@ai_options = [0, 1, 2, 3, 4, 5].repeated_permutation(4).to_a
@@four_code = ""
@@narrow_turn = 0

  def maker
    puts "\r\n"
    puts "Please enter a 4-digit code for the AI to break!"
    input = gets.chomp
    @input_arr = input.split(//).map(&:to_i)
    ai_go
  end

  def ai_go
    arry = [[0, 0, 0, 0], [1, 1, 1, 1], [2, 2, 2, 2], [3, 3, 3, 3], [4, 4, 4, 4], [5, 5, 5, 5]]
      until @@four_code.length == 4 do
      puts "\r\n"
      puts "AI Turn ##{@@turn}. Please enter your 4 digit code (0-5)"
      @@turn += 1
      puts "#{arry[@@arry_num].join}"
        compare_test(@input_arr, arry[@@arry_num])
      end
    narrow_options
  end

  def narrow_options
    inc_nums = @@four_code.split(//).map(&:to_i) #[1, 3, 3, 5]
    rej_nums = [0, 1, 2, 3, 4, 5] - inc_nums
    filter1 = @@ai_options.reject{ |x| x.include?(rej_nums[0])}
    filter2 = filter1.reject{ |x| x.include?(rej_nums[1])}
    filter3 = filter2.reject{ |x| x.include?(rej_nums[2])}
    filter4 = filter3.reject{ |x| x.include?(rej_nums[3])}
    filter5 = filter4.reject{ |x| x.include?(rej_nums[4])}
    filter6 = filter5.select{ |x| x.include?(inc_nums[0]) && x.count(inc_nums[0]) == inc_nums.count(inc_nums[0])}
    filter7 = filter6.select{ |x| x.include?(inc_nums[1]) && x.count(inc_nums[1]) == inc_nums.count(inc_nums[1])}
    filter8 = filter7.select{ |x| x.include?(inc_nums[2]) && x.count(inc_nums[2]) == inc_nums.count(inc_nums[2])}
    @filter9 = filter8.select{ |x| x.include?(inc_nums[3]) && x.count(inc_nums[3]) == inc_nums.count(inc_nums[3])}
    until @@shared_XO == "XXXX" || @@shared_XO == "OOOO"
      puts "\r\n"
      puts "AI Turn ##{@@turn}. Please enter your 4 digit code (0-5)"
      @@turn += 1
=begin
      randy = @filter9.count-1
      randy2 = rand(0..randy)
      puts "#{@filter9[randy2].join}"
      compare_test(@input_arr, @filter9[randy2])
=end

      puts "#{@filter9[@@narrow_turn].join}"
      compare_test(@input_arr, @filter9[@@narrow_turn])
      @@narrow_turn += 1
      @@four_code = ""
    end
    if @@shared_XO == "OOOO"
      even_narrower0
     else
       nil
     end
  end

  def even_narrower0
    @@shared_XO = ""
    @even_narrower = 0
    filter10 = @filter9.reject{ |x| x[0] == @filter9[@@narrow_turn-1][0]}
    filter11 = filter10.reject{ |x| x[1] == @filter9[@@narrow_turn-1][1]}
    filter12 = filter11.reject{ |x| x[2] == @filter9[@@narrow_turn-1][2]}
    @filter13 = filter12.reject{ |x| x[3] == @filter9[@@narrow_turn-1][3]}
    until @@shared_XO == "XXXX" || @@shared_XO == "OOOO"
      puts "\r\n"
      puts "AI Turn ##{@@turn}. Please enter your 4 digit code (0-5)"
      @@turn += 1
      puts "#{@filter13[@even_narrower].join}"
      compare_test(@input_arr, @filter13[@even_narrower])
      @even_narrower += 1
      @@four_code = ""
    end
    if @@shared_XO == "OOOO"
     even_narrower1
    else
      nil
    end
  end


  def even_narrower1
    @@shared_XO = ""
    @even_narrower1 = 0
    filter14 = @filter13.reject{ |x| x[0] == @filter13[@even_narrower-1][0]}
    filter15 = filter14.reject{ |x| x[1] == @filter13[@even_narrower-1][1]}
    filter16 = filter15.reject{ |x| x[2] == @filter13[@even_narrower-1][2]}
    @filter17 = filter16.reject{ |x| x[3] == @filter13[@even_narrower-1][3]}
    until @@shared_XO == "XXXX" || @@shared_XO == "OOOO"
      puts "\r\n"
      puts "AI Turn ##{@@turn}. Please enter your 4 digit code (0-5)"
      @@turn += 1
      puts "#{@filter17[@even_narrower1].join}"
      compare_test(@input_arr, @filter17[@even_narrower1])
      @even_narrower1 += 1
      @@four_code = ""
    end
    if @@shared_XO == "OOOO"
      even_narrower2
     else
       nil
     end
  end

  def even_narrower2
    @@shared_XO = ""
    @even_narrower2 = 0
    filter18 = @filter17.reject{ |x| x[0] == @filter17[@even_narrower1-1][0]}
    filter19 = filter18.reject{ |x| x[1] == @filter17[@even_narrower1-1][1]}
    filter20 = filter19.reject{ |x| x[2] == @filter17[@even_narrower1-1][2]}
    @filter21 = filter20.reject{ |x| x[3] == @filter17[@even_narrower1-1][3]}
    until @@shared_XO == "XXXX" || @@shared_XO == "OOOO"
      puts "\r\n"
      puts "AI Turn ##{@@turn}. Please enter your 4 digit code (0-5)"
      @@turn += 1
      puts "#{@filter21[@even_narrower2].join}"
      compare_test(@input_arr, @filter21[@even_narrower2])
      @even_narrower2 += 1
      @@four_code = ""
    end
  end


  def compare_test(input, ai)
    @@arry_num += 1
    if input == ai
      puts "AI WON!!!"
      @@shared_XO = "XXXX"
      game_over
    else
      @@shared_XO = ""
      compare_0(input, ai)
      compare_1(input, ai)
      compare_2(input, ai)
      compare_3(input, ai)
      compare_arr(input, ai)
      puts @@shared_XO
    end
  end

  def compare_ai
    if @input_arr == @@ai_options[0]
      puts "AI WON!!!"
    else
      @@shared_XO = ""
      compare_0(@input_arr, @@ai_options[0])
      compare_1(@input_arr, @@ai_options[0])
      compare_2(@input_arr, @@ai_options[0])
      compare_3(@input_arr, @@ai_options[0])
      compare_arr(@input_arr, @@ai_options[0])
      puts @@shared_XO
      testy
    end
  end

  def testy
    if @@shared_XO == "X"
      @@ai_options = @@ai_options.select{|x| x.include?(@@ai_options[0][0]) && x.count(@@ai_options[0][0]) == 1}
      ai_go
    else
      puts "hmmm"
    end

  end

  def game_over
    puts "Finished"
    @@shared_XO = "XXXX"
    return
  end
  #---------

  def play
    puts "Would you like to be the code MAKER or code BREAKER?"
    puts "\r\n"
    puts "Press '1' to make the code"
    puts "Press '2' to break the code"
    input1 = gets.chomp
    if input1 == "1"
      maker
    elsif input1 == "2"
      puts "\r\n"
      puts "You will have 12 attempts to break the code!"
      puts "\r\n"
      puts "The code will be four digits from 0-5"
      puts "\r\n"
      puts "X means you have a number in the right place."
      puts "O means you have a number thats not in the right place"
      puts "\r\n"
      @gen_code = Array.new(4)
      @gen_code[0] = rand(6)
      @gen_code[1] = rand(6)
      @gen_code[2] = rand(6)
      @gen_code[3] = rand(6)
      @gen_code
      player_turn
          if @@winner == " " && @@turn >= 13
            puts "You fucking LOSER!!!!!"
          else
            return
          end
    else
      return
    end
  end
end

go = MasterMind.new
go.play
