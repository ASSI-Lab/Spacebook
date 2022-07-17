# Eseguire in ordine questi comandi per avere i dati contenuti in questo seed nel database 
#
# 1) rake db:drop    (Elimina il db)
# 2) rake db:migrate (Genera lo schema e le tabelle vuote del nostro db tramite le migrazioni)
# 3) rake db:seed    (Popola il db con i dati nel seed. Ci mette circa 16 secondi con questi dati)
#
# Se volete cambiare alcuni dati nel seed assicuratevi che siano della giusta tipologia relativa al campo che state inserendo

# Creazione degli utenti base. Effettuate l'accesso con questi dati per eventuali test.
User.create(email: "fra.user@gmail.com",     password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 4)
User.create(email: "matteo.user@gmail.com",  password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 4)
User.create(email: "michela.user@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 4)
User.create(email: "donia.user@gmail.com",   password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 4)

# Creazione degli utenti manager. Effettuate l'accesso con questi dati per eventuali test.
@fra_man = User.create(email: "fra.manager@gmail.com",     password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)
@mat_man = User.create(email: "matteo.manager@gmail.com",  password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)
@mic_man = User.create(email: "michela.manager@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)
@don_man = User.create(email: "donia.manager@gmail.com",   password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)

# Creazione degli utenti admin. Effettuate l'accesso con questi dati per eventuali test.
User.create(email: "fra.admin@gmail.com",     password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)
User.create(email: "matteo.admin@gmail.com",  password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)
User.create(email: "michela.admin@gmail.com", password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)
User.create(email: "donia.admin@gmail.com",   password: "password", created_at: Time.zone.now, confirmed_at: Time.zone.now, roles_mask: 1)

# Insieme dei dati per creare i dipartimenti
dep_set = [

    {user_id: @fra_man.id, name: "Dipartimento di Francesco", manager: @fra_man.email, 
     via: "Piazzale Aldo Moro", civico: "5", cap: "00185", citta: "Roma", provincia: "RM", latitude: "41.9012777", longitude: "12.5145879", 
     description: "Per gestire o testare questo dipartimento accedi come 'fra.manager@gmail.com'", 
     floors: 4, number_of_spaces: 2},

    {user_id: @mat_man.id, name: "Dipartimento di Matteo", manager: @mat_man.email, 
     via: "Viale dello Scalo S. Lorenzo", civico: "82", cap: " 00159", citta: "Roma", provincia: "RM", latitude: "41.89684", longitude: "12.5213", 
     description: "Per gestire o testare questo dipartimento accedi come 'matteo.manager@gmail.com'", 
     floors: 4, number_of_spaces: 2},

    {user_id: @mic_man.id, name: "Dipartimento di Michela", manager: @mic_man.email,
     via: "Via Carlo Fea", civico: "2", cap: "00161", citta: "Roma", provincia: "RM", latitude: "41.9186778", longitude: "12.5175380", 
     description: "Per gestire o testare questo dipartimento accedi come 'michela.manager@gmail.com'", 
     floors: 4, number_of_spaces: 2},

    {user_id: @don_man.id, name: "Dipartimento di Donia", manager: @don_man.email, 
     via: "Via Eudossiana", civico: "18", cap: "00184", citta: "Roma", provincia: "RM", latitude: "41.8932591", longitude: "12.4930178", 
     description: "Per gestire o testare questo dipartimento accedi come 'donia.manager@gmail.com'", 
     floors: 4, number_of_spaces: 2}

]

# Creazione dei dipartimenti e dei relativi orari, spazi e posti
dep_set.each do |dep|
    @curr_dep = Department.create(dep)

    # Insieme dei dati per creare gli orari
    wd_set = [
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, day: "Lunedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, day: "Martedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, day: "Mercoledì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, day: "Giovedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, day: "Venerdì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,13,0,0)},
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, day: "Sabato", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, day: "Domenica", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},
    ]

    # Creazione degli orari
    wd_set.each do |wd|
        WeekDay.create(wd)
    end

    # Insieme dei dati per creare gli spazi
    sp_set = [
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, typology: "Isola", name: "D", description: "Prese di corrente inutili", floor: 1, number_of_seats: 2, state: "Abilitato"},
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, typology: "Isola", name: "C", description: "Prese di corrente ancora più inutili", floor: 1, number_of_seats: 2, state: "Abilitato"},
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, typology: "Aula", name: "106", description: "Microfono non funzionante", floor: 1, number_of_seats: 4, state: "Abilitato"},
        {department_id: @curr_dep.id, dep_name: @curr_dep.name, typology: "Aula", name: "204", description: "Forma strana", floor: 2, number_of_seats: 8, state: "Abilitato"}
    ]

    # Creazione degli spazi
    sp_set.each do |sp|
        sp = Space.create(sp)

        # Creazione dei posti relativi allo spazio appena creato

        # Per ogni giorno della settimana
        WeekDay.where(department_id: @curr_dep.id).each do |wd|
            # Se in questo giorno il dipartimento è aperto
            if (wd.state == "Aperto")

                # Tramite (1) & (2) sotto riportati calcola la data da inserire a seconda del giorno per il quale si vogliono creare i posti.
                @day = wd.day               # (1) Il giorno per il quale voglio creare i posti
                @monday = Date.today.monday # (2) Il lunedì di questa settimana

                if (@day=="Lunedì")         # Calcola la data del   prossimo lunedì
                    if @monday.past?
                        @date = @monday + 7
                    else
                        @date = @monday
                    end
                elsif (@day=="Martedì")     # Calcola la data del   prossimo martedì
                    if (@monday+1).past?
                        @date = @monday + 8
                    else
                        @date = @monday + 1
                    end
                elsif (@day=="Mercoledì")   # Calcola la data del   prossimo mercoledì
                    if (@monday+2).past?
                        @date = @monday + 9
                    else
                        @date = @monday + 2
                    end
                elsif (@day=="Giovedì")     # Calcola la data del   prossimo giovedì
                    if (@monday+3).past?
                        @date = @monday + 10
                    else
                        @date = @monday + 3
                    end
                elsif (@day=="Venerdì")     # Calcola la data del   prossimo venerdì
                    if (@monday+4).past?
                        @date = @monday + 11
                    else
                        @date = @monday + 4
                    end
                elsif (@day=="Sabato")      # Calcola la data del   prossimo sabato
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

                # Per ogni slot da un ora contenuto negli orari di (1)
                ((wd.chiusura.hour-wd.apertura.hour)).times do |h|
                    @start_date = DateTime.new(@date.year, @date.mon, @date.mday, wd.apertura.hour+h, 0, 0) # Data e orario d'inizio del posto
                    @end_date = DateTime.new(@date.year, @date.mon, @date.mday, wd.apertura.hour+h+1, 0, 0) # Data e orario di fine del posto

                    # Crea i posti relativi ad una settimana dal momento della creazione
                    Seat.create(space_id: sp.id, dep_name: @curr_dep.name, typology: sp.typology, space_name: sp.name, position: 1, start_date: @start_date, end_date: @end_date, state: "Active")
                end
            end
        end
    end
end