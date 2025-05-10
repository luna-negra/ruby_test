require 'colorize'
require 'date'
require 'io/console'
require 'yaml'


$LOGIN_USER = ""
$CONFIG_PATH = "etc/config.yml"


class ToDo
    attr_reader :need_install
    attr_accessor :config_file
    @@process_num = 0

    def initialize
        # define variables
        @config_file  = YAML.load_file($CONFIG_PATH)
        @need_install = check_config
    end 

    public
    def main
        puts "\n[ Main - #{$LOGIN_USER} ]"
        puts ""
        puts "1. Show My To Do List"
        puts "2. Create New To do"
        puts "3. Update To do"
        puts "4. Delete To do"
        puts "5. Cancel"
        puts "======"
        print " * Type the number you want to do: "
        gets.chomp.to_i        
    end

    def prompt_signin
        puts "[ Sign In ]"
        u = input_username
        p = input_password
        check_account(u=u, p=p)
    end

    def prompt_signup
        puts "[ Sign Up ]"
        u = input_username
        p = input_password(true)

        if !(u.nil? || p.nil?)
            config_file["member"] = {u => { "password" => p, "todo_list" => [] }}
            File.open($CONFIG_PATH, "w") do |file|
                file.write(YAML.dump(@config_file))
            end
        end
    end

    def prompt_signout
        begin
            print " * Do you want to sign out? [y/N]: "
            gets.chomp.downcase == "y"
        
        rescue Interrupt => e
        end
    end

    def todo_create
        begin
            puts "\n[ Create New To Do ]"
            name = input_todo_name
            deadline = input_todo_deadline
            urgency = input_urgency
            add_todo({"name" => name, "deadline" => deadline, "urgency" => urgency})
        
        rescue Interrupt => e
        end
    end

    def todo_delete
        d = @config_file["member"][$LOGIN_USER]["todo_list"]
        flag = false
        type = "index"

        begin
            todo_show
            print " * Select the number or name of your to do to delete: "
            select = gets.chomp
            text = "[Warning] There is no To do with #{type} '#{select}'"

            if select.to_i == 0
                type = "name"
                for todo in d
                    idx = d.index(todo)
                    if todo["name"] == select
                        flag = true
                        d.delete_at(idx)
                        break
                    end 
                end    
            else
                select = select.to_i - 1
                if select < d.length
                    flag = true
                    d.delete_at(select)
                end
            end

            if flag 
                text = " !! Successfully Delete To Do with #{type} '#{select}'" 
                @config_file["member"][$LOGIN_USER]["todo_list"] = d
                File.open($CONFIG_PATH, "w") do |file|
                    file.write(YAML.dump(@config_file))
                end
            end

            puts text
            puts " == "

        rescue Interrupt => e
        end
    end

    def todo_show
        d = @config_file["member"][$LOGIN_USER]["todo_list"]

        puts ""
        puts " == "
        for todo in d
            idx = d.index(todo) + 1
            name = todo["name"]
            deadline = todo["deadline"]
            urgency = todo["urgency"]
            puts "#{idx}. #{name} (#{deadline}, #{urgency})"
        end
        puts " == " 
    end

    def todo_update
        d = @config_file["member"][$LOGIN_USER]["todo_list"]
        flag = false
        type = "index"
        select_todo = nil

        begin
            todo_show
            print " * Select the number or name of your to do to update: "
            select = gets.chomp
            text = "[Warning] There is no To do with #{type} '#{select}'"

            if select.to_i == 0
                type = "name"
                for todo in d
                    idx = d.index(todo)
                    if todo["name"] == select
                        flag = true
                        select_todo = todo
                        break
                    end 
                end    
            else
                select = select.to_i - 1
                if select < d.length
                    flag = true
                    select_todo = d[select]
                end
            end

            if flag
                flag = false
                while true 
                    puts ""
                    puts "1. Name"
                    puts "2. Deadline"
                    puts "3. Urgency"
                    puts " == "
                    print " * Select the number that you want to update: "
                    update_number = gets.chomp.to_i

                    case update_number
                    when 1
                        select_todo["name"] = input_todo_name
                        flag = true
                        break
                    when 2
                        select_todo["deadline"] = input_todo_deadline
                        flag = true
                        break
                    when 3
                        select_todo["urgency"] = urgency
                        flag = true
                        break
                    else
                        puts "[Warning] You have to enter the number 1 ~ 3."
                        puts ""
                    end
                end
            end

            if flag 
                text = " !! Successfully Update To Do with #{type} '#{select}'" 
                @config_file["member"][$LOGIN_USER]["todo_list"] = d
                File.open($CONFIG_PATH, "w") do |file|
                    file.write(YAML.dump(@config_file))
                end
            end

            puts text
            puts " == "
        
        rescue Interrupt => e
        end
    end


    private 
    def add_login(u)
        $LOGIN_USER = u
    end

    def add_todo(d)
        @config_file["member"][$LOGIN_USER]["todo_list"].push(d)
        File.open($CONFIG_PATH, "w") do |file|
            file.write(YAML.dump(@config_file))
        end
    end

    def check_account(u, p)
        begin 
            result = @config_file["member"][u]["password"] == p
        rescue
            result = false
        end

        if result
            add_login(u)
            return true
        else
            puts "[Warning] Whooops, Who are you?"
            puts ""
            return false
        end
    end

    def check_config
        @config_file["member"] == nil 
    end

    def check_deadline(dt)
        today = DateTime.Today.to_s.gsub("T", " ").split("+")[0]
        today < dt

    end

    def input_username
        regex = /^[A-z0-9]{8,32}$/

        while true
            print " * Username: " 
            username = gets.chomp
            
            if regex.match? username
                return username
            end

            puts " [Warning] Username must be more than 8 characters with roman alphabet and digit."
            puts " ==  "
        end
    end

    def input_password(check_regex=false)
        regex_hash = {
            /.{8,}/ => "Password must be more than 8 characters",
            /[A-Z]/ => "Password must contain at least one upper alphabet.",
            /[a-z]/ => "Password must contain at least one lower alphabet.",
            /[0-9]/ => "Password must contain at least one digit",
            /[\!\@\#\$\%\^\&*\(\);\"\',\/\.\~\[\]\<\>]/ => "Password must contain at least one special character.",
        }

        while true
            password = STDIN.getpass(" * Password: ")

            flag = true
            if check_regex
                regex_hash.each do |regex, error| 
                    unless regex.match? password
                        puts "[Warning] #{error}\n == "
                        flag = false
                        break
                    end
                end
                
                next if !flag
            end
            return password
        end
    end

    def input_todo_name
        regex = /.{4,}/

        while true
            print "\n * Input the name of new to do: "
            name = gets.chomp
            
            if regex.match? name
                return name
            end

            puts " [Warning] The name of new to do must be more than 4 characters."
            puts " ==  "
        end
    end

    def input_todo_deadline
        while true
            date = ""
            time = ""

            while true
                print " * Input the year of to do deadline date [YYYY-mm-dd]: "
                date = gets.chomp

                begin 
                    DateTime.strptime(date, "%Y-%m-%d")
                    break
                    
                rescue ArgumentError => e
                    puts " [Warning] Input is not match with date format [YYYY-mm-dd]"
                    puts " ==  "    
                end
            end
    
            while true
                print " * Input the year of to do deadline time [HH:MM]: "
                time = gets.chomp

                begin
                    DateTime.strptime(time, "%H:%M")
                    time += ":00"
                    break

                rescue
                    puts " [Warning] Input is not match with time format [HH:MM]"
                    puts " ==  "
                end
            end
        
            deadline = "#{date}T#{time}"        
            if deadline > DateTime.now.to_s.split("+")[0]
                return deadline
            end

            puts " [Warning] Deadline must be future than current datetime."
            puts " == "

        end
    end

    def input_urgency
        while true
            puts ""
            puts " Please select the number of priority of new to do."
            puts "1. High"
            puts "2. Medium"
            puts "3. Low"
            puts "4. Not Assigned"      
            puts " == "
            print " * select the priority: "

            urgency_number = gets.chomp.to_i
            case urgency_number
            when 1
                return "High"
            when 2
                return "Medium"
            when 3
                return "Low"
            when 4
                return "N/A"
            else
                puts "[Warning] You have to enter the number 1 ~ 4"
                puts ""
            end
        end
    end
end


# Prepare
td = ToDo.new

begin
    if td.need_install
        td.prompt_signup

    else
        while !td.prompt_signin
        end
    end

rescue Interrupt
    puts ""
else
    # Main
    while true
        begin
            main_number = td.main

        rescue Interrupt => e
            puts ""
            puts ""
            break if td.prompt_signout
        end

        case main_number
        when 1
            td.todo_show
        when 2
            td.todo_create
        when 3 
            td.todo_update
        when 4
            td.todo_delete
        when 5
            break if td.prompt_signout
        else
            puts "[Warning] You have to enter the number 1 ~ 4"
            puts ""
        end
    end

    puts "\n [Terminate] Bye!"
end