Canard::Abilities.for(:base_user) do
    can  [:show, :edit, :create, :update, :destroy], Reservation
    cannot  [:new, :create, :update, :destroy], Department
    cannot  [:new, :create, :update, :destroy], TempDep
end