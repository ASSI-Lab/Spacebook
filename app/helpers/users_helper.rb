module UsersHelper
    def ban_status(user)
        if user.access_locked?
            return 'Sblocca'
        else
            return 'Blocca'
        end
    end
end