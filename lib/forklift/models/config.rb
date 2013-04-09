module Forklift
  class Config

    def initialize
      @data = {}
      set_defaults
    end

    def defaults
      {
        :project_root => Dir.pwd,
        :threads => 4,
        :lock_with_pid? => true,

        :final_database => {},
        :local_database => {},
        :forklift_data_table => '_forklift',
        
        :verbose? => true,

        :do_checks? => true,
        :do_extract? => true,
        :do_transform? => true,
        :do_load? => true,
        :do_email? => false,
        :do_dump? => false,
      }
    end

    def set_defaults
      defaults.each do |k,v|
        set(k,v)
      end
    end

    def set(k,v)
      @data[k] = v
    end

    def get(k)
      @data[k]
    end

    def values
      values = []
      @data.each do |k,v|
        values << k
      end
      values
    end

  end
end