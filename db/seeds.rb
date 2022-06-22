# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Creazione degli utenti base. Effettuate l'accesso con questi dati per eventuali test.
User.create(email: "fra.user@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 0)
User.create(email: "donia.user@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 0)
User.create(email: "michela.user@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 0)
User.create(email: "matteo.user@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 0)

# Creazione degli utenti manager. Effettuate l'accesso con questi dati per eventuali test.
User.create(email: "fra.manager@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)
User.create(email: "donia.manager@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)
User.create(email: "michela.manager@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)
User.create(email: "matteo.manager@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)


# Insieme dei dati per creare i dipartimenti
dep_set = [
    {user_id: User.where(email: "fra.manager@gmail.com").first.id, name: "Ed.M.Polo Fra", manager: "fra.manager@gmail.com", 
     via: "Viale dello Scalo S. Lorenzo", civico: 82, cap: "00159", citta: "Roma", provincia: "RM", 
     description: "Per gestire o testare questo dipartimento accedi come 'fra.manager@gmail.com'", 
     floors: 4, number_of_spaces: 20, slot: 11},
    
    {user_id: User.where(email: "matteo.manager@gmail.com").first.id, name: "Ed.M.Polo Matt", manager: "matteo.manager@gmail.com", 
     via: "Viale dello Scalo S. Lorenzo", civico: 83, cap: "00159", citta: "Roma", provincia: "RM", 
     description: "Per gestire o testare questo dipartimento accedi come 'matteo.manager@gmail.com'", 
     floors: 4, number_of_spaces: 20, slot: 11},
    
    {user_id: User.where(email: "michela.manager@gmail.com").first.id, name: "Ed.M.Polo Mic", manager: "michela.manager@gmail.com", 
     via: "Viale dello Scalo S. Lorenzo", civico: 84, cap: "00159", citta: "Roma", provincia: "RM", 
     description: "Per gestire o testare questo dipartimento accedi come 'michela.manager@gmail.com'", 
     floors: 4, number_of_spaces: 20, slot: 11},
    
    {user_id: User.where(email: "donia.manager@gmail.com").first.id, name: "Ed.M.Polo Don", manager: "donia.manager@gmail.com", 
     via: "Viale dello Scalo S. Lorenzo", civico: 85, cap: "00159", citta: "Roma", provincia: "RM", 
     description: "Per gestire o testare questo dipartimento accedi come 'donia.manager@gmail.com'", 
     floors: 4, number_of_spaces: 20, slot: 11}
]

# Creazione dei dipartimenti
dep_set.each do |dep|
  Department.create(dep)
end


# Insieme dei dati per creare gli orari
wd_set = [
    {department_id: Department.where(name: "Ed.M.Polo Fra").first.id, dep_name: "Ed.M.Polo Fra", day: "Lunedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Fra").first.id, dep_name: "Ed.M.Polo Fra", day: "Martedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Fra").first.id, dep_name: "Ed.M.Polo Fra", day: "Mercoledì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Fra").first.id, dep_name: "Ed.M.Polo Fra", day: "Giovedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Fra").first.id, dep_name: "Ed.M.Polo Fra", day: "Venerdì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Fra").first.id, dep_name: "Ed.M.Polo Fra", day: "Sabato", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Fra").first.id, dep_name: "Ed.M.Polo Fra", day: "Domenica", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},

    {department_id: Department.where(name: "Ed.M.Polo Matt").first.id, dep_name: "Ed.M.Polo Matt", day: "Lunedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Matt").first.id, dep_name: "Ed.M.Polo Matt", day: "Martedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Matt").first.id, dep_name: "Ed.M.Polo Matt", day: "Mercoledì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Matt").first.id, dep_name: "Ed.M.Polo Matt", day: "Giovedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Matt").first.id, dep_name: "Ed.M.Polo Matt", day: "Venerdì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Matt").first.id, dep_name: "Ed.M.Polo Matt", day: "Sabato", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Matt").first.id, dep_name: "Ed.M.Polo Matt", day: "Domenica", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},

    {department_id: Department.where(name: "Ed.M.Polo Mic").first.id, dep_name: "Ed.M.Polo Mic", day: "Lunedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Mic").first.id, dep_name: "Ed.M.Polo Mic", day: "Martedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Mic").first.id, dep_name: "Ed.M.Polo Mic", day: "Mercoledì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Mic").first.id, dep_name: "Ed.M.Polo Mic", day: "Giovedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Mic").first.id, dep_name: "Ed.M.Polo Mic", day: "Venerdì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Mic").first.id, dep_name: "Ed.M.Polo Mic", day: "Sabato", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Mic").first.id, dep_name: "Ed.M.Polo Mic", day: "Domenica", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},
    
    {department_id: Department.where(name: "Ed.M.Polo Don").first.id, dep_name: "Ed.M.Polo Don", day: "Lunedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Don").first.id, dep_name: "Ed.M.Polo Don", day: "Martedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Don").first.id, dep_name: "Ed.M.Polo Don", day: "Mercoledì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Don").first.id, dep_name: "Ed.M.Polo Don", day: "Giovedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Don").first.id, dep_name: "Ed.M.Polo Don", day: "Venerdì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Don").first.id, dep_name: "Ed.M.Polo Don", day: "Sabato", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},
    {department_id: Department.where(name: "Ed.M.Polo Don").first.id, dep_name: "Ed.M.Polo Don", day: "Domenica", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},

]

