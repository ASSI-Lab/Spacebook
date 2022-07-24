FactoryBot.define do
    factory :temp_week_day do

        factory :temp_week_day_lunedi do
            temp_dep_id     {1}
            dep_name        {'Test department'}
            day             {'Lunedì'}
            state           {'Aperto'}
            apertura        {DateTime.new(2000,9,3,8,0,0)}
            chiusura        {DateTime.new(2000,9,3,20,0,0)}
            created_at      {Time.now}
            updated_at      {Time.now}
        end

        factory :temp_week_day_martedi do
            temp_dep_id     {1}
            dep_name        {'Test department'}
            day             {'Martedì'}
            state           {'Aperto'}
            apertura        {DateTime.new(2000,9,3,8,0,0)}
            chiusura        {DateTime.new(2000,9,3,20,0,0)}
            created_at      {Time.now}
            updated_at      {Time.now}
        end

        factory :temp_week_day_mercoledi do
            temp_dep_id     {1}
            dep_name        {'Test department'}
            day             {'Mercoledì'}
            state           {'Aperto'}
            apertura        {DateTime.new(2000,9,3,8,0,0)}
            chiusura        {DateTime.new(2000,9,3,20,0,0)}
            created_at      {Time.now}
            updated_at      {Time.now}
        end

        factory :temp_week_day_giovedi do
            temp_dep_id     {1}
            dep_name        {'Test department'}
            day             {'Giovedì'}
            state           {'Aperto'}
            apertura        {DateTime.new(2000,9,3,8,0,0)}
            chiusura        {DateTime.new(2000,9,3,20,0,0)}
            created_at      {Time.now}
            updated_at      {Time.now}
        end

        factory :temp_week_day_venerdi do
            temp_dep_id     {1}
            dep_name        {'Test department'}
            day             {'Venerdì'}
            state           {'Aperto'}
            apertura        {DateTime.new(2000,9,3,8,0,0)}
            chiusura        {DateTime.new(2000,9,3,20,0,0)}
            created_at      {Time.now}
            updated_at      {Time.now}
        end

        factory :temp_week_day_sabato do
            temp_dep_id     {1}
            dep_name        {'Test department'}
            day             {'Sabato'}
            state           {'Chiuso'}
            apertura        {DateTime.new(2000,9,3,0,0,0)}
            chiusura        {DateTime.new(2000,9,3,0,0,0)}
            created_at      {Time.now}
            updated_at      {Time.now}
        end

        factory :temp_week_day_domenica do
            temp_dep_id     {1}
            dep_name        {'Test department'}
            day             {'Domenica'}
            state           {'Chiuso'}
            apertura        {DateTime.new(2000,9,3,0,0,0)}
            chiusura        {DateTime.new(2000,9,3,0,0,0)}
            created_at      {Time.now}
            updated_at      {Time.now}
        end

    end
end