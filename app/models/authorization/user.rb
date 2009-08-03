module Authorization
  module User
    module InstanceMethods
      def is_updatable_by(user)
        user.eql?(self)
      end

      def is_deletable_by(user)
        false
      end

      def is_readable_by(user, object = nil)
        true
      end
    end

    module SingletonMethods
      def is_creatable_by(user)
        true
      end
    
      def is_indexable_by(user, parent = nil)
        true
      end
    end
    
  end
end