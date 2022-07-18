module UsersHelper
    def ban_status(user)
        if user.access_locked?
            return 'Sblocca'
        else
            return 'Blocca'
        end
    end

    def manager_status(user)
        if user.is_manager?
            return 'Rimuovi da Manager'
        else
            return 'Rendi Manager'
        end
    end
end