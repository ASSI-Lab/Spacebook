Canard::Abilities.for(:manager) do
    can  [:show, :edit, :create, :update, :destroy], Reservation
    can  [:new, :create, :update, :destroy], Department
end
