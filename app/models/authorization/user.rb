module Authorization
  module User
    module InstanceMethods
      def administrator?
        false
      end
      alias is_admin? administrator?
      
      def is_updatable_by(user, parent=nil)
        user.eql?(self)
      end

      def is_deletable_by(user, parent=nil)
        false
      end

      def is_readable_by(user, parent=nil)
        true
      end
    end

    module SingletonMethods
      def is_creatable_by(user, parent=nil)
        true
      end
    
      def is_indexable_by(user, parent=nil)
        true
      end
    end
    
  end
end