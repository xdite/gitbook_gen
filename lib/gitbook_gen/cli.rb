require "thor"
require 'active_support/core_ext/string'
module GitbookGen
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../../../",__FILE__)
    end


    desc "book NAME", "建立目录夹"
    def book(original_name, number = 10)
      name = original_name.dup.gsub!(" ", "_").underscore

      empty_directory name # 新增目录

      opts = { :name => name, :original_name => original_name }
      template "templates/Makefile.tt", "#{name}/Makefile", opts
      # 新增 Makefile

      template "templates/book.json.tt","#{name}/book.json", opts
      # 产生 book.json

      template "templates/SUMMARY.md.tt", "#{name}/SUMMARY.md",opts
      # 产生 Summary

      # 产生章节
      append_to_file  "#{name}/SUMMARY.md","\n\n"
      append_to_file  "#{name}/SUMMARY.md","* [Introduction](00-introduction.md)\n"
      template "templates/00-introduction.md.tt", "#{name}/00-introduction.md",opts
      append_to_file  "#{name}/SUMMARY.md","* [Author](00-about-author.md)\n"
      template "templates/00-about-author.md.tt", "#{name}/00-about-author.md",opts
      append_to_file  "#{name}/SUMMARY.md","* [Acknowledgements](00-acknowledgements.md)\n"
      template "templates/00-acknowledgements.md.tt", "#{name}/00-acknowledgementsd",opts

      append_to_file "#{name}/SUMMARY.md" do
        content = ""
        for i in 1..number.to_i
          digit = "%02d" % i
          content << "* [#{digit}](#{digit}.md)\n"
          create_file "#{name}/#{digit}.md"
        end
        content
      end

      display_name(name)
    end

    private

    def display_name(name)
      puts name
    end

  end

end
