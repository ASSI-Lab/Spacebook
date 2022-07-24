FactoryBot.define do
    factory :temp_sp do
        
        factory :temp_sp_1  do
            temp_dep_id         {1}
            dep_name            {'Test department'}
            typology            {'aula'}
            name                {'1'}
            description         {'aula 1'}
            floor               {0}
            number_of_seats     {2}
            state               {'active'}
            created_at          {Time.now}
            updated_at          {Time.now}
        end

        factory :temp_sp_2  do
            temp_dep_id         {1}
            dep_name            {'Test department'}
            typology            {'aula'}
            name                {'2'}
            description         {'aula 2'}
            floor               {0}
            number_of_seats     {2}
            state               {'active'}
            created_at          {Time.now}
            updated_at          {Time.now}
        end
    end
end