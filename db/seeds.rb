# Eseguire in ordine questi comandi per avere i dati contenuti in questo seed nel database 
#
# 1) rake db:drop    (Elimina il db)
# 2) rake db:migrate (Genera lo schema e le tabelle vuote del nostro db tramite le migrazioni)
# 3) rake db:seed    (Popola il db con i dati nel seed. Ci mette circa 16 secondi con questi dati)
#
# Se volete cambiare alcuni dati nel seed assicuratevi che siano della giusta tipologia relativa al campo che state inserendo

# Creazione degli utenti base. Effettuate l'accesso con questi dati per eventuali test.
@fra_usr = User.create(email: "fra.user@gmail.com",        password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'user')
@mat_usr = User.create(email: "matteo.user@gmail.com",     password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'user')
@mic_usr = User.create(email: "michela.user@gmail.com",    password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'user')
@don_usr = User.create(email: "donia.user@gmail.com",      password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'user', )

# Creazione degli utenti manager. Effettuate l'accesso con questi dati per eventuali test.
@fra_man = User.create(email: "fra.manager@gmail.com",     password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'manager')
@mat_man = User.create(email: "matteo.manager@gmail.com",  password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'manager')
@mic_man = User.create(email: "michela.manager@gmail.com", password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'manager')
@don_man = User.create(email: "donia.manager@gmail.com",   password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'manager')
@manager_vuoto = User.create(email: "test.manager@gmail.com",   password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'manager')

# Creazione degli utenti admin. Effettuate l'accesso con questi dati per eventuali test.
@fra_adm = User.create(email: "fra.admin@gmail.com",       password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'admin')
@mic_adm = User.create(email: "michela.admin@gmail.com",   password: "Password.0", created_at: Time.zone.now, confirmed_at: Time.zone.now, role: 'admin')


# Insieme dei dati per creare i dipartimenti
dep_set = [

    {user_id: @fra_man.id, name: "Dipartimento di Francesco", manager: @fra_man.email,
     via: "Piazzale Aldo Moro", civico: "5", cap: "00185", citta: "Roma", provincia: "RM", latitude: "41.9012777", longitude: "12.5145879",
     description: "Per gestire o testare questo dipartimento accedi come 'fra.manager@gmail.com'",
     floors: 4, number_of_spaces: 4
    },

    {user_id: @mat_man.id, name: "Dipartimento di Matteo", manager: @mat_man.email,
     via: "Viale dello Scalo S. Lorenzo", civico: "82", cap: "00159", citta: "Roma", provincia: "RM", latitude: "41.89684", longitude: "12.5213",
     description: "Per gestire o testare questo dipartimento accedi come 'matteo.manager@gmail.com'",
     floors: 4, number_of_spaces: 4
    },

    {user_id: @mic_man.id, name: "Dipartimento di Michela", manager: @mic_man.email,
     via: "Borgo Garibaldi", civico: "12", cap: "00041", citta: " Albano Laziale", provincia: "RM", latitude: "41.748959", longitude: "12.648700",
     description: "Per gestire o testare questo dipartimento accedi come 'michela.manager@gmail.com'",
     floors: 4, number_of_spaces: 4
    },

    {user_id: @don_man.id, name: "Dipartimento di Donia", manager: @don_man.email,
     via: "Via mura dei francesi", civico: "10", cap: "00043", citta: "Ciampino", provincia: "RM", latitude: "41.80299", longitude: "12.59893",
     description: "Per gestire o testare questo dipartimento accedi come 'donia.manager@gmail.com'",
     floors: 4, number_of_spaces: 4
    }

]

