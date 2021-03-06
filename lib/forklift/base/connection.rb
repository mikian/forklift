module Forklift
  module Base
    class Connection

      def initialize(config)
        @config = config
      end

      def config
        @config
      end

      def client
        @client
      end

      def connect
        # Will define @client
        raise 'not implemented'
      end

      def disconnect
        raise 'not implemented'
      end

      def read(query)
        # will return an array of data rows
        raise 'not implemented'
      end

      def write(data, collection)
        # will write array data to collection (table)
        raise 'not implemented'
      end

      def pipe
        # when copying within the same connection, this method can be defined to speed things up
        raise 'not implemented'
      end

      def exec(path, *args)
        begin
          exec!(path, &args)
        rescue Exception => e
          forklift.logger.log(e)
        end
      end

      def exec!(path, *args)
        forklift.logger.log "Running script: #{path}"
        extension = path.split(".").last
        if(extension == "rb" || extension == "ruby")
          exec_ruby(path, *args)
        else
          exec_script(path, *args)
        end
      end

      def exec_ruby(path, *args)
        klass = forklift.utils.class_name_from_file(path)
        require path
        model = eval("#{klass}.new")
        model.do!(self, forklift, *args)
      end

      def exec_script(path, *args)
        raise 'not implemented'
      end

    end
  end
end
