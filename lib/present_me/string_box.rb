# -*- coding: utf-8 -*-
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
    chars = %W[| - + + + +]
    BoxChars.new(*chars)
  end

  def double_style
    chars = %W[║ ═ ╔ ╚ ╗ ╝]
    BoxChars.new(*chars)
  end

  def rounded_style
    chars = %W[│ ─ ╭ ╰ ╮ ╯]
    BoxChars.new(*chars)
  end

  def parse_content(content)
    parsed = content.is_a?(Enumerable) ? content : content.to_s.each_line
    parsed.map(&:strip)
  end


end

BoxChars = Struct.new(:v, :h, :l_up, :l_down, :r_up, :r_down)