# Creazione degli orari
wd_set.each do |wd|
    WeekDay.create(wd)
end


# Insieme dei dati per creare gli spazi
sp_set = [
    {department_id: Department.where(name: "Ed.M.Polo Fra").first.id, dep_name: "Ed.M.Polo Fra", typology: "Isola", name: "D", description: "Prese di corrente inutili", floor: 1, number_of_seats: 2, state: "Abilitato"},
    {department_id: Department.where(name: "Ed.M.Polo Fra").first.id, dep_name: "Ed.M.Polo Fra", typology: "Aula", name: "106", description: "Prese di corrente inutili", floor: 1, number_of_seats: 4, state: "Abilitato"},

    {department_id: Department.where(name: "Ed.M.Polo Matt").first.id, dep_name: "Ed.M.Polo Matt", typology: "Isola", name: "D", description: "Prese di corrente inutili", floor: 1, number_of_seats: 2, state: "Abilitato"},
    {department_id: Department.where(name: "Ed.M.Polo Matt").first.id, dep_name: "Ed.M.Polo Matt", typology: "Aula", name: "106", description: "Prese di corrente inutili", floor: 1, number_of_seats: 4, state: "Abilitato"},

    {department_id: Department.where(name: "Ed.M.Polo Mic").first.id, dep_name: "Ed.M.Polo Mic", typology: "Isola", name: "D", description: "Prese di corrente inutili", floor: 1, number_of_seats: 2, state: "Abilitato"},
    {department_id: Department.where(name: "Ed.M.Polo Mic").first.id, dep_name: "Ed.M.Polo Mic", typology: "Aula", name: "106", description: "Prese di corrente inutili", floor: 1, number_of_seats: 4, state: "Abilitato"},

    {department_id: Department.where(name: "Ed.M.Polo Don").first.id, dep_name: "Ed.M.Polo Don", typology: "Isola", name: "D", description: "Prese di corrente inutili", floor: 1, number_of_seats: 2, state: "Abilitato"},
    {department_id: Department.where(name: "Ed.M.Polo Don").first.id, dep_name: "Ed.M.Polo Don", typology: "Aula", name: "106", description: "Prese di corrente inutili", floor: 1, number_of_seats: 4, state: "Abilitato"},
]

# Creazione degli spazi
sp_set.each do |sp|
    Space.create(sp)
end

# Creazione dei posti
Department.all.each do |department| 

    @week_days = WeekDay.where(department_id: department.id) # Raccoglie gli orari del dipartimento
    @spaces = Space.where(department_id: department.id)      # Raccoglie gli spazi del dipartimento

    # Per ogni spazio
    @spaces.each do |sp|
        # Per ogni giorno della settimana
        @week_days.each do |wd|
            # Se in questo giorno è aperto
            if (wd.state == "Aperto")

                @day = wd.day               # (1)
                @monday = Date.today.monday # (2)
                # Tramite (1) & (2) sopra riportati calcola la data da inserire a seconda dei casi:

                if (@day=="Lunedì")         # Calcola la data del prossimo lunedì
                    if @monday.past?
                        @date = @monday + 7
                    else
                        @date = @monday
                    end
                elsif (@day=="Martedì")     # Calcola la data del prossimo martedì
                    if (@monday+1).past?
                        @date = @monday + 8
                    else
                        @date = @monday + 1
                    end
                elsif (@day=="Mercoledì")   # Calcola la data del prossimo mercoledì
                    if (@monday+2).past?
                        @date = @monday + 9
                    else
                        @date = @monday + 2
                    end
                elsif (@day=="Giovedì")     # Calcola la data del prossimo giovedì
                    if (@monday+3).past?
                        @date = @monday + 10
                    else
                        @date = @monday + 3
                    end
                elsif (@day=="Venerdì")     # Calcola la data del prossimo venerdì
                    if (@monday+4).past?
                        @date = @monday + 11
                    else
                        @date = @monday + 4
                    end
                elsif (@day=="Sabato")      # Calcola la data del prossimo sabato
                    if (@monday+5).past?
                        @date = @monday + 12
                    else
                        @date = @monday + 5
                    end
                elsif (@day=="Domenica")    # Calcola la data della prossima domenica
                    if (@monday+6).past?
                        @date = @monday + 13
                    else
                        @date = @monday + 6
                    end
                end
                
                # Per ogni slot di ore minime consecutive
                ((wd.chiusura.hour-wd.apertura.hour)-(department.slot-1)).times do |h| # Es. (20:00 - 08:00) = 12 quanti slot da 11h minime consecutive rientrano nelle 12 ore? 2... quello dalle 08:00 alle 19:00 e quello dalle 09:00 alle 20:00
                
                    @start_date = DateTime.new(@date.year,@date.mon,@date.mday,wd.apertura.hour+h,0,0)                # Il giorno + L'orario d'inizio del posto
                    @end_date = DateTime.new(@date.year,@date.mon,@date.mday,wd.apertura.hour+h+department.slot,0,0) # Il giorno + L'orario di fine del posto
                    
                    # Per ogni posto dello spazio
                    sp.number_of_seats.times do |pos| # Crea i posti relativi ad una settimana dal momento della creazione
                        Seat.create(space_id: sp.id, dep_name: department.name, typology: sp.typology, space_name: sp.name, position: pos+1, start_date: @start_date, end_date: @end_date, state: "Active")
                    end
                end
            end
        end
    end
end