# Creazione dei dipartimenti e dei relativi orari, spazi e posti
dep_set.each do |dep|
    curr_dep = Department.create(dep)

    # Insieme dei dati per creare gli orari
    wd_set = [
        {department_id: curr_dep.id, dep_name: curr_dep.name, day: "Lunedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
        {department_id: curr_dep.id, dep_name: curr_dep.name, day: "Martedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
        {department_id: curr_dep.id, dep_name: curr_dep.name, day: "Mercoledì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
        {department_id: curr_dep.id, dep_name: curr_dep.name, day: "Giovedì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,20,0,0)},
        {department_id: curr_dep.id, dep_name: curr_dep.name, day: "Venerdì", state: "Aperto", apertura: DateTime.new(2000,3,9,8,0,0), chiusura: DateTime.new(2000,3,9,13,0,0)},
        {department_id: curr_dep.id, dep_name: curr_dep.name, day: "Sabato", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},
        {department_id: curr_dep.id, dep_name: curr_dep.name, day: "Domenica", state: "Chiuso", apertura: DateTime.new(2000,3,9,0,0,0), chiusura: DateTime.new(2000,3,9,0,0,0)},
    ]

    # Creazione degli orari
    wd_set.each do |wd|
        WeekDay.create(wd)
    end

    # Insieme dei dati per creare gli spazi
    sp_set = [
        {department_id: curr_dep.id, dep_name: curr_dep.name, typology: "Isola", name: "C", description: "Poche prese di corrente", floor: 1, number_of_seats: 2, state: "Abilitato"},
        {department_id: curr_dep.id, dep_name: curr_dep.name, typology: "Isola", name: "D", description: "Poche prese di corrente", floor: 1, number_of_seats: 2, state: "Abilitato"},
        {department_id: curr_dep.id, dep_name: curr_dep.name, typology: "Aula", name: "106", description: "Ben illuminata ", floor: 1, number_of_seats: 4, state: "Abilitato"},
        {department_id: curr_dep.id, dep_name: curr_dep.name, typology: "Aula", name: "204", description: "Molto ampia", floor: 2, number_of_seats: 8, state: "Abilitato"},
        {department_id: curr_dep.id, dep_name: curr_dep.name, typology: "Laboratorio", name: "15", description: "", floor: 1, number_of_seats: 3, state: "Abilitato"},
    ]

    # Creazione degli spazi
    sp_set.each do |sp|
        sp = Space.create(sp)

        # Creazione dei posti relativi allo spazio appena creato

        # Per ogni giorno della settimana
        WeekDay.where(department_id: curr_dep.id).each do |wd|
            # Se in questo giorno il dipartimento è aperto
            if (wd.state == "Aperto")

                # Tramite (1) & (2) sotto riportati calcola la data da inserire a seconda del giorno per il quale si vogliono creare i posti.
                @day = wd.day               # (1) Il giorno per il quale voglio creare i posti
                @monday = Date.today.monday # (2) Il lunedì di questa settimana

                @date = ((@monday+0).past?)? (@monday + 7 ) : (@monday + 0) if (@day=="Lunedì")    # Calcola la data del   prossimo lunedì
                @date = ((@monday+1).past?)? (@monday + 8 ) : (@monday + 1) if (@day=="Martedì")   # Calcola la data del   prossimo martedì
                @date = ((@monday+2).past?)? (@monday + 9 ) : (@monday + 2) if (@day=="Mercoledì") # Calcola la data del   prossimo mercoledì
                @date = ((@monday+3).past?)? (@monday + 10) : (@monday + 3) if (@day=="Giovedì")   # Calcola la data del   prossimo giovedì
                @date = ((@monday+4).past?)? (@monday + 11) : (@monday + 4) if (@day=="Venerdì")   # Calcola la data del   prossimo venerdì
                @date = ((@monday+5).past?)? (@monday + 12) : (@monday + 5) if (@day=="Sabato")    # Calcola la data del   prossimo sabato
                @date = ((@monday+6).past?)? (@monday + 13) : (@monday + 6) if (@day=="Domenica")  # Calcola la data della prossima domenica

                # Per ogni slot da un ora contenuto negli orari di (1)
                ((wd.chiusura.hour-wd.apertura.hour)).times do |h|
                    @start_date = DateTime.new(@date.year, @date.mon, @date.mday, wd.apertura.hour+h, 0, 0) # Data e orario d'inizio del posto
                    @end_date = DateTime.new(@date.year, @date.mon, @date.mday, wd.apertura.hour+h+1, 0, 0) # Data e orario di fine del posto

                    # Crea i posti relativi ad una settimana dal momento della creazione
                    seat = Seat.create(space_id: sp.id, dep_name: curr_dep.name, typology: sp.typology, space_name: sp.name, position: 1, start_date: @start_date, end_date: @end_date, state: "Active")

                    # Aggiunta di alcune prenotazioni
                    if (curr_dep.name == "Dipartimento di Donia") and (sp.typology == "Laboratorio") and (wd.day == "Venerdì")
                        Reservation.create(user_id: 1, department_id: curr_dep.id, space_id: sp.id, seat_id: seat.id, email: "fra.user@gmail.com",    dep_name: curr_dep.name, typology: sp.typology, space_name: sp.name, floor: sp.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Active")
                        seat.update(position: seat.position+1)
                        Reservation.create(user_id: 5, department_id: curr_dep.id, space_id: sp.id, seat_id: seat.id, email: "fra.manager@gmail.com", dep_name: curr_dep.name, typology: sp.typology, space_name: sp.name, floor: sp.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Active")
                        seat.update(position: seat.position+1)
                        Reservation.create(user_id: 9, department_id: curr_dep.id, space_id: sp.id, seat_id: seat.id, email: "fra.admin@gmail.com",   dep_name: curr_dep.name, typology: sp.typology, space_name: sp.name, floor: sp.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Active")
                        seat.update(position: seat.position+1)
                    end

                    if (curr_dep.name == "Dipartimento di Donia") and (sp.name == "C") and (wd.day == "Martedì")
                        Reservation.create(user_id: 1, department_id: curr_dep.id, space_id: sp.id, seat_id: seat.id, email: "donia.user@gmail.com",    dep_name: curr_dep.name, typology: sp.typology, space_name: sp.name, floor: sp.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Active")
                        seat.update(position: seat.position+1)
                        Reservation.create(user_id: 5, department_id: curr_dep.id, space_id: sp.id, seat_id: seat.id, email: "donia.manager@gmail.com", dep_name: curr_dep.name, typology: sp.typology, space_name: sp.name, floor: sp.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Active")
                        seat.update(position: seat.position+1)
                    end
                end
            end
        end
    end

end


