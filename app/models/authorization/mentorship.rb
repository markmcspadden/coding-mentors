module Authorization
  module Mentorship
    module InstanceMethods      
      def is_updatable_by(user, parent=nil)
        self.sender == user || self.receiver == user
      end

      def is_deletable_by(user, parent=nil)
        false
      end

      def is_readable_by(user, parent=nil)
        user.is_admin?
      end
    end

    module SingletonMethods
      def is_creatable_by(user, parent=nil)
        true
      end
    
      def is_indexable_by(user, parent=nil)
        user.is_admin?
      end
    end
    
  end
end