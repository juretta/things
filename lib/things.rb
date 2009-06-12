# == Synopsis 
# The things command can be used to create new todos from the command line
#
# == Usage
# You can pipe the to-do title into the things command:
#     echo "The new todo" | things
# OR
#     things < todo.txt # => todo.txt contains the title of the new todo
#
# You can supply an argument. In this case things assumes that the given argument is a file.
# The file content will be the note of the new todo.
#
#     things things.txt
#
# == Author
# Stefan Saasen
#
# == Copyright
# Copyright(c), 2009 Stefan Saasen juretta.com
require 'rdoc/usage'

module Things
  
  ADD_TODO_CMD = <<-TODO_CMD
  on run argv
    tell application "Things"
     set newToDo to make new to do with properties %CMD%  
    end tell 
  end run
  TODO_CMD
  
  class CLI
    def todo_with_note(note)
      things_add_todo("", note)
    end
  
    def todo_with_title(title)
      things_add_todo(title)
    end
    
    def run(args) # :nodoc:
      if STDIN.tty?
        args.size < 1 ? print_usage : todo_with_note(open(args[0]).read)
      else
        todo_with_title(STDIN.read)
      end
    end
    
    private
    def things_add_todo(title, note = nil)
      if note 
        prop = '{name: item 1 of argv, notes:item 2 of argv}'
        arg = "'#{title.strip}' '#{note.strip}'"
      else
        prop = '{name:item 1 of argv}'
        arg = "'#{title.strip}'"
      end
      lines = ADD_TODO_CMD.split("\n").inject("") do |str, line|
        line = line.gsub(/%CMD%/, prop) if line =~ /%CMD%/
        str << "-e '#{line.strip}' "
        str
      end
      cmd = "osascript #{lines} #{arg}"
      p cmd if $DEBUG
      `#{cmd}`
    end
    
    # Slightly modified from Rdoc::usage
    def print_usage # :nodoc:
      # RDoc::usage('usage') # => use the comment of the main file - this is the gem created stub... can't use it
      comment = File.open(__FILE__) do |f|
        str = ""
        f.each do |line|
          str << line if line =~ /^#/
        end
        str = str.gsub(/^\s*#/, '')
      end
      raise unless comment.size > 0
      markup = SM::SimpleMarkup.new
      flow_convertor = SM::ToFlow.new

      flow = markup.convert(comment, flow_convertor)

      format = "plain"
      flow = extract_sections(flow, %w(usage))
      options = RI::Options.instance
      formatter = options.formatter.new(options, "")
      formatter.display_flow(flow)
    end
    
    def extract_sections(flow, sections) # :nodoc:
      result = []
      sections.each do |name|
        name = name.downcase
        copy_upto_level = nil

        flow.each do |item|
          case item
          when SM::Flow::H
            if copy_upto_level && item.level >= copy_upto_level
              copy_upto_level = nil
            else
              if item.text.downcase == name
                result << item
                copy_upto_level = item.level
              end
            end
          else
            if copy_upto_level
              result << item
            end
          end
        end
      end
      if result.empty?
        puts "Note to developer: requested section(s) [#{sections.join(', ')}] " +
             "not found"
        result = flow
      end
      result
    end
  end
end
