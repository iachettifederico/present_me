# -*- coding: utf-8 -*-
module Kernel
  alias old_puts puts

  def ¡present(*args)
    unless defined? @output
      old_puts <<CONSOLE
╔════════════════╗
║ Console Output ║
╚════════════════╝

CONSOLE
    end
    @output = true

    old_puts(*args)
  end

  def puts(*args)
    c = caller.last.split(':')
    args.each do |arg|
      ¡present("[#{c[1]}] #{arg}")
    end
    args.count == 1 ? args.first : args
  end

  def ¡space(n=1)
    n.times { ¡present }
  end
  
  def ¡box(content, style=:simple)
    ¡present StringBox.new(content, style).call #.each do |line|
    #  ¡present line
    #end
  end


  alias old_method_missing method_missing
  def method_missing(method, *args, &block)
    if /¡¡.*/ === method.to_s
      #no-op
    elsif /¡.*/ === method.to_s and !args.empty?
      define_singleton_method(method) do
        ¡present args
      end

      args.join(' ')
    else
      old_method_missing(method, *args, &block)
    end
  end
end

class StringBox 
  def initialize(content, style=:simple)
    @chars     = send("#{style}_style".to_sym)
    @content   = parse_content(content)
    @max_width = @content.max { |line| line.size }.strip.size
  end

  def call
    result = []

    result << "#{@chars.l_up}#{@chars.h*(@max_width+2)}#{@chars.r_up}"
    result += @content.map do |line|
      "#{@chars.v} %-#{@max_width}s #{@chars.v}" % [line]
    end
    result << "#{@chars.l_down}#{@chars.h*(@max_width+2)}#{@chars.r_down}"

    result.join("\n")
  end

  private

  def simple_style
    chars = %W[│ ─ ┌ └ ┐ ┘]
    BoxChars.new(*chars)
  end

  def txt_style
    chars = %W[| - - - - -]
    BoxChars.new(*chars)
  end

  def parse_content(content)
    parsed = content.is_a?(Enumerable) ? content : content.to_s.each_line
    parsed.map(&:strip)
  end


end

BoxChars = Struct.new(:v, :h, :l_up, :l_down, :r_up, :r_down)
